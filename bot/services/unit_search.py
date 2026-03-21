"""Unit database search service.

Loads scraped unit wiki data from ``data/units/`` and provides keyword search
across unit names, IDs, factions, categories, and content.
"""

from __future__ import annotations

import logging
import os
import re
from dataclasses import dataclass, field
from pathlib import Path

log = logging.getLogger(__name__)

# Default path; overridden via UNIT_DATA_DIR env var or constructor arg
_DEFAULT_DATA_DIR = "./data/units"

# Maximum results returned to avoid blowing up context windows
_MAX_RESULTS = 5


@dataclass
class UnitEntry:
    """Index entry for a single unit's wiki data."""
    unit_id: str           # e.g. "armpw"
    faction: str           # e.g. "armada"
    category: str          # e.g. "bots"
    human_name: str        # e.g. "Pawn"
    subtitle: str          # e.g. "Fast Infantry Bot"
    tier: str              # e.g. "T1"
    file_path: str         # absolute path to the .md file
    # Pre-loaded content for search matching (lowercased)
    _search_text: str = field(repr=False, default="")


class UnitSearchIndex:
    """In-memory index of scraped unit wiki data for fast keyword search."""

    def __init__(self, data_dir: str | None = None) -> None:
        self._data_dir = data_dir or os.environ.get("UNIT_DATA_DIR", _DEFAULT_DATA_DIR)
        self._entries: list[UnitEntry] = []
        self._loaded = False

    def load(self) -> None:
        """Walk the data directory and build the search index."""
        data_path = Path(self._data_dir)
        if not data_path.is_dir():
            log.warning("Unit data directory not found: %s", self._data_dir)
            self._loaded = True
            return

        count = 0
        for md_file in sorted(data_path.rglob("*.md")):
            try:
                content = md_file.read_text(encoding="utf-8", errors="replace")
            except OSError:
                continue

            # Derive metadata from path: data/units/<faction>/<category>/<unit_id>.md
            rel = md_file.relative_to(data_path)
            parts = rel.parts  # e.g. ("armada", "bots", "armpw.md")
            if len(parts) < 3:
                continue

            faction = parts[0]
            category = parts[1]
            unit_id = md_file.stem  # filename without .md

            # Extract human name from first heading: # Name
            human_name = unit_id
            subtitle = ""
            tier = ""
            human_name_set = False
            for line in content.splitlines():
                line_s = line.strip()
                if line_s.startswith("# ") and not human_name_set:
                    human_name = line_s[2:].strip()
                    human_name_set = True
                elif line_s.startswith("> "):
                    subtitle = line_s[2:].strip()
                elif "Tier:" in line_s:
                    m = re.search(r"\*?\*?Tier:\*?\*?\s*(\S+)", line_s)
                    if m:
                        tier = m.group(1)

            entry = UnitEntry(
                unit_id=unit_id,
                faction=faction,
                category=category,
                human_name=human_name,
                subtitle=subtitle,
                tier=tier,
                file_path=str(md_file),
                _search_text=(
                    f"{unit_id} {human_name} {subtitle} {faction} {category} "
                    f"{tier} {content}"
                ).lower(),
            )
            self._entries.append(entry)
            count += 1

        self._loaded = True
        log.info("Unit search index loaded: %d units from %s", count, self._data_dir)

    @property
    def unit_count(self) -> int:
        return len(self._entries)

    def search(self, query: str, *, max_results: int = _MAX_RESULTS) -> list[dict[str, str]]:
        """Search for units matching the query.

        Returns a list of dicts with keys: unit_id, faction, category,
        human_name, subtitle, tier, content.
        """
        if not self._loaded:
            self.load()

        if not query or not query.strip():
            return []

        query_lower = query.strip().lower()
        tokens = query_lower.split()

        # Score each entry
        scored: list[tuple[int, UnitEntry]] = []
        for entry in self._entries:
            score = 0
            # Exact unit_id match is highest priority
            if entry.unit_id == query_lower:
                score += 100
            elif query_lower in entry.unit_id:
                score += 50

            # Human name match
            name_lower = entry.human_name.lower()
            if query_lower == name_lower:
                score += 90
            elif query_lower in name_lower:
                score += 45

            # Faction / category match
            if query_lower == entry.faction:
                score += 30
            if query_lower == entry.category:
                score += 30

            # Token-based matching for multi-word queries
            for token in tokens:
                if token in entry._search_text:
                    score += 10

            if score > 0:
                scored.append((score, entry))

        # Sort by score descending
        scored.sort(key=lambda x: x[0], reverse=True)

        results = []
        for _score, entry in scored[:max_results]:
            try:
                content = Path(entry.file_path).read_text(
                    encoding="utf-8", errors="replace"
                )
            except OSError:
                content = "(file not readable)"

            results.append({
                "unit_id": entry.unit_id,
                "faction": entry.faction,
                "category": entry.category,
                "human_name": entry.human_name,
                "subtitle": entry.subtitle,
                "tier": entry.tier,
                "content": content,
            })

        return results
