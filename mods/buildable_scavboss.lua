-- Buildable Scavenger Final Boss Mod
-- Makes scavengerbossv4 buildable by armcom and increases its speed

return function(UnitDefs)
    -- Triple the speed of scavengerbossv4
    if UnitDefs["scavengerbossv4"] then
        UnitDefs["scavengerbossv4"].speed = (UnitDefs["scavengerbossv4"].speed or 37.5) * 3
        UnitDefs["scavengerbossv4"].customparams = UnitDefs["scavengerbossv4"].customparams or {}
        UnitDefs["scavengerbossv4"].customparams.humanname = "Scavenger Final Boss"
        UnitDefs["scavengerbossv4"].customparams.tooltip = "Epic Scavenger Boss: Now buildable by Commander and moves 3x faster."
    end

    -- Inject into all builders (including armcom) that can build
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            -- Only inject if not already present
            local found = false
            for _, opt in ipairs(ud.buildoptions) do
                if opt == "scavengerbossv4" then found = true break end
            end
            if not found then
                table.insert(ud.buildoptions, "scavengerbossv4")
            end
        end
    end
end
