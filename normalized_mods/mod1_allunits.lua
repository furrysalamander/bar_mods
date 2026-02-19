-- Source: Allunits.txt

-- Command: tweakdefs
UnitDefs["legparadrone"] = table.copy(UnitDefs["legdrone"])
UnitDefs["legparadrone"].customparams.i18nfromunit = "legdrone"
UnitDefs["legparadrone"].health = 2000

UnitDefs["legparagon"] = table.copy(UnitDefs["leghive"])
UnitDefs["legparagon"].metalcost = 2000
UnitDefs["legparagon"].energycost = 20000
UnitDefs["legparagon"].buildtime = 30000
UnitDefs["legparagon"].footprintx = 4
UnitDefs["legparagon"].footprintz = 4
UnitDefs["legparagon"].health = 20000
UnitDefs["legparagon"].sightdistance = 500
UnitDefs["legparagon"].customparams.techlevel = 3
UnitDefs["legparagon"].idleautoheal = 50
UnitDefs["legparagon"].idletime = 800
UnitDefs["legparagon"].customparams.i18n_en_humanname = "Paragon"
UnitDefs["legparagon"].customparams.i18n_en_tooltip = "Advanced fortification which produces up to 6 drones with miniguns"
UnitDefs["legparagon"].crushresistance = 5000

UnitDefs["cortyrant"] = table.copy(UnitDefs["corfort"])
UnitDefs["cortyrant"].metalcost = 6000
UnitDefs["cortyrant"].energycost = 40000
UnitDefs["cortyrant"].buildtime = 40000
UnitDefs["cortyrant"].footprintx = 2
UnitDefs["cortyrant"].footprintz = 6
UnitDefs["cortyrant"].health = 40000
UnitDefs["cortyrant"].sightdistance = 200
UnitDefs["cortyrant"].customparams.techlevel = 3
UnitDefs["cortyrant"].customparams.i18n_en_humanname = "Tyrant"
UnitDefs["cortyrant"].customparams.i18n_en_tooltip = "Advanced memoryalloy fortification which can regenerate."
UnitDefs["cortyrant"].idleautoheal = 0
UnitDefs["cortyrant"].idletime = 0
UnitDefs["cortyrant"].autoheal = 400
UnitDefs["cortyrant"].crushresistance = 10000
UnitDefs["cortyrant"].customparams.buildinggrounddecalsizex = 4
UnitDefs["cortyrant"].customparams.buildinggrounddecalsizey = 8
UnitDefs["cortyrant"].collisionvolumescales = "32 52 96"

UnitDefs["armfirewall"] = table.copy(UnitDefs["armlwall"])
UnitDefs["armfirewall"].metalcost = 3000
UnitDefs["armfirewall"].energycost = 20000
UnitDefs["armfirewall"].buildtime = 30000
UnitDefs["armfirewall"].footprintx = 4
UnitDefs["armfirewall"].footprintz = 4
UnitDefs["armfirewall"].sightdistance = 500
UnitDefs["armfirewall"].health = 25000
UnitDefs["armfirewall"].customparams.techlevel = 3
UnitDefs["armfirewall"].customparams.i18n_en_humanname = "Equalizer"
UnitDefs["armfirewall"].customparams.i18n_en_tooltip = "Advanced fortification with a lightning arc EMP."
UnitDefs["armfirewall"].crushresistance = 5000
UnitDefs["armfirewall"].customparams.buildinggrounddecalsizex = 6
UnitDefs["armfirewall"].customparams.buildinggrounddecalsizey = 6


UnitDefs["armnanotc3"] = table.copy(UnitDefs["armrespawn"])
UnitDefs["armnanotc3"].customparams.i18n_en_humanname = "Epic Construction Turret"
UnitDefs["armnanotc3"].customparams.i18n_en_tooltip = "Enormous assist & repair in a very short radius"
UnitDefs["armnanotc3"].builddistance = 200
UnitDefs["armnanotc3"].sightdistance = 500
UnitDefs["armnanotc3"].energymake = 50
UnitDefs["armnanotc3"].blocking = true
UnitDefs["armnanotc3"].workertime = 10000
UnitDefs["armnanotc3"].energycost = 200000
UnitDefs["armnanotc3"].metalcost = 10000
UnitDefs["armnanotc3"].buildtime = 100000
UnitDefs["armnanotc3"].minwaterdepth = -1000
UnitDefs["armnanotc3"].maxslope = 36

UnitDefs["cornanotc3"] = table.copy(UnitDefs["correspawn"])
UnitDefs["cornanotc3"].customparams.i18n_en_humanname = "Epic Construction Turret"
UnitDefs["cornanotc3"].customparams.i18n_en_tooltip = "Enormous assist & repair in a very short radius"
UnitDefs["cornanotc3"].builddistance = 200
UnitDefs["cornanotc3"].sightdistance = 500
UnitDefs["cornanotc3"].energymake = 50
UnitDefs["cornanotc3"].blocking = true
UnitDefs["cornanotc3"].workertime = 10000
UnitDefs["cornanotc3"].energycost = 200000
UnitDefs["cornanotc3"].metalcost = 10000
UnitDefs["cornanotc3"].buildtime = 100000
UnitDefs["cornanotc3"].minwaterdepth = -1000
UnitDefs["cornanotc3"].maxslope = 36

UnitDefs["legnanotc3"] = table.copy(UnitDefs["legnanotcbase"])
UnitDefs["legnanotc3"].customparams.i18n_en_humanname = "Epic Construction Turret"
UnitDefs["legnanotc3"].customparams.i18n_en_tooltip = "Enormous assist & repair in a very short radius"
UnitDefs["legnanotc3"].builddistance = 200
UnitDefs["legnanotc3"].sightdistance = 500
UnitDefs["legnanotc3"].energymake = 50
UnitDefs["legnanotc3"].blocking = true
UnitDefs["legnanotc3"].workertime = 10000
UnitDefs["legnanotc3"].energycost = 200000
UnitDefs["legnanotc3"].metalcost = 10000
UnitDefs["legnanotc3"].buildtime = 100000
UnitDefs["legnanotc3"].minwaterdepth = -1000
UnitDefs["legnanotc3"].maxslope = 36

UnitDefs["corageot3"] = table.copy(UnitDefs["corageo"])
UnitDefs["corageot3"].customparams.i18n_en_humanname = "Barrage"
UnitDefs["corageot3"].customparams.i18n_en_tooltip = "Geothermal seeker rocket platform"
UnitDefs["corageot3"].metalcost = 3000
UnitDefs["corageot3"].energycost =40000
UnitDefs["corageot3"].buildtime = 40000
UnitDefs["corageot3"].energymake = 600
UnitDefs["corageot3"].energystorage = 30000
UnitDefs["corageot3"].customparams.techlevel = 3
UnitDefs["corageot3"].health = 6000
UnitDefs["corageot3"].sightdistance = 500
UnitDefs["corageot3"].customparams.removestop = false
UnitDefs["corageot3"].customparams.removewait = false
UnitDefs["corageot3"].onoffable = true
UnitDefs["corageot3"].script = "Units/CORSILO.cob"

UnitDefs["armageot3"] = table.copy(UnitDefs["armageo"])
UnitDefs["armageot3"].customparams.i18n_en_humanname = "Outpost"
UnitDefs["armageot3"].customparams.i18n_en_tooltip = "Geothermal cloakable intelligence providing vision, jammer, tremorsense, and 100k storage."
UnitDefs["armageot3"].metalcost = 2700
UnitDefs["armageot3"].energycost =38000
UnitDefs["armageot3"].buildtime = 35000
UnitDefs["armageot3"].energymake = 600
UnitDefs["armageot3"].energystorage = 100000
UnitDefs["armageot3"].metalmake = 1
UnitDefs["armageot3"].metalstorage = 100000
UnitDefs["armageot3"].customparams.techlevel = 3
UnitDefs["armageot3"].health = 4000
UnitDefs["armageot3"].seismicdistance = 2000
UnitDefs["armageot3"].radardistancejam = 800
UnitDefs["armageot3"].sightdistance = 2000
UnitDefs["armageot3"].cloakCost = 100
UnitDefs["armageot3"].minCloakDistance = 100
UnitDefs["armageot3"].canCloak = true
UnitDefs["armageot3"].initCloaked = true

for name, ud in pairs(UnitDefs) do
  local cp = ud.customparams
  if ud.buildoptions and tonumber(cp.techlevel) == 2 and tonumber(ud.maxacc)>0 then
    if name:find("^arm") then
      table.insert(ud.buildoptions, "armageot3")
      table.insert(ud.buildoptions, "armnanotc3")
      table.insert(ud.buildoptions, "armfirewall")
    elseif name:find("^cor") then
      table.insert(ud.buildoptions, "corageot3")
      table.insert(ud.buildoptions, "cornanotc3")
      table.insert(ud.buildoptions, "cortyrant")
    elseif name:find("^leg") then
      table.insert(ud.buildoptions, "legnanotc3")
      table.insert(ud.buildoptions, "legparagon")
    end
  end
end

-- Command: tweakunits
{
legparadrone = {
weapondefs = {
			semiauto = {
				accuracy = 7,
				areaofeffect = 16,
				avoidfeature = false,
				burnblow = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:plasmahit-sparkonly",
				impulsefactor = 0.123,
				intensity = 0.8,
				name = "Full Autmatic Machine Gun",
				noselfdamage = true,
				ownerExpAccWeight = 4.0,
				proximitypriority = 1,
				range = 300,
				reloadtime = 0.1,
				rgbcolor = "1 0.95 0.4",
				soundhit = "bimpact3",
				soundhitwet = "splshbig",
				soundstart = "mgun3",
				soundtrigger = true,
				sprayangle = 1024,
				texture1 = "shot",
				texture2 = "empty",
				thickness = 2.0,
				tolerance = 6000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 692,
				damage = {
					default = 7,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "SEMIAUTO",
				maindir = "0 0 1",
				maxangledif = 90,
				onlytargetcategory = "NOTSUB",
			},
		},
},
legparagon = {
weapondefs = {
			plasma = {
				areaofeffect = 4,
				avoidfeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "",
				gravityaffected = "true",
				hightrajectory = 1,
				impulsefactor = 0.123,
				name = "HeavyCannon",
				noselfdamage = true,
				metalpershot = 15,
				energypershot = 500,
				range = 1100,
				reloadtime = 2.5,
				size = 0,
				soundhit = "",
				soundhitwet = "",
				soundstart = "",
				stockpile = true,
				stockpiletime = 10,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1000,
				damage = {
					default = 0,
				},
				customparams = {
					carried_unit = "legparadrone",     --Name of the unit spawned by this carrier unit.
					engagementrange = 1100,
					spawns_surface = "LAND",    -- "LAND" or "SEA". The SEA option has not been tested currently.
					spawnrate = 8, 				--Spawnrate roughly in seconds.
					maxunits = 6,				--Will spawn units until this amount has been reached.
					energycost = 500,			--Custom spawn cost. Remove this or set = nil to inherit the cost from the carried_unit unitDef. Cost inheritance is currently not working.
					metalcost = 15,				--Custom spawn cost. Remove this or set = nil to inherit the cost from the carried_unit unitDef. Cost inheritance is currently not working.
					controlradius = 1200,			--The spawned units should stay within this radius. Unfinished behavior may cause exceptions. Planned: radius = 0 to disable radius limit.
					decayrate = 4,
					carrierdeaththroe = "release",
					dockingarmor = 0.2,
					dockinghealrate = 16,
					docktohealthreshold = 66,
					enabledocking = true,		--If enabled, docking behavior is used. Currently docking while moving or stopping, and undocking while attacking. Unfinished behavior may cause exceptions.
					dockingHelperSpeed = 5,
					dockingpieces = "4 5 6 7 8 9",
					dockingradius = 80,			--The range at which the units snap to the carrier unit when docking.
					stockpilelimit = 6,
					stockpilemetal = 15,
					stockpileenergy = 500,
				}
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "PLASMA",
				onlytargetcategory = "NOTSUB",
			},
		},
},
armfirewall = {
weapondefs = {
			lightning = {
				areaofeffect = 8,
				avoidfeature = false,
				beamttl = 1,
				burst = 4,
				burstrate = 0.02,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				duration = 1,
				edgeeffectiveness = 0.15,
				energypershot = 5,
				explosiongenerator = "custom:genericshellexplosion-large-lightning2",
				firestarter = 50,
				impactonly = 1,
				impulsefactor = 0,
				intensity = 28, --was 24
				name = "EMP Lightning Cannon",
				noselfdamage = true,
				range = 500,
				reloadtime = 0.1,
				rgbcolor = "0.5 0.5 1",
				soundhit = "lashit",
				soundhitwet = "sizzle",
				soundstart = "lghthvy1",
				soundtrigger = true,
				thickness = 2.2,
				turret = true,
				weapontype = "LightningCannon",
				weaponvelocity = 400,
				paralyzer = true,
				paralyzetime = 8,
				damage = {
					default = 40,
				},
			},
},
		weapons = {
			[1] = {
				def = "lightning",
				onlytargetcategory = "NOTSUB",
				fastautoretargeting = true,
			},
		},
},
corageot3 = {
weapondefs = {
cor_georockets = {
				areaofeffect = 200,
				avoidfeature = true,
				avoidfriendly = false,
				burnblow = true,
				canattackground = true,
				castshadow = false,
				cegtag = "missiletrailaa-large",
				collidefriendly = false,
				craterareaofeffect = 200,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.6,
				energypershot = 0,
				explosiongenerator = "custom:genericshellexplosion-huge-aa",
				firestarter = 90,
				flighttime = 10,
				impulsefactor = 0,
				metalpershot = 0,
				model = "corscreamermissile.s3o",
				name = "Long Range Seeker Rocket Platform",
				noselfdamage = true,
				proximitypriority = -1,
				range = 1500,
				reloadtime = 1.2,
				smokecolor = 0.9,
				smokeperiod = 2,
				smokesize = 4,
				smoketime = 24,
				smoketrail = true,
				smoketrailcastshadow = false,
				soundhit = "impact",
				soundhitvolume = 8,
				soundhitwet = "splslrg",
				soundstart = "aarocket",
				soundstartvolume = 8,
				startvelocity = 1000,
				texture1 = "null",
				texture2 = "smoketrailaaflak",
				tolerance = 10000,
				tracks = true,
				trajectoryheight = 2,
				turnrate = 40000,
				turret = true,
				weapontimer = 1,
				weaponacceleration = 1000,
				weapontype = "StarburstLauncher",
				weaponvelocity = 1400,
				damage = {
					default  = 900,
					vtol = 2000,
					commander = 450,
				},
			},
},
weapons = {
[1] = {
				def = "COR_GEOROCKETS",
				fastautoretargeting = true,
				onlytargetcategory = "NOTSUB",
    },
},
},
}

