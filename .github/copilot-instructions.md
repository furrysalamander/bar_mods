# BAR Coding Agent Instructions (Master V2)

## 1. Primary Reference
The absolute authority on BAR modding for this repository is **`advanced_modding_report.md`** (The Master Modding Guide). You must refer to this file for any task involving adding or modifying units.

**IMPORTANT:** The definitive list of unit internal names is in `language/en/units.json`. Always check this file to confirm the correct internal name before cloning or modifying a unit.

## 2. Core Modding Principles (The "Never-Breaks")
1.  **Always Clone**: Never define a unit as a new table `{}`. Always use `UnitDefs["new_id"] = table.copy(UnitDefs["original_id"])`.
2.  **Procedural Over Static**: Favor `tweakdefs` over `tweakunits`. Even simple changes are safer in a script environment where you can use `Spring.Echo` for logging.
3.  **Dynamic Injection**: Never hardcode build lists. Iterate through `UnitDefs` and inject your new unit into any builder that builds the "parent" unit.
4.  **Weapon Mapping**: Remember that weapons require two steps: defining them in `u.weapondefs` and mapping them to a slot in `u.weapons[index]`.


## 3. Workflow for New Mod Creation
1.  **Read the Guide**: Consult `advanced_modding_report.md` for the specific API keys needed (health, speed, cruisealtitude, etc.).
2.  **Write the Script**: Focus on self-contained Lua blocks.
3.  **Dynamic Builder Search**: Include the "Parent/Child" injection loop to ensure the unit is actually buildable in-game.
4.  **Encode**: Use `python3 encode_mod.py` to generate Base64 strings for all mods in the directory (output to the `output/` folder).
5.  **Validation Instructions**: When instructing the USER to apply the mod, you MUST specify the correct tweakdefs/tweakunits flag in the `!bset` command. For example:

	- For tweakdefs: `!bset tweakdefs <base64>`
	- For tweakunits: `!bset tweakunits <base64>`

	The flag is required for the mod to be recognized and loaded by BAR. Always check the mod type and provide the correct flag in all instructions and documentation.

## 3a. Tweak Units and Tweak Defs Quick Guide
- **Tweak Units (basic per-unit edits)**
	- Find the unit internal name in `language/en/units.json`.
	- Check current stats in `Beyond-All-Reason/units/` (match the unit file for the internal name).
	- Create a Lua table of changes, example:
		```lua
		{
			armpw = { metalcost = 10 }
		}
		```
	- Base64-encode the table (URL-safe) and strip trailing `=`.
	- In-game: `!boss`, then `!bset tweakunits <base64>`.

- **Tweak Defs (procedural edits across units)**
	- Write a Lua function body, example:
		```lua
		for name, ud in pairs(UnitDefs) do
			if ud.metalcost then
				ud.metalcost = 10
			end
		end
		```
	- Base64-encode the function body (URL-safe) and strip trailing `=`.
	- In-game: `!boss`, then `!bset tweakdefs <base64>`.

- **Encoding**
	- Use `python3 encode_mod.py` (auto URL-safe; output in `output/`).

## 4. Technical Reference Locations
- **Reference Source**: `Beyond-All-Reason/` (Read-only reference for original unit names and base stats).
- **Mod Examples**: `normalized_mods/` (Legacy reference, deprioritize in favor of the Master Guide).
- **Master Guide**: `advanced_modding_report.md` (Definitive Reference).

## 5. Agent Constraints
- Do not modify the `Beyond-All-Reason/` directory.
- Ensure all Base64 strings are URL-safe and have trailing `=` stripped.
- Provide "human name" and "tooltip" for every new unit via `customparams`.
