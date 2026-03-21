for name, ud in pairs(UnitDefs) do
	if name == "armflea" or name == "corak" or name == "leggob" or name == "corakt4" or name == "leggobt3" then
		if ud.weapondefs then
			for weaponName, weaponDef in pairs(ud.weapondefs) do
				weaponDef.burstrate = 0
				weaponDef.reloadtime = 0
			end
		end
	end
end

Spring.Echo("no_cooldown_ticks_grunts_goblins.lua loaded: Removed cooldowns from ticks, grunts, and goblins")
