-- Scavboss Heat Ray Mod: clones scavengerbossv4 with only heat ray weapons from Sol Invictus
-- Heat rays attack 3x faster, construction cost is very low

return function(UnitDefs)
    -- Clone scavengerbossv4 to scavboss_heatray
    UnitDefs["scavboss_heatray"] = table.copy(UnitDefs["scavengerbossv4"])
    local u = UnitDefs["scavboss_heatray"]

    -- Set construction cost very low
    u.metalcost = 100
    u.energycost = 100
    u.buildtime = 100

    -- Replace all weapons with heatray1 from legeheatraymech
    local heatray = nil
    if UnitDefs["legeheatraymech"] and UnitDefs["legeheatraymech"].weapondefs and UnitDefs["legeheatraymech"].weapondefs.heatray1 then
        heatray = table.copy(UnitDefs["legeheatraymech"].weapondefs.heatray1)
        heatray.reloadtime = (heatray.reloadtime or 0.033) / 3 -- 3x faster
    end
    if heatray then
        u.weapondefs = { heatray1 = heatray }
        u.weapons = {}
        for i = 1, 6 do -- Give 6 heat rays
            table.insert(u.weapons, { def = "heatray1", onlytargetcategory = "NOTSUB" })
        end
    end

    -- Customparams for UI
    u.customparams = u.customparams or {}
    u.customparams.humanname = "Scavboss Heat Ray"
    u.customparams.tooltip = "Scavenger Boss with only Heat Rays (from Sol Invictus), attacks 3x faster, very cheap to build."

    -- Dynamic builder injection: add to all builders that build scavengerbossv4
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            for i, opt in ipairs(ud.buildoptions) do
                if opt == "scavengerbossv4" then
                    table.insert(ud.buildoptions, "scavboss_heatray")
                end
            end
        end
    end
end
