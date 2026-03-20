for name, ud in pairs(UnitDefs) do
    if name == "armcom" or name == "corcom" or name == "legcom" then
        if ud.weapondefs and ud.weapondefs.disintegrator then
            ud.weapondefs.disintegrator.range = 5000
            Spring.Echo("[commander_dgun_ridiculous_range] Set " .. name .. " disintegrator range to 5000")
        end
    end
end
