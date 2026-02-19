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

	local nuke_def = deepcopy(UnitDefs["cortron"].weapondefs.cortron_weapon)
	nuke_def.commandfire = nil
	nuke_def.range = 1200

	u.weapondefs = {
		nuke_tick = nuke_def,
	}

	u.weapons = {
		[1] = {
			def = "NUKE_TICK",
			onlytargetcategory = "NOTSUB",
		},
	}

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
