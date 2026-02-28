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

local parents = {
    armarad = "armepicrad",
    corarad = "corepicrad",
    legarad = "legepicrad"
}

for parentID, newID in pairs(parents) do
    if UnitDefs[parentID] then
        local u = deepcopy(UnitDefs[parentID])
        
        -- Identity
        u.name = newID
        if not u.customparams then u.customparams = {} end
        u.customparams.i18n_en_humanname = "Epic Radar"
        u.customparams.i18n_en_tooltip = "Super Overpowered Ultimate Intelligence Tier Radar"
        
        -- Overpowered Functional Stats
        u.radardistance = 15000
        u.radardistancejam = 15000 -- Just in case they have jammers
        u.health = 25000
        u.maxdamage = 25000
        u.buildtime = 50000
        u.metalcost = 6000
        u.energycost = 80000
        u.energyuse = 1000 -- high upkeep
        
        UnitDefs[newID] = u
        
        if MOD_ADDED_UNITS then
            table.insert(MOD_ADDED_UNITS, newID)
        end
        
        -- Procedural dynamic builder injection
        -- Find the builder that builds the 'parent' and inject the new unit
        for name, ud in pairs(UnitDefs) do
            if ud.buildoptions then
                for i, opt in ipairs(ud.buildoptions) do
                    if opt == parentID then
                        table.insert(ud.buildoptions, newID)
                        break
                    end
                end
            end
        end
    end
end
