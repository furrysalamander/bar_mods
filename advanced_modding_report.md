# The Comprehensive Beyond All Reason (BAR) Modding Manual

This manual serves as the definitive reference for creating and modifying game content in Beyond All Reason using the Lua-based Tweak System. It is designed to be a standalone resource for engineers and AI agents alike.

---

## 0. Modify vs. Create — Choose the Right Pattern

Before writing any code, decide whether you need to **modify an existing unit** or **create a brand-new unit**. Using the wrong pattern is the most common mistake.

### 0.1 Modifying an Existing Unit (tweakdefs — in-place edit)
Use this when the user wants to **change stats, weapons, or behaviour** of a unit that already exists in the game. Examples: "increase the commander's d-gun range", "make Pawns faster", "double all unit HP".

**Pattern — iterate `UnitDefs` and edit in-place:**
```lua
-- Example: Make the commander d-gun reach across the map
for name, ud in pairs(UnitDefs) do
    if (name == "armcom" or name == "corcom") and ud.weapondefs then
        if ud.weapondefs.disintegrator then
            ud.weapondefs.disintegrator.range = 5000
        end
    end
end
```

Key rules for in-place modifications:
- **No `deepcopy`** — you are editing the original unit, not creating a copy.
- **No `MOD_ADDED_UNITS`** — you are not adding a new unit.
- **No builder injection** — the unit already exists in build menus.
- **No `u.name` or `customparams` identity** — the unit keeps its original identity.
- You *can* modify `weapondefs`, `weapons`, `speed`, `health`, `metalcost`, or any other stat.

### 0.2 Modifying Every Unit (tweakdefs — global sweep)
Use this for broad balance changes that affect all (or a category of) units. Example: "double all unit health", "make all aircraft fly higher".

```lua
for name, ud in pairs(UnitDefs) do
    if ud.health then
        ud.health = ud.health * 2
    end
end
```

### 0.3 Creating a Brand-New Unit (tweakdefs — clone)
Use this **only** when the user wants a unit that does not exist in the game. Examples: "create a mega tank", "make a stealth bomber variant". This requires cloning, registration, and builder injection — see Section 1.2 below.

### 0.4 Quick Stat Patch (tweakunits — simple table merge)
For the simplest possible edits to a single unit, you can use the `tweakunits` system instead of `tweakdefs`. This is a pure data merge — no Lua execution.

```lua
-- tweakunits format: a Lua table returned to the engine
{
    armpw = { metalcost = 10, health = 9999 },
    corcom = { speed = 100 },
}
```

Base64-encode this table (URL-safe, strip trailing `=`) and apply with `!bset tweakunits <base64>`.

**Limitations of tweakunits:**
- Cannot create new units or iterate over `UnitDefs`.
- Cannot modify nested tables like `weapondefs` (only top-level keys).
- Cannot contain logic (loops, conditionals, functions).
- For anything beyond simple stat patches, use `tweakdefs`.

### 0.5 Decision Flowchart
```
Is the request about an existing unit?
├── YES: Does it need weapon/nested changes or logic?
│   ├── YES → tweakdefs in-place edit (Section 0.1)
│   └── NO (simple stat change) → tweakunits (Section 0.4) or tweakdefs
└── NO: Creating a new unit
    └── tweakdefs clone pattern (Section 1.2)
```

---

## 1. Technical Foundations

### 1.1 The Modding Environment
BAR uses a "Tweak" system that allows you to modify the game's unit and weapon definitions at runtime without altering the base game files.
*   **`tweakunits`**: A simple table-merging system. Best used for quick stat patches (e.g., doubling the HP of a specific unit). See Section 0.4.
*   **`tweakdefs`**: A full Lua execution environment. This is the "Gold Standard" for modding because it allows you to use logic, loops, and conditional cloning to create entirely new units or modify existing ones in-place.

### 1.2 The Principle of Inheritance (Cloning)
**This section applies ONLY when creating a brand-new unit.** If you are modifying an existing unit, see Section 0.1 instead.

The BAR engine requires hundreds of parameters for a unit to function. If you miss one, the game may crash or the unit may be invisible.
**Best Practice**: Never start a unit from a blank table. Always clone an existing unit that is physically similar to what you want to build.

```lua
-- Always use a deepcopy function to ensure the new unit's 
-- nested tables (like weapons) are independent of the parent.
local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

-- Example: Creating a "Super Bot" based on the standard Pawn (armpw)
UnitDefs["super_bot"] = deepcopy(UnitDefs["armpw"])
local u = UnitDefs["super_bot"]

-- MODDING REQUIREMENT: Register the new unit for the Modpack Manager
-- This enables the manager to dynamically inject "test" behaviors later.
if MOD_ADDED_UNITS then
    table.insert(MOD_ADDED_UNITS, "super_bot")
end
```

### 1.3 Guarding Against Missing Parent Units
**Always check that a parent unit exists before cloning it.** Many units in BAR are conditionally loaded based on game settings and may not be present in `UnitDefs` at runtime.

**Conditionally loaded unit categories:**
| Category | Condition | Examples |
|---|---|---|
| **Legion faction** (`leg*`) | Only when Legion is enabled for the round | `legcom`, `legnavysub`, `legnavyrezsub` |
| **Experimental units** | Gated behind `modOptions.experimentalextraunits` | `armseadragon`, `cordesolator`, `armexcalibur`, `armmeatball`, `legbunk` |
| **Scavenger units** (`*_scav`) | Gated behind `modOptions.scavunitsforplayers` | `armapt3_scav`, `corbuzz_scav` |
| **Raptor units** (`raptor*`) | Only in Raptor game modes | `raptorqueenr1`, `raptorwalkerr1` |
| **Release candidate units** | Gated behind `modOptions.releasecandidates` | Varies by version |

Without a guard, `deepcopy(nil)` returns `nil`, and the very next line (e.g., `u.name = ...`) crashes the **entire tweakdefs script silently** — no error is shown, and **no units from the script will load**.

**Idiomatic guard patterns:**
```lua
-- Pattern A: Single unit (skip if parent missing)
local parent_id = "armsubk"
local new_id = "my_new_sub"
if UnitDefs[parent_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]
    -- ... customize u ...
end

-- Pattern B: Data-driven loop with logging
local units = {
    { id = "armfast", parent = "armbanth" },
    { id = "corfast", parent = "corjugg" },
    { id = "legfast", parent = "legeheatraymech" },  -- may not exist!
}
for _, cfg in ipairs(units) do
    if not UnitDefs[cfg.parent] then
        Spring.Echo("[MyMod] Parent '" .. cfg.parent .. "' not found, skipping " .. cfg.id)
    else
        UnitDefs[cfg.id] = deepcopy(UnitDefs[cfg.parent])
        local u = UnitDefs[cfg.id]
        -- ... customize u ...
    end
end
```

---

## 2. Unit Identity & Player Experience

### 2.1 Identification
- **`u.name`**: The internal engine ID. Used for logic and `!give` commands.
- **`u.customparams.i18n_en_humanname`**: What the player sees in the UI.
- **`u.customparams.i18n_en_tooltip`**: The flavor text and strategic description.

### 2.2 Visuals & Sound
- **`u.objectname`**: The path to the 3D model file (`.s3o`).
- **`u.script`**: The path to the animation script (`.lua`). This controls walking, dying, and firing animations.
- **`u.buildpic`**: The icon shown in the factory build menu.
- **`u.nanocolor`**: The color of the construction beam when the unit is being built.

---

## 3. Movement and Physics

### 3.1 Land and Water
- **`u.speed`**: Measured in pixels per frame. To calculate pixels per second, multiply by 30.
- **`u.maxvelocity`**: The hard cap for speed, including when the unit is pushed or falling.
- **`u.maxslope`**: The steepness of terrain the unit can climb.
- **`u.maxwaterdepth` / `u.minwaterdepth`**: Determines if the unit is land-based, naval, or amphibious.

### 3.2 Atmospheric (Flight)
To create a flyer, you must enable the flight engine:
- **`u.canfly = true`**: Essential toggle.
- **`u.cruisealtitude`**: The "default" height. Standard air is ~200. "Space" mods often use 2000+.
- **`u.hoverattack`**: If true, the unit stops and hovers to fire (like a gunship). If false, it performs strafing runs (like a fighter).

---

## 4. The Combat System (Weaponry)

Weapon creation is a two-step process: defining the gun's stats and then mounting it on the unit.

### 4.1 Defining the Gun (`weapondefs`)
Every unit has a `weapondefs` table. Here you define the projectile type and damage.
- **`w.range`**: Max distance.
- **`w.reloadtime`**: Seconds between shots.
- **`w.weaponvelocity`**: Speed of the projectile. 
- **`w.damage`**: A table of damage values per target category. 
    ```lua
    w.damage = {
        default = 100, -- Required catch-all
        vtol = 200     -- Double damage against aircraft
    }
    ```

### 4.2 Mounting the Gun (`weapons`)
This maps the weapon definition to a physical "slot" on the unit.
```lua
u.weapons = {
    [1] = { 
        def = "MY_NEW_LASER", -- Matches the key in weapondefs
        maindir = "0 0 1",    -- Points forward
        maxangledif = 120    -- The firing arc (120 degrees)
    }
}
```

**Important:** Weapon slots must exist in the unit's script and model. If the unit script only implements `AimWeapon1/FireWeapon1`, a weapon placed in slot 2+ will never fire. When adding multiple weapons, clone from a parent unit whose script already supports the same number of weapon slots.

### 4.3 Weapon Slot Constraints (Critical)
Unit animation scripts (`.cob` or `.lua`) implement specific `AimWeaponN` / `FireWeaponN` functions for each weapon slot index. **If the script does not implement a slot, any weapon assigned to that slot will silently never fire — no error, just a dead weapon.**

**Rule 1 — Replacing weapons is safe (same slot count):**
When you replace `u.weapondefs` and `u.weapons` with entirely new tables, the new weapon inherits the parent's animation functions — as long as you use the **same slot indices**. This is the pattern used by the Nuke Tick mod:
```lua
-- Parent (armflea) has 1 weapon in slot [1].
-- We REPLACE slot [1] with a nuke — the parent's AimWeapon1/FireWeapon1 drives it.
u.weapondefs = {
    nuke_tick = nuke_def,   -- replaces the original weapon entirely
}
u.weapons = {
    [1] = { def = "NUKE_TICK" },  -- same slot index as the parent
}
```

**Rule 2 — Adding extra weapon slots is NOT safe:**
If the parent only supports 1 weapon slot, you **cannot** add a weapon to slot `[2]` and expect it to fire. You must clone from a parent whose script already supports the number of slots you need.

**Rule 3 — Never arm a builder or support unit:**
Units like `legnavyrezsub` (Resurrection Submarine) or `armacsub` (Construction Sub) have **zero weapon scripts**. No weapon will ever fire on these units, regardless of what you put in `weapondefs`.

**Reference — Submarines by weapon slot count:**
| Slots | Units |
|---|---|
| 0 | `armacsub`, `coracsub`, `legnavyrezsub`, `leganavyconsub` (builders) |
| 1 | `armsub`, `corsub`, `legnavysub`, `armsubk`, `corssub`, `leganavybattlesub`, `leganavyheavysub` |
| 2 | `armserp` (torpedo × 2, slot 2 slaved to slot 1) |
| 3 | `armseadragon` (torpedo + nuke missile + alarm), `cordesolator` (torpedo + nuke missile + alarm) |

---

## 5. Procedural Logic & Compatibility

### 5.1 The Modpack Manager & Test Injection (REQUIRED)
To ensure compatibility with the automated Modpack Manager, **every new unit** must be registered in the `MOD_ADDED_UNITS` table if it exists.

```lua
if MOD_ADDED_UNITS then
    table.insert(MOD_ADDED_UNITS, "super_bot")
end
```

When building a mod in "Test Mode", the Manager will parse this registration and dynamically append Lua code to:
1. Reduce the unit's metal/energy cost to 1.
2. Reduce the unit's build time to 1.
3. Automatically inject the unit into the Arm and Core Commanders (`armcom`, `corcom`) build options.

Failure to register your units means they won't automatically benefit from the test injection workflow!

### 5.2 Dynamic Builder Injection
Instead of manually adding your unit to every factory, use a loop. This ensures your mod works even if other mods change building lists.

```lua
local function injectUnit(parentID, newUnitID)
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            -- Find the builder that builds the 'parent'
            for i, opt in ipairs(ud.buildoptions) do
                if opt == parentID then
                    table.insert(ud.buildoptions, newUnitID)
                    break
                end
            end
        end
    end
end

injectUnit("armpw", "super_bot")
```

### 5.3 Global Balance Tweaks (`UnitDef_Post`)
If you want to apply a change to *every single unit* in the game (e.g., doubling all health), hijack the `UnitDef_Post` function.

```lua
local old_post = UnitDef_Post
function UnitDef_Post(name, u)
    if old_post then old_post(name, u) end -- Run existing logic first
    if u.health then
        u.health = u.health * 2
    end
end
```

---

## 6. Workflow Checklist

### For modifying existing units:
1.  **Decide the pattern**: Use Section 0 to decide between tweakunits and tweakdefs.
2.  **Write the Lua**: Iterate `UnitDefs` and edit stats in-place. No `deepcopy`, no registration.
3.  **Encode**: Run `python3 encode_mod.py` to generate a Base64 string.
4.  **Deploy**: In a lobby, use `!boss` and `!bset tweakdefs <BASE64_STRING>`.
5.  **Debug**: If changes don't apply, check `infolog.txt` for Lua syntax errors.

### For creating new units:
1.  **Draft the Lua**: Clone a parent unit using `deepcopy`.
2.  **Guard the parent**: Nil-check `UnitDefs[parent_id]` before cloning. Many unit categories are conditionally loaded — Legion, experimentals, scavengers, raptors (see Section 1.3).
3.  **Verify weapon slots**: Check the parent's `weapons` table to confirm it supports the number of weapon slots you need. You cannot add slots beyond what the parent's animation script implements (see Section 4.3).
4.  **Define Stats**: Set identity (`u.name`, `customparams`), movement, and combat parameters.
5.  **Register**: Add to `MOD_ADDED_UNITS` for test-mode compatibility.
6.  **Inject**: Add the unit to build menus procedurally.
7.  **Encode**: Run `python3 encode_mod.py` to generate a Base64 string.
8.  **Deploy**: In a lobby, use `!boss` and `!bset tweakdefs <BASE64_STRING>`.
9.  **Debug**: If the unit doesn't appear, check `infolog.txt` for Lua syntax errors.

---

## 7. Important: Tweakdefs File Format

Tweakdefs scripts are executed as **function bodies** inside the engine. Key rules:

1.  **Do NOT use `return`** at the end of a tweakdefs script. The engine does not expect a return value. Modify `UnitDefs` directly.
2.  **The Modpack Manager wraps each mod in `do...end` blocks.** This means `local` variables are properly scoped, but `return` statements will be silently swallowed.
3.  **`UnitDefs` is a global** — you read from it and write to it directly. No need to capture or return it.

Correct tweakdefs format:
```lua
-- Modify existing units in-place:
for name, ud in pairs(UnitDefs) do
    if ud.health then ud.health = ud.health * 2 end
end

-- Or create new units by assigning to UnitDefs:
UnitDefs["super_bot"] = deepcopy(UnitDefs["armpw"])
local u = UnitDefs["super_bot"]
u.speed = 200
```

Incorrect (do NOT do this in tweakdefs):
```lua
-- WRONG: returning a table is for tweakunits, not tweakdefs
local newUnits = {}
newUnits.armcom = deepcopy(UnitDefs.armcom)
return newUnits  -- This will be silently ignored!
```
