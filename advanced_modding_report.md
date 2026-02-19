# The Comprehensive Beyond All Reason (BAR) Modding Manual

This manual serves as the definitive reference for creating and modifying game content in Beyond All Reason using the Lua-based Tweak System. It is designed to be a standalone resource for engineers and AI agents alike.

---

## 1. Technical Foundations

### 1.1 The Modding Environment
BAR uses a "Tweak" system that allows you to modify the game's unit and weapon definitions at runtime without altering the base game files.
*   **`tweakunits`**: A simple table-merging system. Best used for quick stat patches (e.g., doubling the HP of a specific unit).
*   **`tweakdefs`**: A full Lua execution environment. This is the "Gold Standard" for modding because it allows you to use logic, loops, and conditional cloning to create entirely new units.

### 1.2 The Principle of Inheritance (Cloning)
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

---

## 5. Procedural Logic & Compatibility

### 5.1 Dynamic Builder Injection
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

### 5.2 Global Balance Tweaks (`UnitDef_Post`)
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

1.  **Draft the Lua**: Define your unit using `deepcopy` of a parent.
2.  **Define Stats**: Set identity, movement, and combat parameters.
3.  **Inject**: Add the unit to build menus procedurally.
4.  **Encode**: Run the `encode_mod.py` script to generate a Base64 string.
5.  **Deploy**: In a lobby, use `!boss` and `!bset tweakdefs <BASE64_STRING>`.
6.  **Debug**: If the unit doesn't appear, check `infolog.txt` for Lua syntax errors.
