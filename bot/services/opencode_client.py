"""Async HTTP client for the opencode server API.

Uses the async prompt + polling pattern:
  1. POST /session/:id/prompt_async  (fire-and-forget, returns 204)
  2. Poll GET /session/status until session is idle
  3. Auto-approve any permission requests via POST /session/:id/permissions/:pid
  4. GET /session/:id/message to read the results

The bot is the autonomous supervisor — it never asks the Discord user to approve
permission requests.  Everything is auto-approved.
"""

from __future__ import annotations

import asyncio
import json
import logging
from typing import Any, Callable, Coroutine

import aiohttp

log = logging.getLogger(__name__)

# Type for optional progress callbacks
StatusCallback = Callable[[str], Coroutine[Any, Any, None]] | None


class OpenCodeClient:
    """Async wrapper around the opencode server REST API.

    Endpoints documented at ``http://<host>:<port>/doc``.
    """

    def __init__(self, base_url: str, username: str = "opencode", password: str = "") -> None:
        self._base_url = base_url.rstrip("/")
        self._auth = aiohttp.BasicAuth(username, password) if password else None
        self._session: aiohttp.ClientSession | None = None
        # Background task that watches the SSE stream for permission requests
        self._event_watcher: asyncio.Task | None = None
        # Per-session completion events — set when the build agent finishes.
        # This avoids relying on status-polling which races with auto-compaction.
        self._build_done_events: dict[str, asyncio.Event] = {}

    async def _get_session(self) -> aiohttp.ClientSession:
        if self._session is None or self._session.closed:
            self._session = aiohttp.ClientSession(
                auth=self._auth,
                timeout=aiohttp.ClientTimeout(total=None),
            )
        return self._session

    async def close(self) -> None:
        if self._event_watcher and not self._event_watcher.done():
            self._event_watcher.cancel()
            try:
                await self._event_watcher
            except (asyncio.CancelledError, Exception):
                pass
        if self._session and not self._session.closed:
            await self._session.close()

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    async def _get_json(self, path: str, **kwargs: Any) -> Any:
        session = await self._get_session()
        async with session.get(f"{self._base_url}{path}", **kwargs) as resp:
            if resp.status != 200:
                body = await resp.text()
                log.error("GET %s → %d: %s", path, resp.status, body[:500])
            resp.raise_for_status()
            return await resp.json()

    async def _post_json(self, path: str, body: Any = None, **kwargs: Any) -> Any:
        session = await self._get_session()
        async with session.post(f"{self._base_url}{path}", json=body, **kwargs) as resp:
            if resp.status not in (200, 204):
                err = await resp.text()
                log.error("POST %s → %d: %s", path, resp.status, err[:500])
            resp.raise_for_status()
            if resp.status == 204:
                return None
            return await resp.json()

    # ------------------------------------------------------------------
    # Health
    # ------------------------------------------------------------------

    async def health(self) -> dict[str, Any]:
        """GET /global/health"""
        return await self._get_json("/global/health")

    # ------------------------------------------------------------------
    # Sessions
    # ------------------------------------------------------------------

    async def create_session(self, title: str | None = None) -> dict[str, Any]:
        """POST /session"""
        body: dict[str, Any] = {}
        if title:
            body["title"] = title
        return await self._post_json("/session", body)

    async def get_session(self, session_id: str) -> dict[str, Any]:
        """GET /session/:id"""
        return await self._get_json(f"/session/{session_id}")

    async def list_sessions(self) -> list[dict[str, Any]]:
        """GET /session"""
        return await self._get_json("/session")

    async def delete_session(self, session_id: str) -> bool:
        """DELETE /session/:id"""
        session = await self._get_session()
        async with session.delete(f"{self._base_url}/session/{session_id}") as resp:
            resp.raise_for_status()
            return True

    async def session_status(self) -> dict[str, Any]:
        """GET /session/status — returns ``{sessionID: SessionStatus, ...}``."""
        return await self._get_json("/session/status")

    async def abort_session(self, session_id: str) -> bool:
        """POST /session/:id/abort"""
        await self._post_json(f"/session/{session_id}/abort")
        return True

    # ------------------------------------------------------------------
    # Permission auto-approval
    # ------------------------------------------------------------------

    async def approve_permission(
        self,
        session_id: str,
        permission_id: str,
        *,
        remember: bool = True,
    ) -> bool:
        """POST /session/:id/permissions/:permissionID — auto-approve."""
        log.info("Auto-approving permission %s for session %s", permission_id, session_id)
        return await self._post_json(
            f"/session/{session_id}/permissions/{permission_id}",
            {"response": "always", "remember": remember},
        )

    # ------------------------------------------------------------------
    # SSE event watcher — auto-approves permission requests
    # ------------------------------------------------------------------

    def start_event_watcher(self) -> None:
        """Spin up a background task that listens to the SSE stream and
        auto-approves any permission requests.  Idempotent."""
        if self._event_watcher and not self._event_watcher.done():
            return
        self._event_watcher = asyncio.create_task(
            self._watch_events(), name="opencode-event-watcher"
        )

    async def _watch_events(self) -> None:
        """Long-running SSE listener.  Reconnects on failure."""
        while True:
            try:
                session = await self._get_session()
                log.info("Connecting to SSE event stream at %s/event", self._base_url)
                async with session.get(f"{self._base_url}/event") as resp:
                    resp.raise_for_status()
                    async for line in resp.content:
                        text = line.decode("utf-8", errors="replace").strip()
                        if not text or text.startswith(":"):
                            continue
                        if text.startswith("data:"):
                            data_str = text[5:].strip()
                            if not data_str:
                                continue
                            try:
                                event = json.loads(data_str)
                            except json.JSONDecodeError:
                                continue
                            await self._handle_event(event)
            except asyncio.CancelledError:
                log.info("Event watcher cancelled")
                return
            except Exception:
                log.exception("Event watcher error — reconnecting in 5s")
                await asyncio.sleep(5)

    # Event types that fire per-token — skip to avoid log spam
    _NOISY_EVENTS = frozenset({
        "message.part.delta",
        "message.delta",
    })

    async def _handle_event(self, event: dict[str, Any]) -> None:
        """Process a single SSE event.  Auto-approve permission requests and
        detect build-agent completion."""
        etype = event.get("type", "")
        props = event.get("properties", {})

        # Skip per-token streaming deltas (extremely noisy)
        if etype in self._NOISY_EVENTS:
            return

        # Log all other events so the operator can follow along
        log.info("[SSE] %s: %s", etype, json.dumps(props, default=str)[:500])

        # Detect build-agent completion via message.updated events.
        # The build agent's final message has: role=assistant, agent=build,
        # finish=stop, and a completed timestamp.  This fires BEFORE
        # auto-compaction starts, so we can signal completion immediately.
        if etype == "message.updated":
            info = props.get("info", {})
            if (
                info.get("role") == "assistant"
                and info.get("agent") == "build"
                and info.get("finish") == "stop"
                and info.get("time", {}).get("completed")
            ):
                sid = info.get("sessionID", "")
                if sid and sid in self._build_done_events:
                    log.info(
                        "Build agent completed for session %s — signalling done",
                        sid,
                    )
                    self._build_done_events[sid].set()

        # Permission request events — approve immediately
        if "permission" in etype.lower():
            log.info("Permission event: %s — %s", etype, json.dumps(props)[:300])
            session_id = props.get("sessionID", "") or props.get("session_id", "")
            perm_id = props.get("permissionID", "") or props.get("permission_id", "") or props.get("id", "")
            if session_id and perm_id:
                try:
                    await self.approve_permission(session_id, perm_id)
                except Exception:
                    log.exception("Failed to auto-approve permission %s", perm_id)
            else:
                log.warning("Permission event missing IDs: %s", event)

    # ------------------------------------------------------------------
    # Messages — async fire-and-forget pattern
    # ------------------------------------------------------------------

    async def send_prompt_async(
        self,
        session_id: str,
        text: str,
        *,
        provider_id: str | None = None,
        model_id: str | None = None,
    ) -> None:
        """POST /session/:id/prompt_async — fire-and-forget (returns 204)."""
        body: dict[str, Any] = {
            "parts": [{"type": "text", "text": text}],
        }
        if provider_id and model_id:
            body["model"] = {"providerID": provider_id, "modelID": model_id}
        await self._post_json(f"/session/{session_id}/prompt_async", body)

    async def get_messages(
        self, session_id: str, *, limit: int | None = None
    ) -> list[dict[str, Any]]:
        """GET /session/:id/message — list messages in a session."""
        params: dict[str, Any] = {}
        if limit is not None:
            params["limit"] = limit
        return await self._get_json(f"/session/{session_id}/message", params=params)

    # ------------------------------------------------------------------
    # Prompt + poll convenience method
    # ------------------------------------------------------------------

    async def prompt_and_wait(
        self,
        session_id: str,
        text: str,
        *,
        poll_interval: float = 3.0,
        timeout: float = 1800.0,
        on_status: StatusCallback = None,
    ) -> list[dict[str, Any]]:
        """Fire an async prompt and wait until the build agent finishes.

        Uses SSE event detection (``message.updated`` with ``agent=build,
        finish=stop``) to know when the build agent has completed.  This is
        immune to the auto-compaction loop that causes status-polling to
        miss the brief idle window.

        After the build step finishes, aborts the session to kill any
        compaction follow-up, then reads messages.

        Returns the full message list for the session.
        """
        # Make sure the SSE watcher is running to auto-approve permissions
        # and detect build completion events.
        self.start_event_watcher()

        # Register a completion event for this session
        done_event = asyncio.Event()
        self._build_done_events[session_id] = done_event

        try:
            await self.send_prompt_async(session_id, text)
            log.info("Prompt sent to session %s, waiting for build completion...", session_id)

            # Wait for the SSE watcher to signal build-agent completion,
            # with periodic status logging for operator visibility.
            elapsed = 0.0
            last_status = ""
            while elapsed < timeout:
                try:
                    await asyncio.wait_for(
                        done_event.wait(),
                        timeout=min(poll_interval, timeout - elapsed),
                    )
                    # Event was set — build agent finished
                    log.info(
                        "Session %s build completed (%.0fs elapsed)", session_id, elapsed
                    )
                    break
                except asyncio.TimeoutError:
                    # Event not set yet — log status for visibility
                    elapsed += poll_interval
                    try:
                        statuses = await self.session_status()
                        status_obj = statuses.get(session_id, {})
                        if isinstance(status_obj, dict):
                            current = status_obj.get("type", str(status_obj))
                        else:
                            current = str(status_obj)
                        if current != last_status:
                            last_status = current
                            log.info(
                                "Session %s status: %s (%.0fs elapsed)",
                                session_id, current, elapsed,
                            )
                            if on_status:
                                try:
                                    await on_status(current)
                                except Exception:
                                    log.exception("on_status callback error")
                    except Exception:
                        log.warning("Failed to poll session status, continuing...")
            else:
                log.warning(
                    "Timed out waiting for session %s after %.0fs", session_id, timeout
                )

            # Abort the session to kill any compaction / synthetic-continue loop
            try:
                await self.abort_session(session_id)
                log.info("Session %s aborted to stop compaction loop", session_id)
            except Exception:
                log.warning("Failed to abort session %s (may already be idle)", session_id)

            # Brief pause to let abort settle before reading messages
            await asyncio.sleep(0.5)

            messages = await self.get_messages(session_id)
            _log_opencode_messages(messages)
            return messages
        finally:
            # Clean up the completion event
            self._build_done_events.pop(session_id, None)

    # ------------------------------------------------------------------
    # Files
    # ------------------------------------------------------------------

    async def get_file_content(self, path: str) -> str:
        """GET /file/content?path=<path>

        The opencode API may return a JSON envelope like
        ``{"type": "text", "content": "..."}``.
        This method unwraps it and returns just the content string.
        Raises ``ValueError`` if the content is empty.
        """
        session = await self._get_session()
        async with session.get(
            f"{self._base_url}/file/content",
            params={"path": path},
        ) as resp:
            resp.raise_for_status()
            raw = await resp.text()

        # Attempt to unwrap a JSON envelope returned by the AI SDK
        try:
            import json
            data = json.loads(raw)
            if isinstance(data, dict) and "content" in data:
                raw = data["content"]
        except (json.JSONDecodeError, TypeError):
            pass  # Not JSON — treat raw text as the file content

        if not raw or not raw.strip():
            raise ValueError(f"File content for '{path}' is empty")

        return raw

    async def list_files(self, path: str = ".") -> Any:
        """GET /file?path=<path>"""
        return await self._get_json("/file", params={"path": path})


def _log_opencode_messages(messages: list[dict[str, Any]]) -> None:
    """Pretty-print opencode's conversation to the bot log."""
    if not messages:
        log.info("[opencode] (no messages)")
        return

    log.info("[opencode] ── conversation (%d messages) ──", len(messages))
    for i, msg in enumerate(messages, 1):
        info = msg.get("info", {})
        role = info.get("role", "unknown")
        parts = msg.get("parts", [])

        for part in parts:
            ptype = part.get("type", "")

            if ptype == "text":
                text = part.get("text", "")
                # Truncate very long texts but keep enough to be useful
                if len(text) > 2000:
                    text = text[:2000] + f"... ({len(text)} chars total)"
                log.info("[opencode] [%d/%d] %s (text): %s",
                         i, len(messages), role, text)

            elif ptype == "tool-invocation":
                tool_name = part.get("toolInvocation", {}).get("toolName", "?")
                tool_input = json.dumps(
                    part.get("toolInvocation", {}).get("input", {}),
                    default=str,
                )[:500]
                log.info("[opencode] [%d/%d] %s (tool-call): %s(%s)",
                         i, len(messages), role, tool_name, tool_input)

            elif ptype == "tool-result":
                tool_name = part.get("toolResult", {}).get("toolName", "?")
                result_text = json.dumps(
                    part.get("toolResult", {}).get("result", ""),
                    default=str,
                )[:500]
                log.info("[opencode] [%d/%d] %s (tool-result): %s → %s",
                         i, len(messages), role, tool_name, result_text)

            else:
                log.info("[opencode] [%d/%d] %s (%s): %s",
                         i, len(messages), role, ptype,
                         json.dumps(part, default=str)[:300])

    log.info("[opencode] ── end conversation ──")
