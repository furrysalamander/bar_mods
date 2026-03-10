local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
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

local parent_id = "armrock"
local new_id = "rocketeer_starfall"
local starfall_id = "legstarfall"

if UnitDefs[parent_id] and UnitDefs[starfall_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]

    -- Extreme defense, health, regen, speed
    u.health = 999999
    u.autoheal = 10000
    u.maxacc = 2.0
    u.maxdec = 4.0
    u.speed = 1000
    u.turnrate = 3000

    -- Replace weapon with starfire from Starfall, but cheap and fast
    local starfire_def = deepcopy(UnitDefs[starfall_id].weapondefs.starfire)
    starfire_def.energypershot = 1
    starfire_def.reloadtime = 0.5
    starfire_def.metalpershot = 1
    -- Keep same range as original starfire
    -- (already set in starfire_def.range)

    u.weapondefs = {
        starfire = starfire_def,
    }
    u.weapons = {
        [1] = {
            def = "STARFIRE",
            onlytargetcategory = "SURFACE",
        },
    }

    -- Customparams for UI
    u.customparams = u.customparams or {}
    u.customparams.i18n_en_humanname = "Rocketeer (Starfall)"
    u.customparams.i18n_en_tooltip = "Super-fast, invincible Rocketeer with Starfall's weapon (cheap, fast, long-range plasma)."

    -- Dynamic builder injection: add to all armada builders that build armrock
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            for _, opt in ipairs(ud.buildoptions) do
                if opt == parent_id then
                    table.insert(ud.buildoptions, new_id)
                    break
                end
            end
        end
    end
end
