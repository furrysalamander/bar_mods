"""Configuration loader — reads from environment variables."""

import os
from dataclasses import dataclass, field


@dataclass
class Config:
    # Discord
    discord_token: str = ""

    # LLM provider (any OpenAI-compatible API: local llama.cpp, OpenRouter, etc.)
    llama_api_url: str = "http://localhost:8080/v1"
    llama_model_id: str = "qwen3-coder"
    llm_api_key: str = ""  # empty = no auth (local); set for cloud providers

    # OpenCode server
    opencode_url: str = "http://localhost:4096"
    opencode_password: str = ""
    opencode_username: str = "opencode"

    # Bot behaviour
    personality: str = "helpful engineer"

    # Paths
    mods_dir: str = "./mods"
    output_dir: str = "./output"

    @classmethod
    def from_env(cls) -> "Config":
        return cls(
            discord_token=os.environ.get("DISCORD_BOT_TOKEN", ""),
            llama_api_url=os.environ.get("LLAMA_API_URL", cls.llama_api_url),
            llama_model_id=os.environ.get("LLAMA_MODEL_ID", cls.llama_model_id),
            llm_api_key=os.environ.get("LLM_API_KEY", ""),
            opencode_url=os.environ.get("OPENCODE_URL", cls.opencode_url),
            opencode_password=os.environ.get("OPENCODE_SERVER_PASSWORD", ""),
            opencode_username=os.environ.get("OPENCODE_SERVER_USERNAME", cls.opencode_username),
            personality=os.environ.get("BOT_PERSONALITY", cls.personality),
            mods_dir=os.environ.get("MODS_DIR", cls.mods_dir),
            output_dir=os.environ.get("OUTPUT_DIR", cls.output_dir),
        )

    def validate(self) -> list[str]:
        """Return a list of configuration problems (empty = OK)."""
        problems = []
        if not self.discord_token:
            problems.append("DISCORD_BOT_TOKEN is not set")
        if not self.llama_api_url:
            problems.append("LLAMA_API_URL is not set")
        if not self.opencode_url:
            problems.append("OPENCODE_URL is not set")
        return problems
