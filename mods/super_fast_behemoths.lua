--========================================
-- Super Fast Behemoths Mod
-- Makes behemoth-class units significantly faster
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

-- Speed multipliers for each faction
-- Original speeds: armbanth=45.6, corjugg=16.5, legeheatraymech=40
-- Super fast speeds: ~180 (4x faster)
local behemoths = {
    { id = "armbehemothfast", parent = "armbanth", speed = 720 },
    { id = "corbehemothfast", parent = "corjugg",  speed = 720 },
    { id = "legbehemothfast", parent = "legeheatraymech", speed = 720 },
}

for _, cfg in ipairs(behemoths) do
    if not UnitDefs[cfg.parent] then
        Spring.Echo("[SuperFastBehemoths] Parent unit '" .. cfg.parent .. "' not found, skipping " .. cfg.id)
    else
        local u = deepcopy(UnitDefs[cfg.parent])

        -- Identity
        u.name = cfg.id
        if not u.customparams then u.customparams = {} end
        u.customparams.i18n_en_humanname = "Super Fast Behemoth"
        u.customparams.i18n_en_tooltip = "Super fast behemoth-class unit with increased speed"

        -- Speed modifications
        u.speed = cfg.speed

        -- Cost adjustments (slightly higher for the speed boost)
        u.metalcost = u.metalcost and math.floor(u.metalcost * 1.2) or nil
        u.energycost = u.energycost and math.floor(u.energycost * 1.2) or nil
        u.buildtime = u.buildtime and math.floor(u.buildtime * 0.8) or nil

        UnitDefs[cfg.id] = u

        -- Register with the Modpack Manager for test-mode injection
        if MOD_ADDED_UNITS then
            table.insert(MOD_ADDED_UNITS, cfg.id)
        end

        Spring.Echo("[SuperFastBehemoths] Created " .. cfg.id .. " (parent: " .. cfg.parent .. ", speed: " .. cfg.speed .. ")")

        -- Dynamic builder injection: add the fast behemoth to every builder
        -- that already builds the parent behemoth
        for _, ud in pairs(UnitDefs) do
            if ud.buildoptions then
                for _, opt in ipairs(ud.buildoptions) do
                    if opt == cfg.parent then
                        table.insert(ud.buildoptions, cfg.id)
                        break
                    end
                end
            end
        end
    end
end

end
