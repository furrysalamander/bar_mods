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
    armbrtha = "armepicarty",
    corint = "corepicarty",
    leglrpc = "legepicarty"
}

for parentID, newID in pairs(parents) do
    if UnitDefs[parentID] then
        local u = deepcopy(UnitDefs[parentID])
        
        -- Identity
        u.name = newID
        if not u.customparams then u.customparams = {} end
        u.customparams.i18n_en_humanname = "Epic Artillery"
        u.customparams.i18n_en_tooltip = "Super Overpowered Ultimate Range Artillery"
        
        -- Overpowered Functional Stats
        u.health = 45000
        u.maxdamage = 45000
        u.buildtime = 100000
        u.metalcost = 15000
        u.energycost = 150000
        
        if u.weapondefs then
            for wid, wdef in pairs(u.weapondefs) do
                wdef.range = 15000
                if not wdef.weaponvelocity or wdef.weaponvelocity < 3500 then
                    wdef.weaponvelocity = 3500
                end
                if wdef.damage and wdef.damage.default then
                    wdef.damage.default = wdef.damage.default * 5
                end
                wdef.reloadtime = 1 -- Fast reload
            end
        end
        
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
