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

local parent_id = "armspy"
local new_id = "my_neighbor_steve"

if UnitDefs[parent_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]

    -- Super survivability (copied from unstoppable_slinger)
    u.health = 999999
    u.autoheal = 10000
    u.maxacc = 1.0
    u.maxdec = 2.0
    u.turnrate = 3000

    -- Even faster than unstoppable_slinger
    u.speed = 300

    -- Cheap to make and cloak
    u.metalcost = 10
    u.energycost = 10
    u.cloakcost = 1
    u.cloakcostmoving = 2

    -- always use the EMP-style explosion, not the small generic one
    u.explodeas = "SPYBOMBX"
    u.selfdestructas = "SPYBOMBX"

    -- Customparams for UI
    u.customparams = u.customparams or {}
    u.customparams.i18n_en_humanname = "My Neighbor Steve"
    u.customparams.i18n_en_tooltip = "Super-fast, super cheap, super creepy – and when he blows up he lets out a massive EMP pulse!"

    -- Make the spy-bomb weapon much larger and longer‑lasting so only this mod deploys it
    -- (patches the global definition; affects all spies but is triggered when our unit exists)
    if WeaponDefs and WeaponDefs.spybombx then
        -- increase area and stun duration
        WeaponDefs.spybombx.areaofeffect = 20000
        WeaponDefs.spybombx.paralyzetime = 60
        -- make sure the custom exception stays in line with the new duration
        WeaponDefs.spybombx.customparams = WeaponDefs.spybombx.customparams or {}
        WeaponDefs.spybombx.customparams.paralyzetime_exception = "isBuilding=false:30,customparams.unitgroup=antinuke:40"
        Spring.Echo("[my_neighbor_steve] upgraded spybombx aoe and paralyzetime")
    end

    -- Dynamic builder injection: add to all armada builders that build armspy
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