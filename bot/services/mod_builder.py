"""Mod builder service — wraps src/builder.py for programmatic use by the bot."""

from __future__ import annotations

import base64
import logging
import os
import sys
from pathlib import Path
from typing import Any

log = logging.getLogger(__name__)

# Ensure the project root's src/ is importable so we can reuse builder.py.
_PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
_SRC_DIR = _PROJECT_ROOT / "src"
if str(_SRC_DIR) not in sys.path:
    sys.path.insert(0, str(_SRC_DIR))


def _mods_dir() -> str:
    return os.environ.get("MODS_DIR", "./mods")


# Public alias so other modules can find the mods directory
mods_dir = _mods_dir


def _output_dir() -> str:
    return os.environ.get("OUTPUT_DIR", "./output")


def list_available_mods() -> list[str]:
    """Return sorted list of .lua mod filenames in the mods directory."""
    mods_dir = _mods_dir()
    if not os.path.isdir(mods_dir):
        return []
    return sorted(
        f
        for f in os.listdir(mods_dir)
        if f.endswith(".lua") and not f.endswith("_test.lua") and "modpack" not in f
    )


def build_modpack(mod_selections: dict[str, str]) -> dict[str, str]:
    """Build a modpack and return paths + the base64 string.

    Parameters
    ----------
    mod_selections:
        ``{filename: "Normal" | "Test"}`` for each mod to include.

    Returns
    -------
    Dict with keys ``lua_path``, ``b64_path``, ``b64``, ``bset_command``.
    """
    # Import the builder at call time so the cwd-relative paths work
    from builder import build_modpack as _build  # type: ignore[import-untyped]

    lua_path = _build(mod_selections)
    b64_path = lua_path.replace(".lua", ".b64")

    b64_data = ""
    if os.path.exists(b64_path):
        with open(b64_path) as f:
            b64_data = f.read()

    return {
        "lua_path": lua_path,
        "b64_path": b64_path,
        "b64": b64_data,
        "bset_command": f"!bset tweakdefs {b64_data}",
    }


def encode_single_mod(filename: str, *, test: bool = False) -> dict[str, str]:
    """Encode a single mod file to base64.

    Parameters
    ----------
    filename:
        Name of the .lua file in the mods directory.
    test:
        If True, build in test mode.

    Returns
    -------
    Same shape as ``build_modpack`` return.
    """
    mode = "Test" if test else "Normal"
    return build_modpack({filename: mode})


def save_generated_mod(filename: str, content: str) -> str:
    """Write generated Lua content to the mods directory.

    Returns the full path of the saved file.
    """
    mods_dir = _mods_dir()
    os.makedirs(mods_dir, exist_ok=True)
    safe_name = os.path.basename(filename)
    if not safe_name:
        raise ValueError(f"Invalid mod filename: {filename!r}")
    if not safe_name.endswith(".lua"):
        safe_name += ".lua"
    filepath = os.path.join(mods_dir, safe_name)
    with open(filepath, "w") as f:
        f.write(content)
    log.info("Saved generated mod to %s", filepath)
    return filepath
