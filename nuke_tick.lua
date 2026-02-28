local function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
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

local parent_id = "armflea"
local new_id = "armfleanuke"

if UnitDefs[parent_id] and not UnitDefs[new_id] then
	UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
	local u = UnitDefs[new_id]

	u.name = new_id
	u.customparams = u.customparams or {}
	u.customparams.i18n_en_humanname = "Tick (Nuke)"
	u.customparams.i18n_en_tooltip = "Ultra-fast tactical nuke launcher. Fires automatically."
	u.customparams.unitgroup = "weapon"

	u.activatewhenbuilt = true
	u.onoffable = false
	u.radardistance = 2200

	local nuke_def = deepcopy(UnitDefs["cortron"].weapondefs.cortron_weapon)
	nuke_def.commandfire = nil
	nuke_def.range = 1200
	nuke_def.energypershot = 1
	nuke_def.metalpershot = 1
	nuke_def.reloadtime = 0.1
	nuke_def.stockpiletime = 1
	nuke_def.targetable = 1

	u.weapondefs = {
		nuke_tick = nuke_def,
	}

	u.weapons = {
		[1] = {
			def = "NUKE_TICK",
			onlytargetcategory = "NOTSUB",
		},
	}
    
    if MOD_ADDED_UNITS then
        table.insert(MOD_ADDED_UNITS, new_id)
    end

	for _, ud in pairs(UnitDefs) do
		if ud.buildoptions then
			for _, opt in ipairs(ud.buildoptions) do
				if opt == parent_id then
					table.insert(ud.buildoptions, new_id)
					break
				end
			end
		end
	end
end

-- Anti-Nuke Tick: intercepts nuke tick projectiles
local antinuke_parent_id = "armflea"
local antinuke_new_id = "armfleaantinuke"

if UnitDefs[antinuke_parent_id] and UnitDefs["armamd"] and not UnitDefs[antinuke_new_id] then
	UnitDefs[antinuke_new_id] = deepcopy(UnitDefs[antinuke_parent_id])
	local u = UnitDefs[antinuke_new_id]

	u.name = antinuke_new_id
	u.customparams = u.customparams or {}
	u.customparams.i18n_en_humanname = "Tick (Anti-Nuke)"
	u.customparams.i18n_en_tooltip = "Ultra-fast anti-nuke interceptor. Auto-stockpiles and shoots down nukes."
	u.customparams.unitgroup = "antinuke"

	u.activatewhenbuilt = true
	u.onoffable = false
	u.radardistance = 2200

	local antinuke_def = deepcopy(UnitDefs["armamd"].weapondefs.amd_rocket)
	antinuke_def.stockpiletime = 1
	antinuke_def.energypershot = 1
	antinuke_def.metalpershot = 1
	antinuke_def.coverage = 1500
	antinuke_def.weaponvelocity = 8000

	u.weapondefs = {
		antinuke_tick = antinuke_def,
	}

	u.weapons = {
		[1] = {
			def = "ANTINUKE_TICK",
		},
	}
    
    if MOD_ADDED_UNITS then
        table.insert(MOD_ADDED_UNITS, antinuke_new_id)
    end

	for _, ud in pairs(UnitDefs) do
		if ud.buildoptions then
			for _, opt in ipairs(ud.buildoptions) do
				if opt == antinuke_parent_id then
					table.insert(ud.buildoptions, antinuke_new_id)
					break
				end
			end
		end
	end
end
