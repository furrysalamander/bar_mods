"""Async client for an OpenAI-compatible chat-completions endpoint.

Works with local servers (llama.cpp) and cloud providers (OpenRouter, etc.).
When an API key is provided, sends it as a Bearer token.

Handles the multi-turn tool-calling loop:
  1. Send messages + tool definitions → LLM
  2. If LLM returns tool_calls → execute them locally → append results → goto 1
  3. If LLM returns a text response → return it
"""

from __future__ import annotations

import asyncio
import json
import logging
from typing import Any, Callable, Coroutine

import aiohttp
from aiohttp import ClientResponseError, ServerDisconnectedError

log = logging.getLogger(__name__)


class ToolStopSentinel:
    """Return this from a tool executor to stop the tool-calling loop.

    The ``message`` is used as the final assistant response and is also
    sent back to the LLM as the tool result (so the conversation stays
    coherent if it is ever continued).
    """

    def __init__(self, message: str) -> None:
        self.message = message


# Type alias for tool executor callbacks.
# Receives (tool_name, arguments_dict) → returns the string result
# OR a ToolStopSentinel to end the loop early.
ToolExecutor = Callable[[str, dict[str, Any]], Coroutine[Any, Any, str | ToolStopSentinel]]


class LLMClient:
    """Async wrapper around ``/v1/chat/completions`` with tool-calling support."""

    def __init__(self, base_url: str, model: str, api_key: str | None = None) -> None:
        self._base_url = base_url.rstrip("/")
        self._model = model
        self._api_key = api_key or None
        self._session: aiohttp.ClientSession | None = None

    async def _get_session(self) -> aiohttp.ClientSession:
        if self._session is None or self._session.closed:
            headers: dict[str, str] = {}
            if self._api_key:
                headers["Authorization"] = f"Bearer {self._api_key}"
            self._session = aiohttp.ClientSession(
                timeout=aiohttp.ClientTimeout(total=300),
                headers=headers or None,
            )
        return self._session

    async def close(self) -> None:
        if self._session and not self._session.closed:
            await self._session.close()

    async def chat(
        self,
        messages: list[dict[str, Any]],
        tools: list[dict[str, Any]] | None = None,
        tool_executor: ToolExecutor | None = None,
        *,
        max_rounds: int = 10,
        temperature: float = 0.7,
    ) -> str:
        """Run a full chat-completion loop, handling tool calls automatically.

        Parameters
        ----------
        messages:
            The conversation so far (system, user, assistant, tool messages).
        tools:
            OpenAI-format tool definitions.  ``None`` disables tool calling.
        tool_executor:
            Async callback ``(name, args) → str`` that executes a tool call and
            returns the result string.  Required if ``tools`` is non-empty.
        max_rounds:
            Safety limit on the number of tool-call round-trips.
        temperature:
            Sampling temperature for the LLM.

        Returns
        -------
        The final text content from the assistant.
        """
        session = await self._get_session()

        for _round in range(max_rounds):
            payload: dict[str, Any] = {
                "model": self._model,
                "messages": messages,
                "temperature": temperature,
            }
            if tools:
                payload["tools"] = tools
                payload["tool_choice"] = "auto"

            log.debug("LLM request (round %d): %d messages", _round + 1, len(messages))

            # Retry loop for transient server errors
            last_exc: Exception | None = None
            for _attempt in range(3):
                try:
                    async with session.post(
                        f"{self._base_url}/chat/completions",
                        json=payload,
                    ) as resp:
                        if resp.status != 200:
                            body = await resp.text()
                            log.error("LLM returned %d: %s", resp.status, body[:500])
                            resp.raise_for_status()
                        data = await resp.json()
                    break
                except (ServerDisconnectedError, aiohttp.ClientOSError) as exc:
                    last_exc = exc
                    wait = 2 ** _attempt
                    log.warning("LLM connection error (attempt %d/3), retrying in %ds: %s", _attempt + 1, wait, exc)
                    await asyncio.sleep(wait)
            else:
                raise last_exc  # type: ignore[misc]

            choice = data["choices"][0]
            assistant_msg = choice["message"]

            # Append the assistant's reply to the conversation
            messages.append(assistant_msg)

            # Check for tool calls
            tool_calls = assistant_msg.get("tool_calls")
            if not tool_calls:
                # No tool calls — return the text content
                return assistant_msg.get("content", "")

            if tool_executor is None:
                log.warning("LLM requested tool calls but no executor provided")
                return assistant_msg.get("content", "")

            # Execute each tool call and append results
            for tc in tool_calls:
                fn = tc["function"]
                tool_name = fn["name"]
                try:
                    tool_args = json.loads(fn["arguments"])
                except (json.JSONDecodeError, TypeError):
                    tool_args = {}

                log.info("Tool call: %s(%s)", tool_name, tool_args)

                try:
                    result = await tool_executor(tool_name, tool_args)
                except Exception as exc:
                    log.exception("Tool %s failed", tool_name)
                    result = f"Error executing tool: {exc}"

                # If the executor returned a stop sentinel, append the
                # tool result for conversation coherence, then return
                # the sentinel's message as the final response.
                if isinstance(result, ToolStopSentinel):
                    messages.append({
                        "role": "tool",
                        "tool_call_id": tc["id"],
                        "content": result.message,
                    })
                    return result.message

                messages.append({
                    "role": "tool",
                    "tool_call_id": tc["id"],
                    "content": result,
                })

        # If we exhausted rounds, find the last actual assistant text
        # rather than leaking raw tool-result data.
        log.warning("Exhausted %d tool-call rounds", max_rounds)
        for msg in reversed(messages):
            if msg.get("role") == "assistant" and msg.get("content"):
                return msg["content"]
        return "I wasn't able to finish processing your request. Please try again."
