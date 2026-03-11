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

-- create an overpowered version of the Armada Keeper
local parent_id = "armgate"
local new_id    = "diamondium_keeper"

if UnitDefs[parent_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]

    -- extreme durability
    u.health = u.health * 50
    u.autoheal = (u.autoheal or 0) + 500
    u.metalcost = u.metalcost * 0.010
    u.energycost = u.energycost * 0.010

    -- massive shield improvements
    if u.weapondefs and u.weapondefs.repulsor then
        local s = u.weapondefs.repulsor.shield
        -- make radius double/triple
        s.radius = s.radius * 3
        s.power  = s.power * 100
        s.powerregen = s.powerregen * 0.050
        s.powerregenenergy = s.powerregenenergy * 0.050
        s.startingpower = s.power * 0.5
        s.force = s.force * 5
        Spring.Echo("[diamondium_keeper] shield stats blown up")
    end

    -- UI metadata
    u.customparams = u.customparams or {}
    u.customparams.i18n_en_humanname = "Diamondium Keeper"
    u.customparams.i18n_en_tooltip = "Unbreakable gate with a gigantic crystal shield – designed to shrug off waves of epic artillery."

    -- inject into Armada builders that could make the original
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
