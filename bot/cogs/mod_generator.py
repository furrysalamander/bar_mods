"""Core Discord cog — handles mod requests via LLM tool-calling."""

from __future__ import annotations

import asyncio
import json
import logging
import os
import re
from typing import Any

import discord
from discord.ext import commands

from bot.config import Config
from bot.personality import load_personality
from bot.queue import ModQueue
from bot.services.llm_client import LLMClient, ToolStopSentinel
from bot.services.mod_builder import (
    build_modpack,
    encode_single_mod,
    list_available_mods,
    save_generated_mod,
    mods_dir,
)
from bot.services.opencode_client import OpenCodeClient
from bot.services.unit_search import UnitSearchIndex
from bot.tools import TOOLS

log = logging.getLogger(__name__)


class ModGenerator(commands.Cog):
    """Listens for mentions / commands and orchestrates mod generation."""

    def __init__(self, bot: commands.Bot, config: Config) -> None:
        self.bot = bot
        self.config = config
        self.llm = LLMClient(
            config.llama_api_url,
            config.llama_model_id,
            api_key=config.llm_api_key or None,
        )
        self.opencode = OpenCodeClient(
            config.opencode_url,
            username=config.opencode_username,
            password=config.opencode_password,
        )
        self.queue = ModQueue()
        self.system_prompt = load_personality(config.personality)
        self.unit_search = UnitSearchIndex()

        # Map of Discord user ID → most recent opencode session ID,
        # so users can request refinements.
        self._user_sessions: dict[int, str] = {}

        # Users currently in a clarification wait — skip their replies in on_message
        self._awaiting_reply: set[int] = set()

        # Per-channel conversation history for multi-turn support.
        # Stores (role, content) pairs — only user/assistant text, not tool internals.
        self._channel_history: dict[int, list[dict[str, str]]] = {}
        self._max_history_turns: int = 20  # max user+assistant messages kept per channel

    async def cog_load(self) -> None:
        self.queue.start()
        self.unit_search.load()

    async def cog_unload(self) -> None:
        await self.queue.stop()
        await self.llm.close()
        await self.opencode.close()

    # ------------------------------------------------------------------
    # Event listener — respond when mentioned
    # ------------------------------------------------------------------

    @commands.Cog.listener()
    async def on_message(self, message: discord.Message) -> None:
        # Ignore own messages and messages that don't mention us
        if message.author == self.bot.user:
            return
        if self.bot.user not in message.mentions:
            return

        # Skip if this user is mid-clarification (their reply is consumed by wait_for)
        if message.author.id in self._awaiting_reply:
            return

        # Strip the mention from the content
        content = message.content
        for mention_str in [f"<@{self.bot.user.id}>", f"<@!{self.bot.user.id}>"]:
            content = content.replace(mention_str, "").strip()

        if not content:
            await message.reply("Hey! Mention me with a mod request and I'll get to work. "
                                "Try something like: *make a super fast tank with double damage*")
            return

        await self._handle_request(message, content)

    # ------------------------------------------------------------------
    # Slash command alternative
    # ------------------------------------------------------------------

    @commands.command(name="mod", help="Request a new BAR mod or interact with the mod bot.")
    async def mod_command(self, ctx: commands.Context, *, request: str) -> None:
        await self._handle_request(ctx.message, request)

    # ------------------------------------------------------------------
    # Core request handler
    # ------------------------------------------------------------------

    async def _handle_request(self, message: discord.Message, user_text: str) -> None:
        """Process a user's mod request through the LLM tool-calling loop."""
        # Build the conversation
        context_block = (
            f"\n\n## Current Context\n"
            f"Available mods: {', '.join(list_available_mods())}\n"
            f"User's last opencode session: {self._user_sessions.get(message.author.id, 'none')}"
        )

        # Retrieve prior conversation history for this channel
        channel_id = message.channel.id
        history = self._channel_history.get(channel_id, [])

        messages: list[dict[str, Any]] = [
            {"role": "system", "content": self.system_prompt + context_block},
            *history,
            {"role": "user", "content": user_text},
        ]

        status_msg = await message.reply("🔧 Thinking...")

        # Track repeated tool failures to avoid infinite loops
        tool_fail_counts: dict[str, int] = {}
        MAX_TOOL_FAILURES = 2
        responded_via_tool = False  # set when 'respond' tool already sent the message

        async def execute_tool(name: str, args: dict[str, Any]) -> str | ToolStopSentinel:
            """Execute a tool call and return the result string."""
            nonlocal responded_via_tool
            """Execute a tool call and return the result string."""
            try:
                result = await self._execute_tool(name, args, message, status_msg)
                tool_fail_counts.pop(name, None)  # reset on success
                if isinstance(result, ToolStopSentinel):
                    responded_via_tool = True
                return result
            except Exception as exc:
                log.exception("Tool execution error: %s", name)
                tool_fail_counts[name] = tool_fail_counts.get(name, 0) + 1
                if tool_fail_counts[name] >= MAX_TOOL_FAILURES:
                    return (f"Error: {exc}. This tool has failed {tool_fail_counts[name]} times. "
                            f"Do NOT call {name} again. Tell the user about the error instead.")
                return f"Error: {exc}"

        try:
            response = await self.llm.chat(
                messages=messages,
                tools=TOOLS,
                tool_executor=execute_tool,
                max_rounds=8,
            )

            # Persist this turn in channel history (only user/assistant text,
            # not tool-call internals) so future requests have context.
            self._append_history(channel_id, "user", user_text)
            self._append_history(channel_id, "assistant", response or "")

            # Send the final response (skip if 'respond' tool already sent it)
            if response and not responded_via_tool:
                # Guard: don't leak raw tool results (e.g. unit search data)
                # to Discord if the LLM never produced a proper response.
                if response.startswith("Found ") and "---" in response:
                    log.warning("Suppressed raw tool result from being sent to Discord")
                    await status_msg.edit(
                        content="I found the information but ran into a processing issue. "
                                "Could you try asking again?"
                    )
                else:
                    # Discord has a 2000 char limit
                    for chunk in _split_message(response):
                        await message.reply(chunk)
        except Exception:
            log.exception("Error handling request")
            await status_msg.edit(content="❌ Something went wrong processing your request. Check the logs.")

    # ------------------------------------------------------------------
    # Conversation history helpers
    # ------------------------------------------------------------------

    def _append_history(self, channel_id: int, role: str, content: str) -> None:
        """Append a message to the channel's conversation history, trimming if needed."""
        if channel_id not in self._channel_history:
            self._channel_history[channel_id] = []
        self._channel_history[channel_id].append({"role": role, "content": content})
        # Trim oldest messages, keeping pairs intact (drop 2 at a time)
        while len(self._channel_history[channel_id]) > self._max_history_turns:
            self._channel_history[channel_id].pop(0)

    # ------------------------------------------------------------------
    # Tool execution dispatch
    # ------------------------------------------------------------------

    async def _execute_tool(
        self,
        name: str,
        args: dict[str, Any],
        message: discord.Message,
        status_msg: discord.Message,
    ) -> str:
        """Dispatch a tool call to the appropriate handler."""
        if name == "clarify_request":
            return await self._tool_clarify(args, message, status_msg)
        elif name == "generate_mod":
            return await self._tool_generate(args, message, status_msg)
        elif name == "refine_mod":
            return await self._tool_refine(args, message, status_msg)
        elif name == "build_modpack":
            return await self._tool_build(args, message, status_msg)
        elif name == "list_mods":
            return await self._tool_list_mods(args, message, status_msg)
        elif name == "respond":
            return await self._tool_respond(args, message, status_msg)
        elif name == "search_units":
            return await self._tool_search_units(args, message, status_msg)
        else:
            return f"Unknown tool: {name}"

    # ------------------------------------------------------------------
    # Tool implementations
    # ------------------------------------------------------------------

    async def _tool_clarify(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str:
        question = args.get("question", "Could you tell me more about what you want?")
        await status_msg.edit(content=f"❓ {question}")

        # Wait for the user's reply (up to 5 minutes)
        def check(m: discord.Message) -> bool:
            return m.author == message.author and m.channel == message.channel

        self._awaiting_reply.add(message.author.id)
        try:
            reply = await self.bot.wait_for("message", check=check, timeout=300)
            # Persist the clarification reply so future turns have context
            self._append_history(message.channel.id, "user", reply.content)
            return f"User replied: {reply.content}"
        except asyncio.TimeoutError:
            return "User did not reply within 5 minutes."
        finally:
            self._awaiting_reply.discard(message.author.id)

    async def _tool_generate(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str:
        prompt = args.get("prompt", "")
        filename = args.get("filename", "generated_mod.lua")

        if not filename.endswith(".lua"):
            filename += ".lua"

        # Check queue status
        if self.queue.current_job:
            queue_pos = self.queue.pending_count + 1
            await status_msg.edit(
                content=f"⏳ Mod generation queued (position #{queue_pos}). "
                        f"Another mod is currently being generated..."
            )
        else:
            await status_msg.edit(content="🔨 Starting mod generation... This may take a while.")

        async def do_generate() -> str:
            """The actual generation work — runs inside the queue."""
            await status_msg.edit(
                content="🔨 Generating mod with opencode... (this can take several minutes)"
            )

            # Snapshot the mods directory BEFORE so we can diff later
            mods_before = _snapshot_mods_dir()

            # Create a new opencode session
            session_data = await self.opencode.create_session(title=f"Mod: {filename}")
            session_id = session_data.get("id", "")
            self._user_sessions[message.author.id] = session_id

            # Build the full prompt for opencode
            full_prompt = (
                f"Create a BAR mod and save it to `mods/{filename}`.\n\n"
                f"Requirements:\n{prompt}\n\n"
                f"Follow ALL instructions in AGENTS.md. "
                f"Look at existing mods in `mods/` for reference. "
                f"Check `Beyond-All-Reason/language/en/units.json` for unit names. "
                f"The file must be self-contained and ready to use."
            )

            # Status callback — relay opencode progress to Discord
            async def on_status(status: str) -> None:
                await status_msg.edit(
                    content=f"🔨 Opencode: **{status}** — generating `{filename}`..."
                )

            # Fire-and-forget prompt, then poll until done
            oc_messages = await self.opencode.prompt_and_wait(
                session_id, full_prompt, on_status=on_status
            )

            # Extract the last assistant message for a summary
            summary = _extract_last_assistant_text(oc_messages)

            # ---- Find the generated file ----
            # 1. Check the shared volume directly (fastest & most reliable)
            mods_after = _snapshot_mods_dir()
            new_files = _diff_mods(mods_before, mods_after)
            found_file = None
            found_content = None

            target_path = os.path.join(mods_dir(), filename)
            if os.path.isfile(target_path):
                # Expected file exists on disk
                with open(target_path) as f:
                    found_content = f.read()
                found_file = filename
                log.info("Found expected file on shared volume: %s", target_path)
            elif new_files:
                # opencode wrote a file with a different name
                found_file = new_files[0]  # take the first new file
                with open(os.path.join(mods_dir(), found_file)) as f:
                    found_content = f.read()
                log.info("Expected %s but found new file: %s", filename, found_file)

            # 2. Fallback: try the opencode file API
            if found_content is None:
                try:
                    content = await self.opencode.get_file_content(f"mods/{filename}")
                    # Sanity-check: must look like Lua, not JSON/HTML/etc.
                    if content and not content.lstrip().startswith("{"):
                        found_content = content
                        found_file = filename
                        save_generated_mod(filename, found_content)
                        log.info("Retrieved file via opencode API: mods/%s", filename)
                    else:
                        log.warning("Opencode API returned non-Lua content for mods/%s, skipping", filename)
                except Exception as api_err:
                    log.warning("Opencode file API failed for mods/%s: %s", filename, api_err)

            # 3. Last resort: extract Lua code from the assistant messages
            if found_content is None:
                found_content = _extract_lua_from_messages(oc_messages)
                if found_content:
                    save_generated_mod(filename, found_content)
                    found_file = filename
                    log.info("Extracted Lua code from opencode messages, saved as %s", filename)

            if found_file and found_content:
                await status_msg.edit(content=f"✅ Mod `{found_file}` generated successfully!")
                return (
                    f"Mod '{found_file}' was generated and saved to the mods directory. "
                    f"Session ID: {session_id}."
                )
            else:
                await status_msg.edit(
                    content=f"⚠️ Opencode finished but no mod file was found. "
                            f"Session `{session_id}`. Check logs."
                )
                return (
                    f"Opencode session {session_id} completed but no mod file was produced. "
                    f"Agent summary: {summary[:500]}"
                )

        job = await self.queue.submit(do_generate)

        # Wait for the job to complete
        try:
            result = await job.future
            return result
        except Exception as exc:
            return f"Mod generation failed: {exc}"

    async def _tool_refine(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str:
        session_id = args.get("session_id", "")
        feedback = args.get("feedback", "")

        if not session_id:
            # Try to use the user's last session
            session_id = self._user_sessions.get(message.author.id, "")
            if not session_id:
                return "No active session to refine. Generate a mod first."

        await status_msg.edit(
            content="🔧 Sending refinement to opencode... (this can take several minutes)"
        )

        async def do_refine() -> str:
            mods_before = _snapshot_mods_dir()

            async def on_status(status: str) -> None:
                await status_msg.edit(
                    content=f"🔧 Opencode: **{status}** — applying refinement..."
                )

            oc_messages = await self.opencode.prompt_and_wait(
                session_id, feedback, on_status=on_status
            )
            summary = _extract_last_assistant_text(oc_messages)

            # Check for new/modified files
            mods_after = _snapshot_mods_dir()
            changed = _diff_mods(mods_before, mods_after)
            if changed:
                await status_msg.edit(
                    content=f"✅ Refinement applied! Modified: {', '.join(changed)}"
                )
            else:
                await status_msg.edit(content="✅ Refinement applied!")
            return f"Refinement applied to session {session_id}. Response: {summary[:500]}"

        job = await self.queue.submit(do_refine)
        try:
            return await job.future
        except Exception as exc:
            return f"Refinement failed: {exc}"

    async def _tool_build(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str | ToolStopSentinel:
        mod_selections = args.get("mods", {})
        if not mod_selections:
            return "No mods specified to build."

        user_message = args.get("message", "")

        await status_msg.edit(content="📦 Building modpack...")

        try:
            result = build_modpack(mod_selections)
            bset_cmd = result["bset_command"]

            await status_msg.edit(content="✅ Modpack built!")

            # Send the base64 in a code block
            if len(bset_cmd) <= 1900:
                await message.reply(f"```\n{bset_cmd}\n```")
            else:
                # Too long for a message — send as a file
                import io
                file = io.BytesIO(bset_cmd.encode())
                file.name = "modpack_command.txt"
                await message.reply(
                    "The modpack command is too long for a message. Here's the file:",
                    file=discord.File(file, filename="modpack_command.txt"),
                )

            # Send the optional LLM-provided description alongside the delivery
            if user_message:
                for chunk in _split_message(user_message):
                    await message.reply(chunk)

            return ToolStopSentinel(
                f"Modpack built successfully with {len(mod_selections)} mod(s)."
            )
        except Exception as exc:
            log.exception("Build failed")
            return f"Build failed: {exc}"

    async def _tool_list_mods(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str:
        mods = list_available_mods()
        if not mods:
            return "No mods found in the mods directory."

        mod_list = "\n".join(f"  - {m}" for m in mods)
        await status_msg.edit(content=f"📋 **Available Mods:**\n{mod_list}")
        return f"Available mods ({len(mods)}): {', '.join(mods)}"

    async def _tool_respond(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> ToolStopSentinel:
        text = args.get("message", "")
        if text:
            await status_msg.edit(content=text)
        return ToolStopSentinel(text)

    async def _tool_search_units(
        self, args: dict[str, Any], message: discord.Message, status_msg: discord.Message
    ) -> str:
        query = args.get("query", "")
        if not query:
            return "No search query provided."

        await status_msg.edit(content=f"🔍 Searching units for: *{query}*...")

        results = self.unit_search.search(query, max_results=5)
        if not results:
            return f"No units found matching '{query}'."

        # Format results for the LLM (full content so it can answer questions)
        parts = [f"Found {len(results)} unit(s) matching '{query}':\n"]
        for r in results:
            parts.append(f"--- {r['human_name']} ({r['unit_id']}) ---")
            parts.append(r["content"])
            parts.append("")

        return "\n".join(parts)


def _snapshot_mods_dir() -> dict[str, float]:
    """Return {filename: mtime} for all .lua files in the mods directory."""
    d = mods_dir()
    if not os.path.isdir(d):
        return {}
    result = {}
    for f in os.listdir(d):
        if f.endswith(".lua"):
            try:
                result[f] = os.path.getmtime(os.path.join(d, f))
            except OSError:
                pass
    return result


def _diff_mods(
    before: dict[str, float], after: dict[str, float]
) -> list[str]:
    """Return filenames that are new or modified between two snapshots."""
    changed = []
    for fname, mtime in after.items():
        if fname not in before or mtime > before[fname]:
            changed.append(fname)
    return sorted(changed)


def _extract_lua_from_messages(messages: list[dict[str, Any]]) -> str | None:
    """Try to extract a Lua code block from the last assistant message."""
    for msg in reversed(messages):
        info = msg.get("info", {})
        if info.get("role") != "assistant":
            continue
        parts = msg.get("parts", [])
        for part in parts:
            text = part.get("text", "")
            if not text:
                continue
            # Look for ```lua ... ``` blocks
            matches = re.findall(r"```lua\s*\n(.*?)```", text, re.DOTALL)
            if matches:
                # Return the longest match (most likely the full mod)
                return max(matches, key=len).strip()
    return None


def _extract_last_assistant_text(messages: list[dict[str, Any]]) -> str:
    """Pull the text content from the last assistant message in a message list."""
    for msg in reversed(messages):
        info = msg.get("info", {})
        role = info.get("role", "")
        if role != "assistant":
            continue
        parts = msg.get("parts", [])
        texts = [p.get("text", "") for p in parts if p.get("type") == "text" and p.get("text")]
        if texts:
            return "\n".join(texts)
    return "(no assistant response found)"


def _split_message(text: str, limit: int = 2000) -> list[str]:
    """Split a long message into chunks that fit Discord's character limit."""
    if len(text) <= limit:
        return [text]

    chunks = []
    while text:
        if len(text) <= limit:
            chunks.append(text)
            break
        # Find a good split point (newline or space)
        split_at = text.rfind("\n", 0, limit)
        if split_at == -1:
            split_at = text.rfind(" ", 0, limit)
        if split_at == -1:
            split_at = limit
        chunks.append(text[:split_at])
        text = text[split_at:].lstrip()
    return chunks


async def setup(bot: commands.Bot) -> None:
    """Called by discord.py when loading this cog."""
    config = bot._config  # type: ignore[attr-defined]
    await bot.add_cog(ModGenerator(bot, config))
