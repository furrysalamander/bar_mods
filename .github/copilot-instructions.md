# BAR Coding Agent Instructions

## 1. Primary Reference
The absolute authority on BAR modding is **`advanced_modding_report.md`** (The Master Modding Guide). Read it before any task involving units. It contains:
- **Section 0**: Decision flowchart — modify existing unit vs. create new unit (READ THIS FIRST)
- **Sections 1–5**: Cloning, stats, weapons, builder injection, registration
- **Section 6**: Workflow checklists for both patterns
- **Section 7**: Tweakdefs file format rules (no `return`, `UnitDefs` is global)

**IMPORTANT:** The definitive list of unit internal names is in `Beyond-All-Reason/language/en/units.json`. Always verify the correct internal name.

## 2. Core Modding Principles
1.  **Modify vs. Create** — Read Section 0 of the guide. Modifying an existing unit (e.g., "increase d-gun range") does NOT require `deepcopy`, registration, or builder injection. Only new units need the full clone workflow.
2.  **Never Blank Tables** — When creating new units, always clone via `deepcopy(UnitDefs["parent_id"])`.
3.  **Procedural Over Static** — Favor `tweakdefs` over `tweakunits`. Use `Spring.Echo` for logging.
4.  **Dynamic Injection** — For new units only: iterate `UnitDefs` to inject into builders.
5.  **Weapon Mapping** — Weapons require two steps: define in `u.weapondefs`, map in `u.weapons[index]`.
6.  **No `return`** — Tweakdefs scripts modify `UnitDefs` directly. Do not return a table.

## 3. Workflow
1.  **Read the Guide**: Consult `advanced_modding_report.md` Section 0 to choose your pattern.
2.  **Write the Script**: Self-contained Lua in `mods/`. Modify `UnitDefs` directly.
3.  **Encode**: `python3 src/encode_mod.py` generates Base64 strings (output to `output/`).
4.  **Deploy**: Instruct the user to run `!boss` then `!bset tweakdefs <base64>` (or `tweakunits` for simple table merges).

## 4. Quick Reference: tweakunits vs tweakdefs
- **tweakunits** — Simple table merge. `{ armpw = { metalcost = 10 } }`. Apply with `!bset tweakunits <b64>`.
- **tweakdefs** — Full Lua execution. `for name, ud in pairs(UnitDefs) do ... end`. Apply with `!bset tweakdefs <b64>`.
- **Encoding** — Always URL-safe Base64 with trailing `=` stripped.

## 5. Reference Locations
- **Master Guide**: `advanced_modding_report.md`
- **Unit Names**: `Beyond-All-Reason/language/en/units.json`
- **Unit Stats**: `Beyond-All-Reason/units/<unitname>.lua`
- **Unit Wiki Data**: `data/units/<faction>/<category>/<unit_id>.md` (scraped stats and descriptions)
- **Working Mods**: `mods/`

## 6. Agent Constraints
- Do not modify the `Beyond-All-Reason/` directory.
- Ensure all Base64 strings are URL-safe and have trailing `=` stripped.
- Provide "human name" and "tooltip" for every new unit via `customparams`.
