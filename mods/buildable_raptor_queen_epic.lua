-- Buildable Raptor Queen Epic Mod
-- Makes raptor_queen_epic buildable by all builders and commander, very cheap, and 3x speed

return function(UnitDefs)
    -- Triple the speed of raptor_queen_epic and make it very cheap
    if UnitDefs["raptor_queen_epic"] then
        UnitDefs["raptor_queen_epic"].speed = (UnitDefs["raptor_queen_epic"].speed or 75.0) * 3
        UnitDefs["raptor_queen_epic"].metalcost = 100
        UnitDefs["raptor_queen_epic"].energycost = 100
        UnitDefs["raptor_queen_epic"].buildtime = 100
        UnitDefs["raptor_queen_epic"].customparams = UnitDefs["raptor_queen_epic"].customparams or {}
        UnitDefs["raptor_queen_epic"].customparams.humanname = "Buildable Raptor Queen Epic"
        UnitDefs["raptor_queen_epic"].customparams.tooltip = "Epic Raptor Queen: Now buildable by Commander and regular builders, moves 3x faster, very cheap."
    end

    -- Inject into all builders (including armcom) that can build
    for name, ud in pairs(UnitDefs) do
        if ud.buildoptions then
            -- Only inject if not already present
            local found = false
            for _, opt in ipairs(ud.buildoptions) do
                if opt == "raptor_queen_epic" then found = true break end
            end
            if not found then
                table.insert(ud.buildoptions, "raptor_queen_epic")
            end
        end
    end
end
