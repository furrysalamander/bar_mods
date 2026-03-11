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

-- clone and brutally buff the Armada Chainsaw (armcir) AA turret
local parent_id = "armcir"
local new_id    = "if_it_flies_it_dies"

if UnitDefs[parent_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]

    -- eye‑watering detection
    u.airsightdistance = 100000

    -- make it almost indestructible just for fun
    u.health = u.health * 5
    u.autoheal = (u.autoheal or 0) + 100

    -- weapon overrides
    if u.weapondefs and u.weapondefs.arm_cir then
        local w = u.weapondefs.arm_cir
        -- ridiculous range and damage
        w.range   = 100000
        w.reloadtime = 0.05
        w.burst      = 8
        w.burstrate  = 0.01
        w.damage = {
            default = 0,
            vtol    = 100000,
        }
        -- keep the missiles looking the same but they zip like lasers
        w.weapontype = "Cannon"
        w.weaponvelocity = 5000
        w.startvelocity  = 5000
        w.turnrate       = 100000
        Spring.Echo("[if_it_flies_it_dies] weapon buffed to annihilate air")
    end

    -- UI info
    u.customparams = u.customparams or {}
    u.customparams.i18n_en_humanname = "If It Flies, It Dies"
    u.customparams.i18n_en_tooltip = "Armada Chainsaw with obscene range, RoF & damage. Nothing airborne will survive."

    -- add to all_armada builders that can make the parent
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
