--========================================
-- Behemoth Launcher Mod
-- Makes the Pawn Launcher shoot Behemoths
--========================================
do
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

-- Parent units and their behemoth counterparts
local parents = {
    armbotrail = "armbehemothrail",
    cormwall   = "corbehemothrail",
    legdtf     = "legbehemothrail"
}

-- Mappings for spawns_name parameter
local spawns_map = {
    armbotrail = "corjugg",           -- Arm Pawn Launcher shoots Cortex Behemoth
    cormwall   = "legerailtank",      -- Cor launcher shoots Legion heavy unit
    legdtf     = "corkorg"            -- Leg launcher shoots CorJuggernaut
}

for parentID, newID in pairs(parents) do
    if UnitDefs[parentID] then
        local u = deepcopy(UnitDefs[parentID])
        
        -- Identity
        u.name = newID
        if not u.customparams then u.customparams = {} end
        u.customparams.i18n_en_humanname = "Behemoth Launcher"
        u.customparams.i18n_en_tooltip = "Launcher that fires heavyunits instead of regular bots"
        
        -- Update weapon to spawn behemoth instead of regular units
        if u.weapondefs then
            for wid, wdef in pairs(u.weapondefs) do
                if wdef.customparams and wdef.customparams.spawns_name then
                    if spawns_map[parentID] then
                        wdef.customparams.spawns_name = spawns_map[parentID]
                    end
                end
            end
        end
        
        -- Reasonable costs for a T3 launcher equivalent
        u.buildtime = 120000
        u.metalcost = 8000
        u.energycost = 50000
        u.health = 15000
        u.maxdamage = 15000
        
        UnitDefs[newID] = u
        
        if MOD_ADDED_UNITS then
            table.insert(MOD_ADDED_UNITS, newID)
        end
        
        -- Procedural dynamic builder injection
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

end