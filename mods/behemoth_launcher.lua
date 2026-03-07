--========================================
-- Behemoth Launcher Mod
-- Fires faction-appropriate behemoth-class units
--
-- All three launchers clone armbotrail (the only pawn launcher in the game).
-- If armbotrail is unavailable (scavengers pack not loaded), we fall back to
-- armferret and rebuild the spawner weapon inline so the mod always works.
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

-- armbotrail is the only pawn-launcher building in the game.
-- It lives in the Scavengers folder and may be absent when scavs are disabled.
-- armferret is a guaranteed-present Arm static launcher building we use as a fallback.
local baseID = UnitDefs["armbotrail"] and "armbotrail" or "armferret"

-- Per-faction config:
--   id            = internal name for the new unit
--   spawns        = unit fired by the launcher weapon
--   inject_parent = whose builders we inject into (launcher appears next to this unit)
local factions = {
    { id = "armbehemothrail",  spawns = "armbanth",        inject_parent = "armbanth"        },
    { id = "corbehemothrail",  spawns = "corjugg",         inject_parent = "corjugg"         },
    { id = "legbehemothrail",  spawns = "legeheatraymech", inject_parent = "legeheatraymech" },
}

-- Full spawner weapon definition mirrored from armbotrail.
-- Used when we fall back to armferret so the weapon is always correct.
local function makeSpawnerWeapon(spawnsName)
    return {
        behemoth_botrail = {
            accuracy            = 1,
            areaofeffect        = 10,
            avoidfeature        = false,
            avoidfriendly       = false,
            cegtag              = "arty-botrail",
            collidefriendly     = false,
            craterareaofeffect  = 116,
            craterboost         = 0.1,
            cratermult          = 0.1,
            edgeeffectiveness   = 0.15,
            energypershot       = 2880,
            explosiongenerator  = "custom:botrailspawn",
            gravityaffected     = "true",
            heightboostfactor   = 8,
            hightrajectory      = 0,
            impulsefactor       = 0.5,
            leadbonus           = 0,
            metalpershot        = 96,
            model               = "armpw_anim_projectile.s3o",
            mygravity           = 0.22,
            name                = "Long range behemoth cannon",
            noselfdamage        = true,
            range               = 5250,
            reloadtime          = 0.5,
            sprayangle          = 720,
            stockpile           = true,
            stockpiletime       = 3,
            soundhit            = "xplonuk1xs",
            soundhitwet         = "splshbig",
            soundstart          = "lrpcshot3",
            soundstartvolume    = 50,
            turret              = true,
            waterbounce         = true,
            bounceSlip          = 0.74,
            bouncerebound       = 0.5,
            numbounce           = 10,
            weapontype          = "Cannon",
            weaponvelocity      = 1250,
            customparams = {
                spawns_name    = spawnsName,
                spawns_surface = "LAND",
                stockpilelimit = 10,
            },
            damage = {
                default = 10,
                shields = 150,
            },
        },
    }
end

for _, cfg in ipairs(factions) do
    if not UnitDefs[baseID] then
        Spring.Echo("[BehemothLauncher] base unit '" .. baseID .. "' not found, skipping " .. cfg.id)
    else
        local u = deepcopy(UnitDefs[baseID])

        -- Identity
        u.name = cfg.id
        if not u.customparams then u.customparams = {} end
        u.customparams.i18n_en_humanname = "Behemoth Launcher"
        u.customparams.i18n_en_tooltip   = "Long-range siege launcher that fires behemoth-class units"

        if baseID == "armferret" then
            -- armferret is an AA missile building; replace its weapon entirely
            -- with the botrail spawner weapon. Keep its model/script as-is.
            u.weapondefs = makeSpawnerWeapon(cfg.spawns)
            u.weapons = {
                [1] = {
                    badtargetcategory  = "MOBILE",
                    def                = "BEHEMOTH_BOTRAIL",
                    onlytargetcategory = "SURFACE",
                },
            }
            -- Remove AA-specific fields that don't apply to a ground launcher
            u.airsightdistance = nil
            u.customparams.unitgroup = "weapon"
            u.canrepeat = false
        else
            -- armbotrail: patch spawns_name inside its existing weapon definition
            if u.weapondefs then
                for _, wdef in pairs(u.weapondefs) do
                    if wdef.customparams and wdef.customparams.spawns_name then
                        wdef.customparams.spawns_name    = cfg.spawns
                        wdef.customparams.stockpilelimit = 10
                    end
                end
            end
        end

        -- Cost / durability (same for all three variants)
        u.buildtime  = 120000
        u.metalcost  = 8000
        u.energycost = 50000
        u.health     = 15000
        u.maxdamage  = 15000

        UnitDefs[cfg.id] = u

        -- Register with the Modpack Manager for test-mode injection
        if MOD_ADDED_UNITS then
            table.insert(MOD_ADDED_UNITS, cfg.id)
        end

        Spring.Echo("[BehemothLauncher] Created " .. cfg.id .. " (spawns: " .. cfg.spawns .. ", base: " .. baseID .. ")")

        -- Dynamic builder injection: add the launcher to every builder
        -- that already builds cfg.inject_parent (the respective gantry).
        for _, ud in pairs(UnitDefs) do
            if ud.buildoptions then
                for _, opt in ipairs(ud.buildoptions) do
                    if opt == cfg.inject_parent then
                        table.insert(ud.buildoptions, cfg.id)
                        break
                    end
                end
            end
        end
    end
end

end