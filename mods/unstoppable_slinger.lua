-- Unstoppable Slinger Mod: clones armmav (Gunslinger) with extreme survivability and minimal damage
-- See advanced_modding_report.md for workflow and injection logic

return function(UnitDefs)
    -- Clone armmav to unstoppable_slinger
    UnitDefs["unstoppable_slinger"] = table.copy(UnitDefs["armmav"])
    local u = UnitDefs["unstoppable_slinger"]

    -- Epic survivability
    u.health = 999999
    u.autoheal = 10000
    u.maxacc = 1.0
    u.maxdec = 2.0
    u.speed = 200
    u.turnrate = 3000

    -- Minimal damage
    if u.weapondefs and u.weapondefs.armmav_weapon then
        u.weapondefs.armmav_weapon.damage.default = 1
        u.weapondefs.armmav_weapon.damage.vtol = 1
    end

    -- Customparams for UI
    u.customparams = u.customparams or {}
    u.customparams.humanname = "Unstoppable Slinger"
    u.customparams.tooltip = "Epic tank bot: nearly indestructible, but does almost no damage."

    -- Dynamic builder injection: add to all armada builders that build armmav
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            for i, opt in ipairs(ud.buildoptions) do
                if opt == "armmav" then
                    table.insert(ud.buildoptions, "unstoppable_slinger")
                end
            end
        end
    end
end
