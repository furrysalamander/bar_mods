-- Fast Carrier: tried to make one that drop unlimited behemoths but it seems like the game doesn't like that.

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

local parent_id = "armatlas"
local new_id = "behemoth_carrier"
local behemoth_id = "corjugg"

if UnitDefs[parent_id] and UnitDefs[behemoth_id] and not UnitDefs[new_id] then
    UnitDefs[new_id] = deepcopy(UnitDefs[parent_id])
    local u = UnitDefs[new_id]

    -- Extreme defense, health, regen, speed
    u.health = 999999
    u.autoheal = 10000
    u.maxacc = 2.0
    u.maxdec = 4.0
    u.speed = 1000
    u.turnrate = 3000

    -- Always carries a behemoth, unlimited unloads
    u.transportcapacity = 1
    u.transportsize = 7
    u.transportmass = 20000
    u.transportunloadmethod = 0
    u.customparams = u.customparams or {}
    u.customparams.i18n_en_humanname = "Fast Carrier"
    u.customparams.i18n_en_tooltip = "Super-fast, invincible plane that always carries and unloads unlimited Behemoths."
    u.customparams.behemoth_autoload = behemoth_id

    -- Dynamic builder injection: add to all armada builders that build armatlas
    for name, ud in pairs(UnitDefs) do
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
