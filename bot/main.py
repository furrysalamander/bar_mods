"""BAR Mod Bot — Discord bot entry point."""

from __future__ import annotations

import asyncio
import logging
import os
import sys

import discord
from discord.ext import commands
from dotenv import load_dotenv

from bot.config import Config

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s  %(levelname)-8s  %(name)s  %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
# Quiet down noisy libraries
logging.getLogger("discord").setLevel(logging.WARNING)
logging.getLogger("aiohttp").setLevel(logging.WARNING)
log = logging.getLogger("bot")


# ---------------------------------------------------------------------------
# Bot setup
# ---------------------------------------------------------------------------

def make_bot(config: Config) -> commands.Bot:
    intents = discord.Intents.default()
    intents.message_content = True
    intents.messages = True

    bot = commands.Bot(
        command_prefix="!",
        intents=intents,
        description="BAR Mod Bot — generates and manages Beyond All Reason mods.",
    )
    # Stash config so cogs can access it
    bot._config = config  # type: ignore[attr-defined]

    @bot.event
    async def on_ready() -> None:
        log.info("Logged in as %s (ID: %s)", bot.user, bot.user.id)
        log.info("Guilds: %s", [g.name for g in bot.guilds])

    return bot


async def main() -> None:
    # Load .env if present (for local development outside Docker)
    load_dotenv()

    config = Config.from_env()
    problems = config.validate()
    if problems:
        for p in problems:
            log.error("Config problem: %s", p)
        sys.exit(1)

    bot = make_bot(config)

    async with bot:
        await bot.load_extension("bot.cogs.mod_generator")
        log.info("Starting bot...")
        await bot.start(config.discord_token)


if __name__ == "__main__":
    asyncio.run(main())
