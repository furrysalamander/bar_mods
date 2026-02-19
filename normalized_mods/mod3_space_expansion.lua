-- Source: BAR_ Space Expansion - Tabellenblatt1.csv

-- Command: tweakdefs
--Space Expansion V2.8
local _u = {}
function SET(def) _u = table.copy(UnitDefs[def]) end
function ADD(name) UnitDefs[name] = _u end
function CP()    _u.customparams = {} end
function MC(v)    _u.metalcost = v end
function EC(v)    _u.energycost= v end
function BT(v)    _u.buildtime    = v end
function FX(v)    _u.footprintx= v end
function FZ(v)    _u.footprintz= v end
function HP(v)    _u.health    = v end
function SD(v)    _u.sightdistance    = v end
function TECH(v) _u.customparams.techlevel  = v end
function NAME(v) _u.customparams.i18n_en_humanname   = v end
function DESC(v) _u.customparams.i18n_en_tooltip    = v end
function IAHP(v)    _u.idleautoheal    = v end
function IT(v)    _u.idletime    = v end
function REP(v) _u.repairspeed = v end
function AHP(v)    _u.autoheal    = v end
function CR(v)    _u.crushresistance    = v end
function ICT(v) _u.icontype = v .. "_scav" end
function WT(v) _u.workertime = v end
function MWD(v) _u.minwaterdepth = v end
function B(v) _u.blocking = v end
function BD(v) _u.builddistance = v end
function EM(v) _u.energymake = v end
function RS(v) _u.removestop = v end
function RW(v) _u.removewait = v end
function ON(v) _u.onoffable = v end
function S(v) _u.script = v end
function ES(v) _u.energystorage = v end
function MS(v) _u.metalstorage = v end
function SEID(v) _u.seismicdistance = v end
function RDJ(v) _u.radardistancejam = v end
function SP(v) _u.speed = v end
function ASD(v) _u.airsightdistance = v end
function RD(v) _u.radardistance = v end
function RA(v) _u.radiusadjust = v  end
function UG(v) _u.customparams.unitgroup = v end
function ONAME(v) _u.objectname = v end
function BPIC(v) _u.buildpic = v end
function BUILDER(v) _u.builder = v end
function AS(v) _u.airStrafe = v end
function C(v) _u.collide = v end
function BOPTION(v) _u.buildoptions = v end
function BNOPTION() _u.buildoptions = {} end
function MOVE(v) _u.canmove = v end
function UP(v) _u.upright = v end
function CF(v) _u.canfight = v end
function TR(v) _u.turnrate = v end
function NOASD() _u.customparams.attacksafetydistance = nil end
function EXP(v) _u.explodeas = v end
function SELF(v) _u.selfdestructas = v end
function WATER() 
_u.floater = true
_u.maxwaterdepth = 1000
_u.waterline = 0
end
function SPACE(v)
_u.radardistance = 0
_u.sightdistance = 0
_u.reclaimable = false
_u.repairable = true
_u.sfxtypes.explosiongenerators = {}
_u.canmove = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 8
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = true
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
_u.customparams.armordef = "space"
_u.maxacc = 0.5
_u.maxdec = 0.5
end
function SPACES(v)
_u.customparams.armordef = "space"
_u.radardistance = 0
_u.reclaimable = true
_u.repairable = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 14
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = false
_u.airstrafe = false
_u.turnrate = 0
_u.canmove = false
_u.maxacc = 0.2
_u.canfight = false
_u.canguard = false
_u.canPatrol = false
_u.maxdec = 0
_u.upright = true
_u.speed = 0.1
_u.sonardistance = 0
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
_u.blocking = true
end

SET("armrespawn")
NAME("Epic Construction Turret")
DESC("Enormous Assist & Repair in a short Radius")
BD(200)
SD(500)
EM(50)
B(true)
WT(10000)
REP(5000)
EC(200000)
MC(10000)
BT(200000)
MWD(-1000)
ADD("armnanotc3")

SET("correspawn")
NAME("Epic Construction Turret")
DESC("Enormous Assist & Repair in a short Radius")
BD(200)
SD(500)
EM(50)
B(true)
WT(10000)
REP(5000)
EC(200000)
MC(10000)
BT(200000)
MWD(-1000)
ADD("cornanotc3")

SET("legnanotcbase")
NAME("Epic Construction Turret")
DESC("Enormous Assist & Repair in a short Radius")
BD(200)
SD(500)
EM(50)
B(true)
WT(10000)
REP(5000)
EC(200000)
MC(10000)
BT(200000)
MWD(-1000)
ADD("legnanotc3")

SET("armsat")
SPACE(2100)
NAME("Sky Eye")
DESC("Long-Range Radar Satellite")
MC(200)
EC(10000)
BT(10000)
HP(500)
SP(110)
ASD(1300)
SD(1100)
RD(2300)
ICT("armeyes")
RA(2)
ADD("armosat")

SET("corsfig")
SPACE(2100)
BPIC("ARMSABER.DDS")
ONAME("Units/ARMSABER.s3o")
S("Units/ARMSABER.cob")
MC(130)
EC(3000)
BT(4000)
HP(275)
SP(200)
ASD(700)
NAME("Blaster")
DESC("Orbital Fighter")
UG("weapon")
ICT("armhawk")
RA(2.3)
TR(720)
SD(200)
ADD("armofighter")

SET("armmls")
BNOPTION()
SPACE(2000)
MC(600)
EC(13000)
BT(15000)
HP(600)
SP(60)
BUILDER(true)
WT(200)
BD(200)
ASD(500)
SD(200)
EM(30)
NAME("Advanced Orbital Constructor")
DESC("Tech 2 Constructor")
UG("buildert2")
ICT("armaca")
RA(2.5)
_u.reclaimSpeed = 50
ADD("armoc")

SET("armhawk")
SPACE(2000)
TR(180)
MC(500)
EC(6000)
BT(8000)
HP(500)
SP(70)
SD(350)
ASD(600)
NAME("Peacemaker")
DESC("Orbital Bomber")
_u.nochasecategory = "VTOL"
UG("weapon")
ICT("armbrtha")
RA(2.5)
NOASD()
ADD("armocan")

SET("armaap")
NAME("Space Factory")
DESC("Tech 2 Orbital Units")
BT(24000)
EC(32000)
MC(3300)
WT(400)
ICT("armaap")
HP(4000)
BNOPTION()
WATER()
ADD("armspace")

SET("armemp")
BPIC("scavengers/armemp.DDS")
ASD(1600)
MC(3000) 
EC(60000) 
BT(50000) 
HP(3000) 
SD(600)
NAME("Maestro") 
DESC("Anti-Orbit Missile Launcher") 
UG("weapon")
_u.canrepeat = false
WATER()
ADD("armorocket")

SET("armsubk")
SPACE(2030)
MC(700) EC(20000) BT(25000) HP(2600) SP(90) ASD(1000) SD(300)
NAME("Lion") DESC("Laser Assault Spaceship") UG("weapon")
ICT("armbrawl") RA(2.4)
ADD("armobruiser")

SET("armlship")
SPACE(2060)
AS(false)
UP(true)
MC(900) EC(30000) BT(30000) HP(1500) SP(70) ASD(1600) SD(300)
NAME("Accelerator") DESC("Tachyon Accelerator Spaceship") UG("weapon")
ICT("armanni") RA(2.8)
ADD("armotachyon")

SET("armdronecarry")
SPACE(2000)
MC(8000) EC(80000) BT(90000) HP(20000) SP(70) ASD(1400) SD(500)
NAME("Kaiser") DESC("Orbital Drone Carrier Battleship") UG("weapon")
TECH(3)
ICT("armtrident") RA(2)
AS(false)
UP(true)
RD(1200)
_u.sonardistance = 0
ADD("armokaiser")

SET("armdrone")
SPACE(2000)
MC(25) EC(600) BT(1200) HP(500) SP(200) ASD(800) 
NAME("Kaiser Drone") DESC("Rocket drone capable of attacking aircraft and spaceships.") UG("weapon")
ICT("armdrone")
ADD("armodrone")

SET("armdl")
BPIC("scavengers/armdl.DDS")
SPACES(2000)
ASD(1300) MC(800) EC(9000) BT(20000) HP(3000) SD(300)
NAME("Penguin") DESC("Orbital Laser Defense") UG("weapon") TECH(1)
ICT("armhlt")
WATER()
ADD("armolaser")

SET("armfepocht4")
SPACE(2000)
MC(70000) EC(900000) BT(400000) HP(70000) SP(50) SD(1000) ASD(1500)
UG("weapon")
NAME("Iron Sky") DESC("Experimental Orbital Carpet Artillery")
_u.customparams.paralyzemultiplier = 0
ICT("armvulc")
EXP("fusionExplosion")
SELF("ScavComBossExplo")
ADD("armoliberator")

SET("legaap")
NAME("Space Factory") DESC("Tech 2 Orbital Units") TECH(2)
BT(24000) EC(31000) MC(3300) WT(400)
ICT("legaap") HP(4000)
BNOPTION()
WATER()
ADD("legspace")

SET("armptt2")
BPIC("scavengers/armptt2.DDS")
SPACES(2000)
RD(0)
ASD(1500) MC(1500) EC(20000) BT(33000) HP(4000) SD(600)
NAME("Kraken") DESC("Area Control and Anti-Ground Orbital Defense") UG("weapon")
ICT("armhlt")
RA(2)
ADD("armomulti")

SET("corfdoom")
BPIC("scavengers/corfdoom.DDS")
SPACES(2000)
ASD(1500) MC(1600) EC(21000) BT(36000) HP(4000) SD(600)
NAME("Cardinal") DESC("Area Control and Anti-Ground Orbital Defense") UG("weapon")
ICT("corfdoom")
ADD("coromulti")

SET("leganavaldefturret")
SPACES(2000)
ASD(1500) MC(1500) EC(21000) BT(32000) HP(4000) SD(800)
NAME("Aeon") DESC("Area Control and Anti-Ground Orbital Defense") UG("weapon")
ICT("leganavaldefturret")
ADD("legomulti")

SET("armapt3")
NAME("Experimental Space Factory") DESC("Tech 3 Orbital Units") TECH(3)
BNOPTION()
ICT("armapt3")
WATER()
ADD("armspacet3")

SET("corapt3")
NAME("Experimental Space Factory") DESC("Tech 3 Orbital Units") TECH(3)
BNOPTION()
ICT("corapt3")
WATER()
ADD("corspacet3")

SET("legapt3")
NAME("Experimental Space Factory") DESC("Tech 3 Orbital Units") TECH(3)
BNOPTION()
ICT("legapt3")
WATER()
ADD("legspacet3")

SET("coraap")
TECH(2)
NAME("Space Factory")
DESC("Tech 2 Orbital Units")
BT(24000)
EC(31000)
MC(3300)
WT(400)
ICT("coraap")
HP(4000)
BNOPTION()
WATER()
ADD("corspace")

SET("corsat")
SPACE(2100)
NAME("Observer")
DESC("Long-Range Radar Satellite")
MC(200)
EC(10000)
BT(10000)
HP(500)
SP(110)
ASD(1000)
SD(1100)
RD(2300)
ICT("coreyes")
RA(2)
ADD("corosat")

SET("corsfig")
SPACE(2100)
MC(140)
EC(3000)
BT(4000)
HP(280)
SP(200)
ASD(700)
NAME("Zealot")
DESC("Orbital Fighter")
UG("weapon")
ICT("corvamp")
RA(2.8)
TR(720)
SD(200)
ADD("corofighter")

SET("correcl")
BNOPTION()
SPACE(2000)
_u.canassist = true
_u.canresurrect = false
MC(600)
EC(9000)
BT(15000)
HP(500)
SP(60)
BUILDER(true)
WT(200)
BD(200)
ASD(500)
SD(200)
EM(30)
NAME("Advanced Orbital Constructor")
DESC("Tech 2 Constructor")
UG("buildert2")
ICT("coraca")
TECH(2)
RA(2.5)
_u.reclaimSpeed = 50
ADD("coroc")

SET("corvamp")
SPACE(2000)
TR(180)
MC(550)
EC(6660)
BT(9000)
HP(550)
SP(70)
SD(350)
ASD(500)
NAME("Bombard")
DESC("Orbital Bomber")
UG("weapon")
ICT("corint")
RA(2.5)
NOASD()
ADD("corocan")

SET("corsolar")
ONAME("Units/CORADVSOL.s3o")
BPIC("CORADVSOL.DDS")
S("Units/CORADVSOL.cob")
SPACE(2000)
MC(1950)
EC(21000)
BT(36000)
HP(2000)
SP(10)
ASD(500)
EM(500)
ES(1500)
NAME("Orbital Solar Collector")
DESC("Produces 500 Energy")
_u.customparams.solar = true
UG("energy")
ICT("coradvsol")
RA(2)
ADD("corosolar")

SET("corshark")
SPACE(2030)
MC(650)
EC(22000)
BT(24000)
HP(2200)
SP(85)
ASD(1000)
SD(300)
NAME("Inquisitor")
DESC("Medium Range Missile Assault Spaceship")
UG("weapon")
ICT("corape")
RA(2.4)
ADD("corobruiser")

SET("corssub")
SPACE(2060)
MC(1050)
EC(50000)
BT(40000)
HP(3000)
SP(65)
ASD(1300)
SD(300)
NAME("Punisher")
DESC("Armored Long Range Laser Spaceship")
UG("weapon")
ICT("corcrwh")
_u.stealth = false
ADD("coroheavy")

SET("cormadsam")
BPIC("scavengers/cormadsam.DDS")
SPACES(2000)
ASD(1300)
MC(820)
EC(9500)
BT(20000)
HP(3100)
SD(300)
NAME("Purger")
DESC("Orbital Defense Battery")
TECH(1)
ICT("armhlt")
WATER()
ADD("cororocket")

SET("cormship")
SPACE(2000)
RD(0)
MC(3300)
EC(82000)
BT(82000)
HP(5000)
SP(60)
SD(900)
ASD(1200)
NAME("Shieldbreaker")
DESC("Heavy Duty Orbital Bomber")
UG("weapon")
ICT("armliche")
RA(2)
TR(180)
TECH(3)
_u.customparams.maxrange = nil
ADD("corobomber")

SET("cordemon")
DESC("Anti Orbital Flamethrower Mech")
ADD("cordemon")

SET("armbanth")
DESC("Anti Orbital Assault Mech")
ADD("armbanth")

SET("corkorg")
DESC("Experimental Anti Orbital Assault Bot")
ADD("corkorg")

SET("legeheatraymech")
DESC("Experimental Anti Orbital Dual Heat-Ray/Riot Mech")
ADD("legeheatraymech")

-- Command: tweakdefs1
local _u = {}
function SET(def) _u = table.copy(UnitDefs[def]) end
function ADD(name) UnitDefs[name] = _u end
function CP()    _u.customparams = {} end
function MC(v)    _u.metalcost = v end
function EC(v)    _u.energycost= v end
function BT(v)    _u.buildtime    = v end
function HP(v)    _u.health    = v end
function SD(v)    _u.sightdistance    = v end
function TECH(v) _u.customparams.techlevel  = v end
function NAME(v) _u.customparams.i18n_en_humanname   = v end
function DESC(v) _u.customparams.i18n_en_tooltip    = v end
function IAHP(v)    _u.idleautoheal    = v end
function IT(v)    _u.idletime    = v end
function AHP(v)    _u.autoheal    = v end
function ICT(v) _u.icontype = v .. "_scav" end
function WT(v) _u.workertime = v end
function MWD(v) _u.minwaterdepth = v end
function B(v) _u.blocking = v end
function BD(v) _u.builddistance = v end
function EM(v) _u.energymake = v end
function RS(v) _u.removestop = v end
function RW(v) _u.removewait = v end
function ON(v) _u.onoffable = v end
function S(v) _u.script = v end
function ES(v) _u.energystorage = v end
function MS(v) _u.metalstorage = v end
function SEID(v) _u.seismicdistance = v end
function RDJ(v) _u.radardistancejam = v end
function SP(v) _u.speed = v end
function ASD(v) _u.airsightdistance = v end
function RD(v) _u.radardistance = v end
function RA(v) _u.radiusadjust = v  end
function TR(v) _u.turnrate = v end
function UG(v) _u.customparams.unitgroup = v end
function ONAME(v) _u.objectname = v end
function BPIC(v) _u.buildpic = v end
function BUILDER(v) _u.builder = v end
function AS(v) _u.airStrafe = v end
function C(v) _u.collide = v end
function BOPTION(v) _u.buildoptions = v end
function BNOPTION() _u.buildoptions = {} end
function UP(v) _u.upright = v end
function NOASD() _u.customparams.attacksafetydistance = nil end
function EXP(v) _u.explodeas = v end
function SELF(v) _u.selfdestructas = v end
function WATER() 
_u.floater = true
_u.waterline = 0
_u.maxwaterdepth = 1000
end
function SPACE(v)
_u.customparams.armordef = "space"
_u.maxacc = 0.5
_u.maxdec = 0.5
_u.radardistance = 0
_u.sightdistance = 0
_u.reclaimable = false
_u.repairable = true
_u.sfxtypes.explosiongenerators = {}
_u.canmove = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 8
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = true
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
end
function SPACES(v)
_u.customparams.armordef = "space"
_u.radardistance = 0
_u.reclaimable = true
_u.repairable = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 14
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = false
_u.airstrafe = false
_u.turnrate = 0
_u.canmove = false
_u.maxacc = 0.2
_u.canfight = false
_u.canguard = false
_u.canPatrol = false
_u.maxdec = 0
_u.upright = true
_u.speed = 0.1
_u.sonardistance = 0
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
_u.blocking = true
end

SET("armsat")
SPACE(2100)
BPIC("legwhisper.DDS")
ONAME("Units/legwhisper.s3o")
S("Units/legwhisper.cob")
MC(200)
EC(10000)
BT(10000)
HP(500)
SP(70)
ASD(1500)
SD(1100)
RA(2)
RD(2300)
ICT("legeyes")
NAME("Lumen")
DESC("Long-Range Radar Satellite")
ADD("legosat")

SET("legnavyrezsub")
SPACE(2000)
_u.canassist = true
_u.canresurrect = false
MC(600)
EC(9000)
BT(15000)
HP(500)
SP(60)
BUILDER(true)
WT(200)
BD(200)
ASD(500)
SD(200)
EM(30)
NAME("Advanced Orbital Constructor")
DESC("Tech 2 Constructor")
UG("buildert2")
ICT("legaca")
RA(2.5)
_u.reclaimSpeed = 50
ADD("legoc")

SET("corsfig")
ONAME("Units/legionnaire.s3o")
BPIC("legionnaire.DDS")
S("Units/legionnaire.cob")
SPACE(2100)
MC(127.5)
EC(2600)
BT(4000)
HP(265)
SP(215)
ASD(700)
NAME("Lykion")
DESC("Orbital Fighter")
UG("weapon")
ICT("legionnaire")
RA(2.8)
TR(720)
SD(200)
ADD("legofighter")

SET("legafigdef")
SPACE(2000)
MC(500)
EC(6000)
BT(8000)
HP(500)
SP(70)
SD(400)
ASD(500)
NAME("Zeus")
DESC("Orbital Lightning Bomber")
UG("weapon")
ICT("leglrpc")
RA(2.5)
NOASD()
ADD("legocan")

SET("legsolar")
SPACE(2000)
MC(2000)
EC(20000)
BT(36000)
HP(2000)
SP(10)
ASD(500)
EM(480)
ES(1500)
NAME("Orbital Solar Collector")
DESC("Produces 500 Energy")
UG("energy")
ICT("legadvsol")
RA(2)
ADD("legosolar")

SET("legnavyscout")
SPACE(2030)
MC(720)
EC(19000)
BT(26000)
HP(2900)
SP(100)
ASD(900)
SD(300)
NAME("Thaleon")
DESC("Gatling Gun Assault Spaceship")
UG("weapon")
ICT("legvelite")
RA(2.4)
ADD("legobruiser")

SET("legnavyfrigate")
SPACE(2060)
MC(900)
EC(31000)
BT(33000)
HP(1100)
SP(70)
ASD(1400)
SD(300)
NAME("Trikeos")
DESC("Seeker Missile Orbital Striker")
UG("weapon")
ICT("legacluster")
RA(2)
ADD("legotrigun")

SET("legerailtank")
SPACE(2000)
MC(1000)
EC(30000)
BT(30000)
HP(2000)
SP(70)
ASD(2000)
SD(1000)
NAME("Propheteus")
DESC("Orbital Camera Deployer")
UG("weapon")
ICT("spy")
RA(2.5)
ADD("legospy")

SET("legeyes")
NAME("Argus")
DESC("Orbital Deployed Camera with increased uncloaking range.")
_u.movementclass = "HOVER2"
_u.mincloakdistance = 50
 _u.icontype = "legeyes"
ADD("legoeyes")

SET("legosat")
SPACE(1850)
BPIC("ARMSPID.DDS")
ONAME("dbg_sphere_fullmetal.s3o")
S("Units/ARMSILO.cob")
MC(110000)
EC(1500000)
BT(1100000)
HP(100000)
SP(50)
SD(1500)
ASD(1500)
NAME("Phaethon")
DESC("Celestial Earth Scorcher")
UG("weapon")
ICT("defence_hllllt")
RA(3)
TR(160)
TECH(3)
UP(true)
AS(false)
SELF("ScavComBossExplo")
EXP("korgExplosion")
_u.collisionvolumetype = "sphere"
ADD("legohelios")

SET("leglraa")
ASD(1600)
MC(3100)
EC(60000)
BT(50000)
HP(3000)
SD(600)
NAME("Nostradamos")
DESC("Anti-Orbit Railgun Defense")
UG("weapon")
ICT("leglraa")
WATER()
ADD("legocannon")

SET("leglupara")
SPACES(2000)
ASD(1200)
MC(780)
EC(10000)
BT(21000)
HP(3000)
SD(300)
NAME("Pompeii")
DESC("Orbital Beam Laser Defense")
WATER()
ADD("legolaser")

UnitDefs["armoc"].buildoptions = {
[1]  = "armafus",
[2] = "armageo",
[3] = "armckfus",
[4]= "armfus",
[5] = "armuwageo",
[6] = "armgmm",
[7] = "armmoho",
[8] = "armmmkr",
[9] = "armuwadves",
[10] = "armuwadvms",
[11] = "armarad",
[12] = "armveil",
[13] = "armfort",
[14] = "armasp",
[15] = "armfasp",
[16] = "armtarg",
[17] = "armsd",
[18] = "armgate",
[19] = "armamb",
[20] = "armpb",
[21] = "armanni",
[22] = "armflak",
[23] = "armmercury",
[24] = "armemp",
[25] = "armamd",
[26] = "armsilo",
[27] = "armbrtha",
[28] = "armvulc",
[29] = "armdf",
[30] = "armshltx",
[31] = "armap",
[32] = "armspace",
[33] = "armap",
[34] = "armuwmme",
}
UnitDefs["coroc"].buildoptions = {
			[1] = "corfus",
			[2] = "corafus",
			[3] = "corageo",
			[4] = "coruwageo",
			[5] = "corbhmth",
			[6] = "cormoho",
			[7] = "cormexp",
			[8] = "cormmkr",
			[9] = "coruwadves",
			[10] = "coruwadvms",
			[11] = "corarad",
			[12] = "corshroud",
			[13] = "corfort",
			[14] = "corasp",
			[15] = "corfasp",
			[16] = "cortarg",
			[17] = "corsd",
			[18] = "corgate",
			[19] = "cortoast",
			[20] = "corvipe",
			[21] = "cordoom",
			[22] = "corflak",
			[23] = "corscreamer",
			[24] = "cortron",
			[25] = "corfmd",
			[26] = "corsilo",
			[27] = "corint",
			[28] = "corbuzz",
			[29] = "corplat",
			[30] = "corgant",
			[31] = "corspace",
			[32] = "corap",
			[33] = "coruwmme",
}
UnitDefs["legoc"].buildoptions = {
		"legfus",
			"legafus",
			"legageo",
			"leganavalmex",
			"legrampart",
			"legmoho",
			"cormexp",
			"legadveconv",
			"legadvestore",
			"legamstor",
			"legarad",
			"legajam",
			"legforti",
			"corasp",
			"corfasp",
			"legtarg",
			"legsd",
			"legdeflector",
			"legacluster",
			"legapopupdef",
			"legbastion",
			"legflak",
			"leglraa",
			"legperdition",
			"legabm",
			"legsilo",
			"leglrpc",
			"legstarfall",
			"leggant",
			"legspace",
			"legap",
			"coruwmme",
}
local modoptions = Spring.GetModOptions()
for name, ud in pairs(UnitDefs) do
  local cp = ud.customparams
    if ud.buildoptions and name == "armaca" or name == "armack" or name == "armacsub" or name == "armacv" or name == "armoc" or name == "armcsa" then
      table.insert(ud.buildoptions, "armageot3")
      table.insert(ud.buildoptions, "armnanotc3")
      table.insert(ud.buildoptions, "armfirewall")
      table.insert(ud.buildoptions, "armorocket")
      table.insert(ud.buildoptions, "armomulti")
      table.insert(ud.buildoptions, "armspacet3")
    elseif name == "coraca" or name == "corack" or name == "coracsub" or name == "coracv" or name == "coroc" or name == "corcsa" then
      table.insert(ud.buildoptions, "corageot3")
      table.insert(ud.buildoptions, "cornanotc3")
      table.insert(ud.buildoptions, "cortyrant")
      table.insert(ud.buildoptions, "corocannon")
      table.insert(ud.buildoptions, "coromulti")
      table.insert(ud.buildoptions, "corspacet3")
    elseif name == "legaca" or name == "legack" or name == "legacv" or name == "legoc" or name == "legspcon" then
      table.insert(ud.buildoptions, "legnanotc3")
      table.insert(ud.buildoptions, "legparagon")
      table.insert(ud.buildoptions, "legocannon")
      table.insert(ud.buildoptions, "legomulti")
      table.insert(ud.buildoptions, "legspacet3")
    end
   if ud.buildoptions and not cp.iscommander and not cp.techlevel and tonumber(ud.maxacc) > 0 then
    if name:find("^arm") then
      table.insert(ud.buildoptions, "armspace")
      table.insert(ud.buildoptions, "armolaser")
      table.insert(ud.buildoptions, "armollt")
    elseif name:find("^cor") then
      table.insert(ud.buildoptions, "corspace")
      table.insert(ud.buildoptions, "cororocket")
      table.insert(ud.buildoptions, "corollt")
    elseif name:find("^leg") then
      table.insert(ud.buildoptions, "legspace")
      table.insert(ud.buildoptions, "legolaser")
      table.insert(ud.buildoptions, "legollt")
    end
  end
if  modoptions.scavunitsforplayers then
if ud.buildoptions then
if name == "armoc" then
		      table.insert(ud.buildoptions, "armapt3")
		      table.insert(ud.buildoptions, "armminivulc")
		      table.insert(ud.buildoptions, "legmbotrail")
		      table.insert(ud.buildoptions, "armannit3")
		      table.insert(ud.buildoptions, "armafust3")
		      table.insert(ud.buildoptions, "armmmkrt3")
elseif name == "coroc" then
		      table.insert(ud.buildoptions, "corapt3")
		      table.insert(ud.buildoptions, "corminibuzz")
		      table.insert(ud.buildoptions, "corhllllt")
		      table.insert(ud.buildoptions, "cordoomt3")
		      table.insert(ud.buildoptions, "corafust3")
		      table.insert(ud.buildoptions, "cormmkrt3")
elseif name == "legoc" then
		      table.insert(ud.buildoptions, "legapt3")
		      table.insert(ud.buildoptions, "legministarfall")
		      table.insert(ud.buildoptions, "legafust3")
		      table.insert(ud.buildoptions, "legadveconvt3")
		end
end
end
if modoptions.experimentalextraunits then
if ud.buildoptions then
		if name == "coroc" then
		      table.insert(ud.buildoptions, "corwint2")
		      table.insert(ud.buildoptions, "cornanotct2")
		      table.insert(ud.buildoptions, "cormwall")
 		      table.insert(ud.buildoptions, "corgatet3")
		      table.insert(ud.buildoptions, "corfgate")
		      table.insert(ud.buildoptions, "cornanotc2plat")
		 elseif name == "armoc" then
		      table.insert(ud.buildoptions, "armshockwave")
		      table.insert(ud.buildoptions, "armwint2")
		      table.insert(ud.buildoptions, "armnanotct2")
		      table.insert(ud.buildoptions, "armlwall")
		      table.insert(ud.buildoptions, "armgatet3")
		      table.insert(ud.buildoptions, "armfgate")
		      table.insert(ud.buildoptions, "armnanotc2plat")
		elseif name == "legoc" then
		      table.insert(ud.buildoptions, "legmohocon")
		      table.insert(ud.buildoptions, "legwint2")
		      table.insert(ud.buildoptions, "legnanotct2")
		      table.insert(ud.buildoptions, "legrwall")
		      table.insert(ud.buildoptions, "leggatet3")
		end
end
end
end

-- Command: tweakdefs2
local _u = {}
function SET(def) _u = table.copy(UnitDefs[def]) end
function ADD(name) UnitDefs[name] = _u end
function CP()    _u.customparams = {} end
function MC(v)    _u.metalcost = v end
function EC(v)    _u.energycost= v end
function BT(v)    _u.buildtime    = v end
function HP(v)    _u.health    = v end
function SD(v)    _u.sightdistance    = v end
function TECH(v) _u.customparams.techlevel  = v end
function NAME(v) _u.customparams.i18n_en_humanname   = v end
function DESC(v) _u.customparams.i18n_en_tooltip    = v end
function IAHP(v)    _u.idleautoheal    = v end
function IT(v)    _u.idletime    = v end
function AHP(v)    _u.autoheal    = v end
function ICT(v) _u.icontype = v .. "_scav" end
function WT(v) _u.workertime = v end
function MWD(v) _u.minwaterdepth = v end
function B(v) _u.blocking = v end
function BD(v) _u.builddistance = v end
function EM(v) _u.energymake = v end
function RS(v) _u.removestop = v end
function RW(v) _u.removewait = v end
function ON(v) _u.onoffable = v end
function S(v) _u.script = v end
function ES(v) _u.energystorage = v end
function MS(v) _u.metalstorage = v end
function SEID(v) _u.seismicdistance = v end
function RDJ(v) _u.radardistancejam = v end
function SP(v) _u.speed = v end
function ASD(v) _u.airsightdistance = v end
function RD(v) _u.radardistance = v end
function RA(v) _u.radiusadjust = v  end
function TR(v) _u.turnrate = v end
function UG(v) _u.customparams.unitgroup = v end
function ONAME(v) _u.objectname = v end
function BPIC(v) _u.buildpic = v end
function AS(v) _u.airStrafe = v end
function BOPTION(v) _u.buildoptions = v end
function BNOPTION() _u.buildoptions = {} end
function EXP(v) _u.explodeas = v end
function SELF(v) _u.selfdestructas = v end
function UP(v) _u.upright = v end
function WATER() 
_u.floater = true
_u.waterline = 0
_u.maxwaterdepth = 1000
end
function SPACE(v)
_u.customparams.armordef = "space"
_u.maxacc = 0.5
_u.maxdec = 0.5
_u.radardistance = 0
_u.sightdistance = 0
_u.reclaimable = false
_u.repairable = true
_u.sfxtypes.explosiongenerators = {}
_u.canmove = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 8
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = true
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
end
function SPACES(v)
_u.customparams.armordef = "space"
_u.radardistance = 0
_u.reclaimable = true
_u.repairable = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 14
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = false
_u.airstrafe = false
_u.turnrate = 0
_u.canmove = false
_u.maxacc = 0.2
_u.canfight = false
_u.canguard = false
_u.canPatrol = false
_u.maxdec = 0
_u.upright = true
_u.speed = 0.1
_u.sonardistance = 0
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
_u.blocking = true
end

SET("coresuppt3")
SPACE(2000)
MC(14000)
EC(100000)
BT(160000)
HP(36000)
SP(65)
ASD(1600)
NAME("Maginot")
DESC("Heavy Heatray Battleship")
TECH(3)
ICT("coresuppt3")
AS(false)
UP(true)
ADD("coroheatray")

SET("legfortt4")
SPACE(2000)
MC(10000)
EC(130000)
BT(120000)
HP(30000)
SP(70)
ASD(1400)
NAME("Longinus")
DESC("Heavy Anti-Swarm Battleship")
TECH(3)
ICT("legfort")
AS(false)
UP(true)
SELF("largeExplosionGenericSelfd")
EXP("largeexplosiongeneric")
ADD("legofort")

SET("legstronghold")
SPACE(2000)
MC(3600)
EC(70000)
BT(85000)
HP(5000)
SP(60)
SD(1050)
ASD(1300)
NAME("Athena")
DESC("Cluster Plasma Orbital Bomber")
UG("weapon")
ICT("armliche")
RA(2)
TECH(3)
_u.transportcapacity = nil
_u.transportsize = nil
ADD("legobomber")

SET("corprince")
SPACE(2000)
MC(90000)
EC(900000)
BT(820000)
HP(80000)
SP(50)
SD(1200)
ASD(1600)
NAME("Apocalypse")
DESC("Meteor Rain Artillery")
TECH(3)
UG("weapon")
ICT("corbuzz")
_u.firestate = 0
TR(180)
UP(true)
AS(false)
SELF("ScavComBossExplo")
EXP("fusionExplosion")
TECH(3)
ADD("coroapoc")

SET("armsolar")
SPACE(2000)
TR(180)
MC(2000)
EC(21000)
BT(36000)
HP(2000)
SP(10)
ASD(500)
EM(480)
ES(1500)
NAME("Orbital Solar Collector")
DESC("Produces 500 Energy")
UG("energy")
ICT("coradvsol")
RA(2)
ADD("armosolar")

SET("armserpt3")
SPACE(2000)
MC(2900)
EC(72000)
BT(74000)
HP(5000)
SP(60)
SD(900)
ASD(1200)
NAME("Porcupine")
DESC("Orbital Tumbleweed Cannon")
UG("weapon")
ICT("armvader")
RA(2)
_u.inheritxpratemultiplier = 1
_u.childreninheritxp = "BOTCANNON"
_u.parentsinheritxp = "BOTCANNON"
_u.stealth = false
_u.sonardistance = 0
TECH(3)
ADD("armobomber")

SET("corhurc")
SPACE(2100)
MC(1000)
EC(20000)
BT(20000)
HP(1300)
SP(200)
SD(400)
ASD(1100)
NAME("Hunter")
DESC("Heavy Fighter")
UG("weapon")
ICT("corcrwh")
RA(2)
TR(720)
TECH(3)
ADD("corohunter")

SET("armseadragon")
SPACE(2000)
MC(3500)
EC(60000)
BT(70000)
HP(3000)
SP(80)
SD(1000)
RD(2300)
ASD(1300)
NAME("Porter")
DESC("Orbital Radar and Vanguard Deployment Spaceship. (55 m/s and 1.1k e/s)")
UG("weapon")
ICT("armseadragon")
RA(2)
TR(180)
_u.sonardistance = 0
RW(false)
TECH(3)
ADD("armohorizon")

SET("armseap")
SPACE(1970)
MC(200)
EC(4000)
BT(5000)
HP(300)
SP(200)
SD(200)
ASD(900)
NAME("Aspirant")
DESC("Low Orbit Fighter")
UG("weapon")
ICT("armseap")
RA(2)
TR(720)
TECH(2)
ADD("armoplane")

SET("corveng")
SPACE(1970)
MC(200)
EC(4000)
BT(5000)
HP(300)
SP(200)
SD(200)
ASD(800)
NAME("Locust")
DESC("Low Orbit Fighter")
UG("weapon")
ICT("corseap")
RA(2)
TR(720)
TECH(2)
ADD("coroplane")

SET("corcut")
SPACE(1970)
MC(200)
EC(4000)
BT(5000)
HP(300)
SP(205)
SD(200)
ASD(800)
NAME("Koluma")
DESC("Low Orbit Fighter")
UG("weapon")
ICT("corcut")
RA(2)
TR(720)
TECH(2)
ADD("legoplane")

SET("corjuno")
BPIC("scavengers/corjuno.DDS")
ASD(1750)
MC(3300)
EC(60000)
BT(50000)
HP(3666)
SD(600)
NAME("Decimator")
DESC("Anti-Orbital Unstable Plasma Defense")
UG("weapon")
_u.stealthy = false
WATER()
ADD("corocannon")

UnitDefs["armaap"].buildoptions[11] = "armoplane"
UnitDefs["coraap"].buildoptions[9] = "coroplane"
UnitDefs["legaap"].buildoptions[10] = "legoplane"

SET("armbanth")
_u.weapondefs.bantha_rocket.customparams.overrange_distance = nil
_u.weapondefs.bantha_rocket.collidefeature = false
_u.weapondefs.bantha_rocket.damage.space = 2100
_u.weapondefs.tehlazerofdewm.cylindertargeting = 50
_u.weapondefs.tehlazerofdewm.heightmod = 0.1
_u.weapondefs.tehlazerofdewm.minintensity = 0.5
_u.weapons[2].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[3].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
ADD("armbanth")

SET("corkorg")
_u.weapondefs.corkorg_rocket.customparams.overrange_distance = nil
_u.weapondefs.corkorg_rocket.collidefeature = false
_u.weapondefs.corkorg_rocket.damage.space = 2400
_u.weapondefs.corkorg_laser.cylindertargeting = 50
_u.weapondefs.corkorg_laser.heightmod = 0.1
_u.weapondefs.corkorg_laser.minintensity = 0.5
_u.weapons[2].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[3].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
ADD("corkorg")

SET("legeheatraymech")
_u.weapons[1].onlytargetcategory = "SURFACE SPACENOTOBJECT"
_u.weapons[1].badtargetcategory = "SPACENOTOBJECT VTOL GROUNDSCOUT"
_u.weapons[2].onlytargetcategory = "SURFACE SPACENOTOBJECT"
_u.weapons[2].badtargetcategory = "SPACENOTOBJECT VTOL GROUNDSCOUT"
_u.weapons[3].onlytargetcategory = "SURFACE SPACENOTOBJECT"
_u.weapons[3].badtargetcategory = "SPACENOTOBJECT VTOL GROUNDSCOUT"
_u.weapondefs.heatray1.cylindertargeting = 100
_u.weapondefs.heatray1.minintensity = 0.5
_u.weapondefs.heatray1.damage.space = 25
ADD("legeheatraymech")

SET("corblackhy")
_u.weapondefs.ferret_missile.collidefeature = false
_u.weapondefs.ferret_missile.damage.space = 450
_u.weapondefs.ferret_missile.flighttime = 5
_u.weapondefs.ferret_missile.burnblow = false
_u.weapondefs.ferret_missile.range = 1050
_u.weapons[3].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[6].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("corblackhy")

SET("armepoch")
_u.weapondefs.ferret_missile.collidefeature = false
_u.weapondefs.ferret_missile.damage.space = 450
_u.weapondefs.ferret_missile.flighttime = 5
_u.weapondefs.ferret_missile.burnblow = false
_u.weapondefs.ferret_missile.range = 1050
_u.weapons[6].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[7].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("armepoch")

SET("corfblackhyt4")
_u.weapondefs.ferret_missile.collidefeature = false
_u.weapondefs.ferret_missile.damage.space = 1200
_u.weapondefs.ferret_missile.flighttime = 5
_u.weapondefs.ferret_missile.burnblow = false
_u.weapondefs.ferret_missile.range = 1050
_u.weapons[3].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[6].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("corfblackhyt4")

SET("armfepocht4")
_u.weapondefs.ferret_missile.collidefeature = false
_u.weapondefs.ferret_missile.damage.space = 1200
_u.weapondefs.ferret_missile.flighttime = 5
_u.weapondefs.ferret_missile.burnblow = false
_u.weapondefs.ferret_missile.range = 1050
_u.weapons[6].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[7].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("armfepocht4")

SET("legfortt4")
_u.weapondefs.aa_missiles.collidefeature = false
_u.weapondefs.aa_missiles.damage.space = 440
_u.weapondefs.aa_missiles.burnblow = false
_u.weapons[6].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.category = "T4AIR ALL WEAPON VTOL NOTSUB NOTHOVER",
ADD("legfortt4")

SET("legerailtank")
DESC("Experimental Anti-Orbital Rail Accelerator Tank")
_u.weapons[1].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[2].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[3].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
ADD("legerailtank")

SET("cordemon")
DESC("Flamethrower Mech with Anti-Orbital Missiles")
_u.weapons[2].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapondefs.karg_shoulder.damage.space = 360
_u.weapondefs.karg_shoulder.flighttime = 5
_u.weapondefs.karg_shoulder.collidefeature = false
ADD("cordemon")

SET("armraz")
DESC("Anti Orbital Battle Mech")
_u.weapondefs.mech_rapidlaser.minintensity = 0.3
_u.weapondefs.mech_rapidlaser.accuracy = 0
_u.weapondefs.mech_rapidlaser.heightmod = 0.1
_u.weapondefs.mech_rapidlaser.cylindertargeting = 100
_u.weapons[1].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[1].burstcontrolwhenoutofarc = nil
ADD("armraz")

SET("legdrone")
SD(200)
SPACE(2100)
MC(20)
EC(1000)
HP(300)
_u.weapondefs.semiauto.range = 390
_u.weapondefs.semiauto.sprayangle = 0
_u.weapondefs.semiauto.damage.space = 24
_u.weapondefs.semiauto.weaponvelocity = 1200
_u.weapons[1].maxangledif = 360
_u.weapons[1].onlytargetcategory = "SPACENOTOBJECT"
ADD("legodrone")

SET("legvcarry")
ASD(800)
MC(500)
EC(12000)
BT(17000)
HP(2500)
NAME("Carrier")
_u.customparams.ignore_noair = true
DESC("Mobile Orbital Drone Vehicle (Drones cost 20m 1000E each)")
_u.weapondefs.targeting.customparams.carried_unit = "legodrone"
_u.weapons[1].onlytargetcategory = "SPACENOTOBJECT"
ADD("legov")
SET("legov")
ADD("armov")
SET("legov")
ADD("corov")

table.insert(UnitDefs["legavp"].buildoptions, "legov")
table.insert(UnitDefs["armavp"].buildoptions, "armov")
table.insert(UnitDefs["coravp"].buildoptions, "corov")

table.insert(UnitDefs["legafcv"].buildoptions, "legollt")
table.insert(UnitDefs["legaceb"].buildoptions, "legocannon")
table.insert(UnitDefs["legaceb"].buildoptions, "legomulti")
table.insert(UnitDefs["armconsul"].buildoptions, "armorocket")
table.insert(UnitDefs["armconsul"].buildoptions, "armomulti")
table.insert(UnitDefs["armmls"].buildoptions, "armorocket")
table.insert(UnitDefs["armmls"].buildoptions, "armomulti")
table.insert(UnitDefs["corfast"].buildoptions, "corocannon")
table.insert(UnitDefs["corfast"].buildoptions, "coromulti")
table.insert(UnitDefs["cormls"].buildoptions, "corocannon")
table.insert(UnitDefs["cormls"].buildoptions, "coromulti")

-- Command: tweakdefs3
local _u = {}
function SET(def) _u = table.copy(UnitDefs[def]) end
function ADD(name) UnitDefs[name] = _u end
function CP()    _u.customparams = {} end
function MC(v)    _u.metalcost = v end
function EC(v)    _u.energycost= v end
function BT(v)    _u.buildtime    = v end
function HP(v)    _u.health    = v end
function SD(v)    _u.sightdistance    = v end
function TECH(v) _u.customparams.techlevel  = v end
function NAME(v) _u.customparams.i18n_en_humanname   = v end
function DESC(v) _u.customparams.i18n_en_tooltip    = v end
function IAHP(v)    _u.idleautoheal    = v end
function IT(v)    _u.idletime    = v end
function AHP(v)    _u.autoheal    = v end
function ICT(v) _u.icontype = v .. "_scav" end
function WT(v) _u.workertime = v end
function MWD(v) _u.minwaterdepth = v end
function B(v) _u.blocking = v end
function BD(v) _u.builddistance = v end
function EM(v) _u.energymake = v end
function RS(v) _u.removestop = v end
function RW(v) _u.removewait = v end
function ON(v) _u.onoffable = v end
function S(v) _u.script = v end
function ES(v) _u.energystorage = v end
function MS(v) _u.metalstorage = v end
function SEID(v) _u.seismicdistance = v end
function RDJ(v) _u.radardistancejam = v end
function SP(v) _u.speed = v end
function ASD(v) _u.airsightdistance = v end
function RD(v) _u.radardistance = v end
function RA(v) _u.radiusadjust = v  end
function TR(v) _u.turnrate = v end
function UG(v) _u.customparams.unitgroup = v end
function ONAME(v) _u.objectname = v end
function BPIC(v) _u.buildpic = v end
function AS(v) _u.airStrafe = v end
function BOPTION(v) _u.buildoptions = v end
function BNOPTION() _u.buildoptions = {} end
function EXP(v) _u.explodeas = v end
function SELF(v) _u.selfdestructas = v end
function UP(v) _u.upright = v end
function WATER() 
_u.floater = true
_u.waterline = 0
_u.maxwaterdepth = 1000
end
function SPACE(v)
_u.customparams.armordef = "space"
_u.maxacc = 0.22
_u.maxdec = 0.5
_u.radardistance = 0
_u.sightdistance = 0
_u.reclaimable = false
_u.repairable = true
_u.sfxtypes.explosiongenerators = {}
_u.canmove = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 8
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = true
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
end
function SPACES(v)
_u.customparams.armordef = "space"
_u.radardistance = 0
_u.reclaimable = true
_u.repairable = true
_u.canfly = true
_u.cruisealtitude = v
_u.hoverattack = true
_u.airhoverfactor = 0
_u.verticalspeed = 14
_u.category = "SPACENOTOBJECT"
_u.useSmoothMesh = true
_u.turninplace = false
_u.airstrafe = false
_u.turnrate = 0
_u.canmove = false
_u.maxacc = 0.2
_u.canfight = false
_u.canguard = false
_u.canPatrol = false
_u.maxdec = 0
_u.upright = true
_u.speed = 0.1
_u.sonardistance = 0
_u.customparams.enabled_on_no_sea_maps = true
_u.customparams.ignore_noair = true
_u.blocking = true
end


SET("armllt")
BPIC("scavengers/armllt.DDS")
SPACES(2000)
MC(160)
EC(900)
BT(4000)
HP(350)
SD(400)
ASD(1000)
NAME("Orbital Sentry")
DESC("Orbital Light Laser Defense")
WATER()
ADD("armollt")

SET("corllt")
BPIC("scavengers/corllt.DDS")
SPACES(2000)
MC(160)
EC(900)
BT(4000)
HP(350)
SD(400)
ASD(1000)
NAME("Orbital Guard")
DESC("Orbital Light Laser Defense")
WATER()
ADD("corollt")

SET("leglht")
SPACES(2000)
MC(160)
EC(900)
BT(4000)
HP(350)
SD(400)
ASD(1000)
NAME("Orbital Pharos")
DESC("Orbital Light Laser Defense")
WATER()
ADD("legollt")

SET("cordrone")
SD(250)
ASD(800)
SPACE(2100)
MC(20)
HP(400)
EC(1000)
_u.weapondefs.heat_ray.range = 390
_u.weapondefs.heat_ray.heightmod = 0.1
_u.weapondefs.heat_ray.cylindertargeting = 50
_u.weapondefs.heat_ray.minIntensity = 0.5
_u.weapondefs.heat_ray.damage.space = 67.5
_u.weapondefs.heat_ray.targetmoveerror = 0
_u.weapons[1].maxangledif = 360
_u.weapons[1].onlytargetcategory = "SPACENOTOBJECT"
ADD("corodrone")

SET("armdrone")
SD(250)
ASD(800)
SPACE(2100)
MC(20)
HP(250)
EC(1000)
_u.weapondefs.med_emg.range = 390
_u.weapondefs.med_emg.accuracy = 0
_u.weapondefs.med_emg.sprayangle = 0
_u.weapondefs.med_emg.damage.space = 21.6
_u.weapondefs.med_emg.turret = true
_u.weapons[1].maxangledif = 360
_u.weapons[1].onlytargetcategory = "SPACENOTOBJECT"
ADD("armantiodrone")

SET("cordronecarry")
DESC("Anti Orbital Drone Carrier")
ASD(1100)
_u.customparams.ignore_noair = true
_u.weapondefs.plasma.customparams.carried_unit = "corodrone"
_u.weapons[1].def = "AAMISSILE"
_u.weapons[1].onlytargetcategory = "VTOL"
_u.weapons[2].def = "PLASMA"
_u.weapons[2].onlytargetcategory = "SPACENOTOBJECT"
ADD("cordronecarry")

SET("armdronecarry")
ASD(1100)
DESC("Anti Orbital Drone Carrier")
_u.customparams.ignore_noair = true
_u.weapondefs.plasma.customparams.carried_unit = "armantiodrone"
_u.weapons[1].def = "AAMISSILE"
_u.weapons[1].onlytargetcategory = "VTOL"
_u.weapons[2].def = "PLASMA"
_u.weapons[2].onlytargetcategory = "SPACENOTOBJECT"
ADD("armdronecarry")

SET("armlichet4")
_u.weapondefs.nuclear_missile.tracks = true
_u.weapondefs.nuclear_missile.collideenemy = true
_u.weapondefs.nuclear_missile.turnrate = 20000
_u.weapondefs.nuclear_missile.weapontype = "MissileLauncher"
_u.weapons[1].badtargetcategory = "SPACENOTOBJECT"
_u.weapons[1].onlytargetcategory = "SURFACE SPACENOTOBJECT"
ADD("armlichet4")

SET("corcrwt4")
_u.weapondefs.edragon_missile.burnblow = false
_u.weapondefs.edragon_missile.damage.space = 450
_u.weapons[2].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("corcrwt4")

SET("leganavyflagship")
DESC("Anti Orbital Naval Combat Flagship")
_u.weapons[4].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[4].burstControlWhenOutOfArc = "nil"
_u.weapons[5].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[5].burstControlWhenOutOfArc = "nil"
_u.weapons[6].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[6].burstControlWhenOutOfArc = "nil"
_u.weapons[7].onlytargetcategory = "NOTSUB SPACENOTOBJECT"
_u.weapons[7].burstControlWhenOutOfArc = "nil"
_u.weapondefs.leg_experimental_railgun.damage.space = 750
_u.weapondefs.leg_experimental_railgun.weaponvelocity = 4000
ADD("leganavyflagship")

table.insert(UnitDefs["armasy"].buildoptions, "armdronecarry")
table.insert(UnitDefs["corasy"].buildoptions, "cordronecarry")
table.insert(UnitDefs["corcom"].buildoptions, "corollt")
table.insert(UnitDefs["armcom"].buildoptions, "armollt")
table.insert(UnitDefs["legcom"].buildoptions, "legollt")

-- Command: tweakunits
{
armspace ={
buildoptions = {
"armoc",
"armosat",
"armofighter",
"armocan",
"armosolar",
"armobruiser",
"armotachyon",
},
},
armspacet3 = {
buildoptions = {
"armoc",
"armobomber",
"armohorizon",
"armokaiser",
"armoliberator",
},
},
armofighter = {
weapondefs = {
			lightlaser = {
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				areaofeffect = 12,
				avoidfeature = false,
				avoidfriendly = false,
				beamtime = 0.12,
				corethickness = 0.175,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-small-red",
				firestarter = 30,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 7,
				name = "Light orbital laser",
				noselfdamage = true,
				range = 400,
				reloadtime = 0.8,
				rgbcolor = "0.05 0.05 1",
				soundhit = "xplosml3",
				soundhitwet = "sizzle",
				soundstart = "Lasrhvy2",
				proximitypriority = 1,
				soundtrigger = 1,
				thickness = 2,
				tolerance = 50000,
				turret = false,
				weapontype = "BeamLaser",
				weaponvelocity = 2250,
				minIntensity = 1,
				cylindertargeting = 220,
				damage = {
					default = 17.5,
				},
			},
		},
		weapons = {
			[1] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
[2] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
armocan = {
weapondefs = {
			Orbital_Cannon = {
				areaofeffect = 300,
				avoidfeature = false,
				avoidfriendly = false,      
				craterareaofeffect = 0,
				collidefriendly = false,
				collidefeature = false,
				canattackground = true,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:genericshellexplosion-medium",
				firestarter = 10,
				impulsefactor = 1,
				name = "Orbital Bombardment",
				tolerance = 65000,
				noselfdamage = true,
				range = 100,
				reloadtime = 10,
				soundhit = "xplomed2",
				soundhitwet = "splshbig",
				soundstart = "KroGun1",
				turret = true,
				weapontimer = 1,
				weapontype = "Cannon",
				weaponvelocity = 500,
				damage = {
					default = 500,
					commanders = 166.6,
					shields = 100,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_CANNON",
				maindir = "0 -1 0",
				onlytargetcategory = "SURFACE",
			},
		},
},
armorocket = {
weapondefs = {
			orbital_rocket = {
				areaofeffect = 250,
				alwaysvisible = true,
				canattackground = false,
				collideenemy = true,
				cegtag = "cruisemissiletrail-tacnuke",
				cylindertargeting = 1,
				energypershot = 0,
				explosiongenerator = "custom:newnuketac",
				firestarter = 10,
				impulsefactor = 1.1,
				name = "Orbital Rocket System",
				range = 1350,
				reloadtime = 7.5,
				model = "cortronmissile.s3o",
				stockpile = false,
				soundhit = "xplomed4",
				soundstart = "mismed1",
				smokecolor = 0.7,
				smokeperiod = 9,
				smokesize = 4,
				startvelocity = 200,
				tracks = true,
				tolerance = 40000,
				turnrate = 40000,
				weaponacceleration = 1000,
				weapontimer = 1,
				weapontype = "StarburstLauncher",
				weaponvelocity = 2000,
				waterweapon = true,
				firesubmersed = true,
				damage = {
					default = 2600,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_ROCKET",
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
armobruiser = {
weapondefs = {
			space_emg = {
				collidefriendly = false,
				collidefeature = false,
				accuracy = 0,
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				burnblow = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				canattackground = false,
				duration = 0.05,
				edgeeffectiveness = 0.5,
				energypershot = 2,
				explosiongenerator = "custom:genericshellexplosion-small",
				impulsefactor = 0,
				intensity = 5,
				name = "Space Laser Battery",
				noselfdamage = true,
				proximitypriority = 1,
				range = 700,
				reloadtime = 0.5,
				rgbcolor = "0.05 0.05 1",
				soundhit = "xplosml3",
				soundhitwet = "sizzle",
				soundstart = "Lasrhvy2",
				thickness = 5,
				tolerance = 40000,
				turret = true,
				weapontimer = 1,
				weapontype = "LaserCannon",
				weaponvelocity = 2400,
				cylindertargeting = 0.5,
				damage = {
					default = 75,
				},
			},
		},
		weapons = {
			[1] = {
				def = "SPACE_EMG",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
				maxangledif = 360,
			},
			[2] = {
				def = "SPACE_EMG",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
				maxangledif = 360,
			},
		},
},
armotachyon = {
weapondefs = {
oata = {
				areaofeffect = 16,
				avoidfeature = false,
				collidefriendly = false,
				avoidfriendly = false,
				canattackground = false,
				beamtime = 0.1,
				corethickness = 0.3,
				largebeamlaser = true,
				laserflaresize = 6.5,
				noselfdamage = true,
				explosiongenerator = "custom:laserhit-large-blue",
				name = "Orbital 2 orbital tachyon lance.",
				rgbcolor = "0 0 1",
				scrollspeed = 5,
				soundhitwet = "sizzle",
				soundstart = "annigun1",
				soundtrigger = 1,
				texture3 = "largebeam",
				thickness = 4.5,
				tilelength = 150,
				range = 1200,
				reloadtime = 7,
				minIntensity = 1,
				energypershot = 200,
				weapontype = "BeamLaser",
				tolerance = 10000,
				turret = true,
				weaponvelocity = 1400,
				cylindertargeting = 30,
				damage = {
					default = 1550,
				},
			},
		},
		weapons = {
			[1] = {
				def = "OATA",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
				maxangledif = 360,
			},
			[2] = {
				def = "",
				onlytargetcategory = "",
			},
		},
},
armokaiser = {
weapondefs = {
			plasma = {
				range = 1000,
				heightBoostFactor = 0,
				customparams = {
					engagementrange = 1200,
					carried_unit = "armodrone",     --Name of the unit spawned by this carrier unit.
					spawns_surface = "LAND SEA",
				},
			},
			aamissile = {
				avoidfriendly = false,
				collidefriendly = false,
				burst = 2,
				burstrate = 0.8,
				areaofeffect = 100,
				burnblow = false,
				cegtag = "missiletrailaa",
				collidefeature = false,
				flighttime = 5,
				name = "Battleship Missile",
				range = 1000,
				weaponacceleration = 300,
				weapontimer = 1,
				weapontype = "MissileLauncher",
				weaponvelocity = 1200,
				cylindertargeting = 0.4,
				damage = {
					default = 1000,
					vtol = "500",
				},
			},
		},
		weapons = {
			[1] = {
				def = "AAMISSILE",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
			[2] = {
				def = "PLASMA",
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
armodrone = {
weapondefs = {
armodrone_missile = {
				areaofeffect = 40,
				avoidfeature = false,
				burnblow = false,
				canattackground = false,
				cegtag = "missiletrailsmall-red",
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:genericshellexplosion-catapult",
				firestarter = 70,
				flighttime = 9,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "catapultmissile.s3o",
				name = "Seeking Interplanetary Missile Launcher",
				noselfdamage = true,
				range = 500,
				reloadtime = 0.3,
				smoketrail = true,
				smokePeriod = 7,
				smoketime = 13,
				smokesize = 5.4,
				smokecolor = 0.95,
				smokeTrailCastShadow = false,
				castshadow = false,
				soundhit = "xplomed2",
				soundhitwet = "splshbig",
				soundstart = "rockhvy2",
				startvelocity = 800,
				texture1 = "null",
				texture2 = "smoketrailaa3",
				tolerance = 20000,
				tracks = true,
				turnrate = 50000,
				turret = true,
				weaponacceleration = 500,
				weapontimer = 1,
				weapontype = "MissileLauncher",
				weaponvelocity = 1200,
				cylindertargeting = 0.4,
				damage = {
					default = 9,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "VTOL",
				def = "ARMODRONE_MISSILE",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
armoliberator = {
weapondefs = {
			heavyplasma = {
				alwaysVisible = true,
				accuracy = 100,
				areaofeffect = 200,
				collidefriendly = false,
				collidefeature = false,
				hightrajectory = 1,
				range = 2100,
				heightBoostFactor = 0,
				damage = {
					default = 400,
					shields = 200,
				},
			},
			ferret_missile = {
				areaofeffect = 50,
				collidefriendly = false,
				collidefeature = false,
				burnblow = false,
				edgeeffectiveness = 0.15,
				flighttime = 5,
				name = "Pop-up rapid-fire o2a missile launcher",
				range = 1000,
				reloadtime = 2,
				damage = {
					default = 600,
				},
			},
		},
		weapons = {
			[2] = {
				def = "HEAVYPLASMA",
				maindir = "0 0 1",
				maxangledif = 320,
				onlytargetcategory = "SURFACE T4AIR",
			},
			[4] = {
				def = "HEAVYPLASMA",
				maindir = "-4 0 1",
				maxangledif = 180,
				onlytargetcategory = "SURFACE T4AIR",
			},
			[5] = {
				def = "HEAVYPLASMA",
				maindir = "4 0 1",
				maxangledif = 180,
				onlytargetcategory = "SURFACE T4AIR",
			},
			[6] = {
				maindir = "0 -1 -2",
				maxangledif = 270,
				def = "FERRET_MISSILE",
				onlytargetcategory = "VTOL SPACENOTOBJECT",
			},
			[7] = {
				def = "FERRET_MISSILE",
				onlytargetcategory = "VTOL SPACENOTOBJECT",
			},
		},
},
corspace = {
buildoptions = {
"corosat",
"coroc",
"corosolar",
"corofighter",
"corocan",
"corobruiser",
"coroheavy",
},
},
corspacet3 = {
buildoptions = {
"coroc",
"corobomber",
"corohunter",
"coroheatray",
"coroapoc",
},
},
coroheatray ={
weapondefs = {
			laser = {
				avoidneutral = false,
				collideneutral = false,
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				areaofeffect = 72,
				avoidfriendly = false,
				energypershot = 350,
				range = 1200,
				minIntensity = 1,
				cylindertargeting = 10,
				heightmod = 0.1,
				damage = {
					default = 4000,
				},
			},
		},
		weapons = {
			[1] = {
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
				maxangledif = 360,
			},
			[2] = {
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
				maxangledif = 360,
			},
		},
},
corofighter = {
weapondefs = {
			lightlaser = {
				canattackground = false,
				collidefriendly = false,
				collidefeature = false,
				areaofeffect = 12,
				avoidfeature = false,
				avoidfriendly = false,
				beamtime = 0.12,
				corethickness = 0.175,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-small-red",
				firestarter = 30,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 7,
				name = "Light orbital laser",
				noselfdamage = true,
				range = 400,
				reloadtime = 0.8,
				rgbcolor = "1 0.05 0.05",
				soundhit = "xplosml3",
				soundhitwet = "sizzle",
				soundstart = "Lasrhvy2",
				proximitypriority = 1,
				soundtrigger = 1,
				thickness = 2,
				tolerance = 50000,
				turret = false,
				weapontype = "BeamLaser",
				weaponvelocity = 2250,
				minIntensity = 1,
				cylindertargeting = 100,
				damage = {
					default = 17.5,
				},
			},
		},
		weapons = {
			[1] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
[2] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
}

-- Command: tweakunits1
{
corocan = {
weapondefs = {
Orbital_3Cannon = {
				areaofeffect = 200,
				avoidfeature = false,
				avoidfriendly = false, 
				burst = 3,
				burstrate= 0.1,
				cegtag = "arty-extraheavy",
				craterareaofeffect = 300,
				collidefriendly = false,
				collidefeature = false,
				canattackground = true,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:genericshellexplosion-large",
				firestarter = 10,
				impulsefactor = 0.2,
				name = "Orbital Bombardment",
				tolerance = 50000,
				noselfdamage = true,
				range = 100,
				reloadtime = 11,
				soundhit = "xplonuk5",
				soundhitwet = "splslrg",
				soundstart = "KroGun1",
				sprayangle = 500,
				turret = true,
				weapontimer = 1,
				weapontype = "Cannon",
				weaponvelocity = 500,
				damage = {
					default = 200,
					commanders = 66.6,
					shields = 40,
				},
			},
},
		weapons = {
			[1] = {
				def = "ORBITAL_3CANNON",
				maindir = "0 -1 0",
				onlytargetcategory = "SURFACE",
			},
		},
},
corobruiser = {
weapondefs = {
Inquisitor_Missiles = {
				collidefriendly = false,
				collidefeature = false,
				areaofeffect = 25,
				avoidfeature = false,
				avoidfriendly = false,
				burst = 2,
				burstrate = 0.2,
				burnblow = false,
				canattackground = false,
				cegtag = "missiletrailviper",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				collidefriendly = false,
				edgeeffectiveness = 0.15,
				energypershot = 0,
				explosiongenerator = "custom:genericshellexplosion-tiny-aa",
				firestarter = 72,
				flighttime = 2,
				impulsefactor = 0.123,
				metalpershot = 0,
				model = "cormissile3fast.s3o",
				name = "Orbital Striker Missiles.",
				noselfdamage = true,
				range = 800,
				reloadtime = 1,
				smoketrail = true,
				smokePeriod = 5,
				smoketime = 12,
				smokesize = 4.8,
				smokecolor = 0.95,
				smokeTrailCastShadow = false,
				castshadow = false, --projectile
				soundhit = "SabotHit",
				soundhitwet = "splshbig",
				soundstart = "SabotFire",
				soundtrigger = true,
				startvelocity = 200,
				texture1 = "null",
				texture2 = "railguntrail",
				tolerance = 9950,
				tracks = true,
				turnrate = 68000,
				turret = true,
				weaponacceleration = 1000,
				weapontype = "MissileLauncher",
				weaponvelocity = 1500,
				cylindertargeting = 0.4,
				damage = {
					default = 85,
				},
			},
},
		weapons = {
			[1] = {
				def = "INQUISITOR_MISSILES",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
maxangledif = 360,
			},
[2] = {
				def = "INQUISITOR_MISSILES",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
maxangledif = 360
			},
		},
},
coroheavy = {
weapondefs = {
			Heavy_Laser = {
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				avoidneutral = false,
				collideneutral = false,
				areaofeffect = 30,
				avoidfeature = false,
				avoidfriendly = false,
				beamtime = 0.15,
				corethickness = 1,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.2,
				energypershot = 50,
				explosiongenerator = "custom:laserhit-medium-red",
				firestarter = 90,
				impactonly = 1,
				impulsefactor = 0.1,
				laserflaresize = 10,
				name = "High energy space laser",
				noselfdamage = true,
				range = 1100,
				reloadtime = 1.2,
				rgbcolor = "1 0 0",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "Lasrmas2",
				soundtrigger = 1,
				thickness = 3.4,
				tolerance = 10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 2250,
				minIntensity = 1,
				cylindertargeting = 80,
				damage = {
					default = 220,
				},
			},
		},
		weapons = {
			[1] = {
				def = "HEAVY_LASER",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
[2] = {
				def = "HEAVY_LASER",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
cororocket = {
weapondefs = {
			madsam_missile = {
				burst = 3,
				burstrate = 0.2,
				areaofeffect = 5,
				avoidfriendly = false,
				alwaysvisible = true,      
				collidefeature = false,
				collidefriendly = false,
				cylindertargeting = 1,
				energypershot = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:genericshellexplosion-medium",
				flighttime = 2,
				name = "Orbital Rocket Defense System",
				tolerance = 65536,
				range = 1000,
				reloadtime = 1.5,
				soundhit = "SabotHit",
				soundhitwet = "splshbig",
				soundstart = "SabotFire",
				smokecolor = 0.7,
				smokeperiod = 9,
				smokesize = 4,
				smoketime = 60,
				smoketrail = true,
				weaponacceleration = 1000,
				weapontimer = 1,
				weaponvelocity = 2000,
				damage = {
					default = 93.3333,
				},
			},
		},
		weapons = {
			[1] = {
				def = "MADSAM_MISSILE",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
corocannon = {
weapondefs = {
			Juno = {
				areaofeffect = 300,
				alwaysvisible = true,
				flighttime = 6,
				cegtag = "genericshellexplosion-small-lightning",
				canattackground = false,
				collidefeature = false,
				collidefriendly = false,
				edgeeffectiveness = 0.5,
				impulsefactor = 2,
				name = "Unstable Anti-Orbital Plasma Sphere",
				model = "",
				range = 1350,
				reloadtime = 9.2,
				tolerance = 5000,
				tracks = true,
				turnRate = 32000,
				soundhit = "xplosml5",
				soundhitwet = "lightning",
				soundstart = "lghthvy1",
				weapontype = "StarburstLauncher",
				explosiongenerator = "custom:genericshellexplosion-huge-lightning",
				startVelocity = 1500,
				weaponvelocity = 1500,
				weaponTimer = 1,
				damage = {
					default = 3500,
				},
			},
		},
		weapons = {
			[1] = {
				def = "JUNO",
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
coroapoc = {
weapondefs = {
			apocalypse = {
				areaofeffect = 500,
				avoidfeature = false,
				alwaysvisible = true,
				burst = 7,
				burstrate = 0.6,
				collidefriendly = false,
				craterareaofeffect = 500,
				craterboost = 1,
				cratermult = 1,
				cegtag = "meteortrail",
				canattackground = true,
				collidefeature = false,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:genericshellexplosion-meteor",
				impulsefactor = 2,
				name = "Meteor Rain",
				noselfdamage = true,
				range = 1700,
				reloadtime = 33,
				tolerance = 4000,
				size = 10,
				soundhit = "xplonuk4",
				startvelocity = 400,
				soundhitwet = "sizzle",
				sprayangle = 900,
				turret = true,
				weapontype = "Cannon",
				weaponacceleration = 400,
				weaponvelocity = 400,
				hightrajectory = 1,
				proximitypriority = -1,
				heightBoostFactor = 0,
				damage = {
					default = 2200,
					shields = 1100,
				},
			},
		},
		weapons = {
			[1] = {
				def = "APOCALYPSE",
				onlytargetcategory = "SURFACE",
				maxangledif = 360,
			},
			[2] = {
				def = "APOCALYPSE",
				onlytargetcategory = "SURFACE",
				maxangledif = 360,
			},
			[3] = {
				def = "APOCALYPSE",
				onlytargetcategory = "SURFACE",
				maxangledif = 360,
			},
			[4] = {
				def = "APOCALYPSE",
				onlytargetcategory = "SURFACE",
				maxangledif = 360,
			},
			[5] = {
				def = "",
			},
			[6] = {
				def = "",
			},
		},
},
legofighter = {
weapondefs = {
			lightlaser = {
				canattackground = false,
				collidefriendly = false,
				collidefeature = false,
				areaofeffect = 12,
				avoidfeature = false,
				avoidfriendly = false,
				beamtime = 0.12,
				corethickness = 0.175,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-small-red",
				firestarter = 30,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 7,
				name = "Light orbital laser",
				noselfdamage = true,
				range = 400,
				reloadtime = 0.8,
				rgbcolor = "0.05 1 0.05",
				soundhit = "xplosml3",
				soundhitwet = "sizzle",
				soundstart = "Lasrhvy2",
				proximitypriority = 1,
				soundtrigger = 1,
				thickness = 2,
				tolerance = 50000,
				turret = false,
				weapontype = "BeamLaser",
				weaponvelocity = 2250,
				minIntensity = 1,
				cylindertargeting = 100,
				damage = {
					default = 17.5,
				},
			},
		},
		weapons = {
			[1] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
[2] = {
				def = "LIGHTLASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
legocan = {
weapondefs = {
			Orbital_LightningCannon = {
				areaofeffect = 250,
				avoidfeature = false,
				avoidfriendly = false,      
				craterareaofeffect = 0,
				canattackground = true,
				collidefeature = false,
				collidefriendly = false,
				cegtag = "lightning_stormbolt",
				energypershot = 30,
				edgeeffectiveness = 0.6,
				explosiongenerator = "custom:genericshellexplosion-medium-lightning",
				firestarter = 10,
				flighttime = 12,
				gravityaffected = "false",
				impulsefactor = 0.4,
				name = "Orbital Lightning Cannon",
				tolerance = 65536,
				noselfdamage = true,
				range = 300,
				cylinderTargeting = 10,
				heightMod = 0.1,
				reloadtime = 12,
				model = "",
				soundhit = "lashit",
				soundhitwet = "sizzle",
				soundstart = "lghthvy1",
				startvelocity = 400,
				turret = true,
				tracks = true,
				tolerance = 60000,
				turnrate = 400,
				weaponacceleration = 400,
				weapontimer = 1,
				weapontype = "MissileLauncher",
				weaponvelocity = 400,
				interceptedByShieldType = 1,
				customparams = {
					cluster_def = 'zap',
					cluster_number = 10,
					exclude_preaim = true,
					smart_priority = true,
				},
				damage = {
					default = 300,
					commanders = 100,
					shields = 60,
				},
			},
			zap = {
				areaofeffect = 100,
				avoidfeature = false,
				cegtag = "lightning_stormbolt_small",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:plasmahit-sparkonly",
				gravityaffected = "true",
				impulsefactor = 0.3,
				name = "Lightning Discharge",
				noselfdamage = true,
				range = 30,
				rgbcolor = "0.7 0.7 1.0",
				soundhit = "lashit",
				soundhitwet = "sizzle",
				soundstart = "",
				weapontype = "Cannon",
				damage = {
					default = 50,
					commanders = 20,
					shields = 20,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_LIGHTNINGCANNON",
				maindir = "0 -1 0",
				maxangledif = 360,
				onlytargetcategory = "NOTAIR",
				weaponAimAdjustPriority = nil,
				fastAutoRetargeting = false,
			},
		},
},
legspace = {
buildoptions = {
"legoc",
"legosat",
"legofighter",
"legocan",
"legosolar",
"legobruiser",
"legotrigun",
},
},
legspacet3 = {
buildoptions = {
"legoc",
"legobomber",
"legospy",
"legofort",
"legohelios",
},
},
}

-- Command: tweakunits2
{
legobruiser = {
weapondefs = {
			velgun = {
 				predictBoost = 0.3,
				collidefriendly = false,
				collidefeature = false,
				areaofeffect = 15,
				avoidfeature = false,
				avoidfriendly = false,
				avoidneutral = false,
				collideneutral = false,
				burst = 6,
				burstrate = 0.09,
				burnblow = false,
				canattackground = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				duration = 0.038,
				edgeeffectiveness = 0.85,
				explosiongenerator = "custom:plasmahit-sparkonly",
				fallOffRate = 0.2,
				firestarter = 0,
				impulsefactor = 0.5,
				intensity = 0.8,
				name = "Rapid-fire machine gun",
				noselfdamage = true,
				proximitypriority = 1,
				range = 540,
				reloadtime = 0.45,
				rgbcolor = "1 0.95 0.4",
				soundhit = "bimpact3",
				soundhitwet = "splshbig",
				soundstart = "mgun2",
				soundstartvolume = 5.0,
				thickness = 0.91,
				tolerance = 60000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 916,
				cylindertargeting = 0.5,
				damage = {
					default = 18,
				},
			},
		},
		weapons = {
			[1] = {
				def = "velgun",
				maindir = "0 0 1",
				maxangledif = 360,
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
legotrigun = {
weapondefs = {
			Longinus_Missile = {
				fixedLauncher = true,
				areaofeffect = 30,
				avoidfeature = false,
				avoidfriendly = false,      
				craterareaofeffect = 0,
				canattackground = false,
				collidefeature = false,
				collidefriendly = false,
				cegtag = "starfire_arty",
				energypershot = 30,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:ministarfire-explosion",
				firestarter = 10,
				flighttime = 5,
				gravityaffected = "false",
				impulsefactor = 0.4,
				name = "Longinus Missile",
				tolerance = 65536,
				noselfdamage = true,
				range = 1200,
				reloadtime = 7,
				model = "",
				soundhit = "xplomed2",
				soundhitwet = "splsmed",
				soundstart = "cannhvy5",
				startvelocity = 450,
				turret = true,
				tracks = true,
				tolerance = 60000,
				turnrate = 30000,
				weaponacceleration = 450,
				weapontype = "StarburstLauncher",
				weaponvelocity = 700,
				cylindertargeting = 0.32,
				damage = {
					default = 1540,
				},
			},
		},
		weapons = {
			[1] = {
				def = "LONGINUS_MISSILE",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
				maxangledif = 360,
			},
			[2] = {
				def = "",
			},
		},
},
legospy = {
weapondefs = {
			spygun = {
				accuracy = 100,
				collidefriendly = false,
				collideenemy = false,
				collidefeature = false,
				accuracy = 0,
				areaofeffect = 1,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "arty-botrail",
				collidefriendly = false,
				edgeeffectiveness = 0,
				explosiongenerator = "custom:botrailspawn",
				gravityaffected = "true",
				heightboostfactor = 0,
				hightrajectory = 0,
				impulsefactor = 0.5,
				leadbonus = 0,
				energypershot = 850,
				metalpershot = 32,
				model = "Units/legeyes.s3o",
				mygravity = 0.22,
				name = "SpyCannon",
				noselfdamage = true,
				range = 1000,
				reloadtime = 6,
				soundhit = "xplonuk1xs",
				soundhitwet = "splshbig",
				soundstart = "lrpcshot3",
				soundstartvolume = 30,
				sprayangle = 2000,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1250,
				customparams = {
					spawns_name = "legoeyes",
					spawns_surface = "LAND SEA",
				},
				damage = {
					default = 1,
				},
},
},
weapons = {
			[1] = {
				def = "SPYGUN",
				onlytargetcategory = "SURFACE",

			},
[2] = {
				def = "SPYGUN",
				onlytargetcategory = "SURFACE",

			},
[3] = {
				def = "SPYGUN",
				onlytargetcategory = "SURFACE",

			},
		},
},
legohelios = {
weapondefs = {
			t3heatray = {
				areaofeffect = 800,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				beamtime = 5,
				camerashake = 0.1,
				corethickness = 5,
				craterareaofeffect = 100,
				craterboost = 0,
				cratermult = 0,
				canattackground = true,
				cylindertargeting = 50,
				edgeeffectiveness = 0.45,
				energypershot = 5000,
				explosiongenerator = "custom:heatray-huge",
				firestarter = 90,
				impulsefactor = 0,
				laserflaresize = 10,
				minIntensity = 1,
				name = "Perfect Orbital Heatray",
				noselfdamage = true,
				range = 500,
				reloadtime = 15,
				rgbcolor = "1 0.5 0",
				rgbcolor2 = "0.9 1.0 0.5",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "heatray3",
				soundstartvolume = 38,
				soundtrigger = 1,
				thickness = 10,
				turret = true,
				tolerance = 65536,
				weapontype = "BeamLaser",
				weaponvelocity = 2100,
				heightmod = 0.1,
				damage = {
					default = 50000,
				},
			},
		},
		weapons = {
			[1] = {
				def = "t3heatray",
				maindir = "0 -1 0",
				maxangledif = 360,
				onlytargetcategory = "SURFACE",
			},
		},
},
legocannon = {
weapondefs = {
					railgunt3 = {
				predictboost = 0.2,
				areaofeffect = 150,
				avoidfeature = false,
				collidefeature = false,
				collideneutral = false,
				avoidneutral = false,
				burnblow = false,
				canattackground = false,
				cegtag = "railgun",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				duration = 0.12,
				edgeeffectiveness = 0.85,
				energypershot = 800,
				explosiongenerator = "custom:genericshellexplosion-large-aa-purple",
				firestarter = 0,
				impulsefactor = 2,
				intensity = 1.0,
				name = "Heavy Anti-Orbital Railgun",
				noselfdamage = true,
				range = 1350,
				reloadtime = 7,
				rgbcolor = "1 0.33 0.7",
				soundhit = "impact",
				soundhitwet = "splshbig",
				soundstart = "railgun3",
				soundstartvolume = 80,
				thickness = 4,
				tolerance = 6000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 4000,
				damage = {
					default = 2450,
				},
			},
		},
		weapons = {
			[1] = {
				def = "railgunt3",
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
legolaser = {
weapondefs = {
Orbital_Beamer = {
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				burnblow = false,
				beamdecay = 0.05,
				beamtime = 0.1,
				beamttl = 1,
				corethickness = 0.233,
				gravityaffected = "false",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				collidefriendly = false,
				collidefeature = false,
				cylindertargeting = 128,
				edgeeffectiveness = 1,
				energypershot = 2,
				explosiongenerator = "custom:laserhit-medium-green",
				firestarter = 30,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 9.35,
				name = "Anti Orbital Laser",
				noselfdamage = true,
				range = 1000,
				reloadtime = 0.1,
				rgbcolor = "0.1 1 0.1",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "beamershot2",
				soundtrigger = 1,
				thickness = 2.4,
				tolerance = 65000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 3500,
				weapontimer = 4,
				minIntensity = 1,
				heightmod = 0.1,
				damage = {
					default = 19,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_BEAMER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
armolaser = {
weapondefs = {
			orbital_laser = {
				accuracy = 0,
				areaofeffect = 10,
				avoidfriendly = false,
				avoidfeature = false,
				alwaysvisible = true,
				burnblow = false,
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				canattackground = false,
				cylindertargeting = 5,
				duration = 0.1,
				edgeeffectiveness = 1,
				energypershot = 1,
				explosiongenerator = "custom:genericshellexplosion-small",
				gravityaffected = "false",
				stages = 0,
				impulsefactor = 0,
				intensity = 5,
				name = "Orbital Defense Laser",
				noselfdamage = true,
				range = 1000,
				reloadtime = 0.2,
				rgbcolor = "0 0 1",
				predictboost = 1,
				soundhit = "xplosml3",
				soundhitwet = "sizzle",
				soundstart = "Lasrhvy2",
				thickness = 5,
				tolerance = 65535,
				turret = true,
				weapontimer = 3,
				weapontype = "LaserCannon",
				weaponvelocity = 1500,
				heightmod = 0.1,
				damage = {
					default = 39,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_LASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
armobomber = {
weapondefs = {
			arm_botrail = {
				accuracy = 0,
				areaofeffect = 0.2,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "arty-botrail",
				collidefriendly = false,
				craterareaofeffect = 116,
				craterboost = 0.1,
				cratermult = 0.1,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:botrailspawn",
				gravityaffected = "true",
				heightboostfactor = 0,
				hightrajectory = 0,
				impulsefactor = 0.5,
				leadbonus = 0,
				energypershot = 5900,
				metalpershot = 65,
				model = "Units/ARMVADER.s3o",
				mygravity = 0.22,
				name = "Tumbleweed Cannon",
				noselfdamage = true,
				range = 900,
				reloadtime = 1,
				stockpile = true,
				stockpiletime = 6,
				soundhit = "xplonuk1xs",
				soundhitwet = "splshbig",
				soundstart = "lrpcshot3",
				soundstartvolume = 50,
				sprayangle = 600,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 1250,
				customparams = {
					spawns_name = "armvader",
					spawns_surface = "LAND",
					stockpilelimit = 10,
				},
				damage = {
					default = 1000,
					commanders = 500,
					shields = 500,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ARM_BOTRAIL",
				maindir = "0 -1 0",
				maxangledif = 360,
				onlytargetcategory = "SURFACE",
			},
[2] = {
def = "",
},
[3] = {
def = "",
},
[4] = {
def = "",
},
[5] = {
def = "",
},
		},
},
}

-- Command: tweakunits3
{
armomulti = {
weapondefs = {
			Orbital_cannon = {
				areaofeffect = 100,
				alwaysvisible = true,
				avoidfriendly = false,
				avoidfeature = false,
				canattackground = true,
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.3,
				explosiongenerator = "custom:genericshellexplosion-medium",
				firestarter = 5,
				impulsefactor = 0.2,
				name = "Orbital Gauss Cannon",
				noselfdamage = true,
				range = 600,
				reloadtime = 1,
				predictboost = 1,
				soundhit = "xplomed2",
				soundhitwet = "splshbig",
				soundstart = "cannhvy2",
				turret = true,
				weapontimer = 3,
				weapontype = "Cannon",
				weaponvelocity = 1200,
				heightBoostFactor = 0,
				damage = {
					default = 400,
				},
			},
Orbital_HighEnergyLaser = {
				areaofeffect = 10,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				beamtime = 0.15,
				corethickness = 0.18,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				edgeeffectiveness = 0.15,
				energypershot = 20,
				explosiongenerator = "custom:laserhit-medium-green",
				firestarter = 90,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 7.7,
				name = "HighEnergyLaser",
				noselfdamage = true,
				range = 1200,
				reloadtime = 3,
				rgbcolor = "0 1 0",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "Lasrmas2",
				soundtrigger = 1,
				thickness = 2.4,
				tolerance = 65000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 900,
				heightmod = 0.1,
				cylindertargeting = 50,
				minIntensity = 1,
				damage = {
					default = 450,
		},
},
},
		weapons = {
[1] = {
				def = "ORBITAL_HIGHENERGYLASER",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
},
[2] = {
				def = "ORBITAL_HIGHENERGYLASER",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
},
[3] = {
				def = "ORBITAL_CANNON",
				fastautoretargeting = true,
				onlytargetcategory = "NOTAIR",
			},
		},
},
coromulti = {
weapondefs = {
			corviper_missile = {
				areaofeffect = 50,
				avoidfeature = false,
				avoidfriendly = false,
				castshadow = true,
				cegtag = "missiletrailviper",
				alwaysvisible = true,
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				canattackground = true,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:genericshellexplosion-medium-bomb",
				firestarter = 70,
				flighttime = 3,
				impulsefactor = 0.123,
				model = "cormissile3fast.s3o",
				name = "Heavy o2g rocket launcher",
				noselfdamage = true,
				range = 600,
				reloadtime = 2,
				smokecolor = 0.8,
				smokeperiod = 10,
				smokesize = 10,
				smoketime = 33,
				smoketrail = true,
				smoketrailcastshadow = false,
				soundhit = "SabotHit",
				soundhitwet = "splshbig",
				soundstart = "SabotFire",
				startvelocity = 900,
				texture1 = "null",
				texture2 = "railguntrail",
				tolerance = 65000,
				tracks = true,
				turnrate = 6000,
				turret = true,
				weaponacceleration = 400,
				weapontimer = 0.1,
				weapontype = "MissileLauncher",
				weaponvelocity = 1300,
				cylindertargeting = 10,
				heightmod = 0.1,
				damage = {
					default = 820,
				},
			},
			doomsday_green_laser = {
				areaofeffect = 8,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				beamtime = 0.225,
				corethickness = 0.185,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				edgeeffectiveness = 0.15,
				energypershot = 45,
				explosiongenerator = "custom:laserhit-medium-red",
				firestarter = 90,
				impactonly = 1,
				impulsefactor = 0,
				laserflaresize = 7.7,
				name = "High energy laser",
				noselfdamage = true,
				range = 1200,
				reloadtime = 6,
				rgbcolor = "1 0.1 0.1",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "Lasrmas2",
				soundtrigger = 1,
				thickness = 5,
				tolerance = 10000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 900,
				heightmod = 0.1,
				cylindertargeting = 50,
				minIntensity = 1,
				damage = {
					default = 1000,
				},
			},
			doomsday_red_laser = {
				areaofeffect = 40,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				cegtag = "missiletrailsmall",
				flighttime = 4,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				collidefriendly = false,
				collidefeature = false,
				canattackground = false,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:genericshellexplosion-medium",
				firestarter = 100,
				impulsefactor = 0,
				model = "cormissile3fast.s3o",
				name = "Rocket Battery",
				noselfdamage = true,
				proximitypriority = 1,
				range = 900,
				reloadtime = 0.8,
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "lasrfir3",
				soundtrigger = 1,
				startvelocity = 600,
				tolerance = 10000,
				turnrate = 20000,
				turret = true,
				tracks = true,
				weapontype = "MissileLauncher",
				weaponvelocity = 600,
				damage = {
					default = 80,
				},
			},
		},
		weapons = {
			[1] = {
				def = "CORVIPER_MISSILE",
				onlytargetcategory = "NOTAIR",
			},
			[2] = {
				def = "DOOMSDAY_GREEN_LASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
			[3] = {
				def = "DOOMSDAY_RED_LASER",
				fastautoretargeting = true,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
legomulti = {
		weapondefs = {
			Orbital_Gatling = {
				accuracy = 0,
				areaofeffect = 32,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				burst = 3,
				burstrate = 0.02,
				burnblow = false,
				canattackground = false,
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 192,
				craterboost = 0,
				cratermult = 0,
				cylindertargeting = 3,
				duration = 0.1,
				edgeeffectiveness = 1,
				gravityaffected = "false",
				impulsefactor = 0,
				mygravity = 0.01,
				name = "Heavy Anti-Orbital Gatling Gun",
				noselfdamage = true,
				predictboost = 1,
				range = 1100,
				reloadtime = 0.166,
				smoketrail = false,
				soundhit = "bimpact3",
				soundhitwet = "splshbig",
				soundstart = "minigun3",
				soundhitvolume = 7.5,
				soundstartvolume = 5,
				stages = 0,
				texture1 = "shot",
				texture2 = "empty",
				thickness = 3,
				tolerance = 16000,
				turret = true,
				weapontimer = 3,
				weapontype = "LaserCannon",
				weaponvelocity = 3642,
				damage = {
					default = 15.5,
				},
				rgbcolor = "1 0.33 0.7",
				explosiongenerator = "custom:plasmahit-sparkonly",
				ownerExpAccWeight = 1.35,--does this affect sprayangle too?
				sprayangle = 100,
				fallOffRate = 0.2,
			},
			orbital_railgun = {
				areaofeffect = 16,
				avoidfeature = false,
				avoidfriendly = false,
				alwaysvisible = true,
				canattackground = true,
				collidefriendly = false,
				collidefeature = false,
				cylindertargeting = 50,
				heightMod = 0.1,
				burnblow = false,
				cegtag = "railgun",
				collisionSize = 0.667,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				duration = 0.12,
				edgeeffectiveness = 0.85,
				energypershot = 200,
				explosiongenerator = "custom:plasmahit-sparkonly",
				firestarter = 0,
				hardstop = true,
				impactonly = true,
				impulsefactor = 1,
				intensity = 0.8,
				name = "Orbital Railgun",
				noexplode = true,
				noselfdamage = true,
				ownerExpAccWeight = 4.0,
				proximitypriority = 1,
				predictboost = 1,
				range = 850,
				reloadtime = 6,
				rgbcolor = "0.34 0.64 0.94",
				soundhit = "mavgun3",
				soundhitwet = "splshbig",
				soundstart = "heavyrailgun",
				soundstartvolume = 26,
				thickness = 3,
				tolerance = 65000,
				turret = true,
				weapontype = "LaserCannon",
				weaponvelocity = 3180,
				damage = {
					default = 2400,
				},
			},
		},
		weapons = {
			[1] = {
				def = "ORBITAL_GATLING",
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
				burstControlWhenOutOfArc = "nil",
			},
			[2] = {
				def = "ORBITAL_RAILGUN",
				onlytargetcategory = "SURFACE",
				burstControlWhenOutOfArc = "nil",
				slaveto = "nil",
			},
		},
},
legobomber = {
weapondefs = {
shocker_low = {
				areaofeffect = 200,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "starfire_arty",
				collidefriendly = false,
				craterareaofeffect = 200,
				craterboost = 0,
				cratermult = 0,
				size = 6,
				edgeeffectiveness = 0.2,
				energypershot = 300,
				explosiongenerator = "custom:starfire-explosion",
				gravityaffected = "true",
				heightboostfactor = 0,
				impulsefactor = 0.5,
				leadbonus = 0,
				name = "Long-Range Heavy Cluster Plasma Cannon",
				noselfdamage = true,
				range = 1000,
				reloadtime = 5,
				rgbcolor = "0.7 0.7 1.0",
				soundhit = "lrpcexplo",
				soundhitwet = "splshbig",
				soundstart = "lrpcshot3",
				soundhitvolume = 38,
				soundstartvolume = 24,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 600,
				customparams = {
					cluster_def = 'cluster_munition',
					cluster_number = 4,
				},
				damage = {
					default = 2000,
					shields = 1000,
					commanders = 666.6,
				},
			},
cluster_munition = {
				areaofeffect = 150,
				avoidfeature = false,
				cegtag = "ministarfire",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:ministarfire-explosion",
				gravityaffected = "true",
				impulsefactor = 0.5,
				name = "Plasma Burst",
				noselfdamage = true,
				maxvelocity = 720,
				range = 110,
				rgbcolor = "0.7 0.7 1.0",
				soundhit = "xplomed2",
				soundhitwet = "splsmed",
				soundstart = "cannhvy5",
				weapontype = "Cannon",
				reloadtime = 5,
				damage = {
					default = 500,
				},
			},
		},
		weapons = {
			[1] = {
				def = "SHOCKER_LOW",
				maindir = "0 -1 0",
				onlytargetcategory = "SURFACE",
			},
		},
},
armollt = {
	weapondefs = {
			arm_lightlaser = {
				range = 600,
				reloadtime = 0.7,
				minIntensity = 1,
				cylindertargeting = 50,
				heightmod = 0.1,
				damage = {
					commanders = nil,
					default = 42,
					subs = nil,
					vtol = nil,
				},
               },
        },
weapons = {
			[1] = {
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
corollt = {
	weapondefs = {
			cor_lightlaser = {
				range = 600,
				reloadtime = 0.7,
				minIntensity = 1,
				cylindertargeting = 50,
				heightmod = 0.1,
				damage = {
					commanders = nil,
					default = 42,
					subs = nil,
					vtol = nil,
				},
               },
        },
weapons = {
			[1] = {
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
legollt = {
	weapondefs = {
			heat_ray = {
				range = 600,
				reloadtime = 0.7,
				minIntensity = 1,
				beamtime = 0.12,
				cylindertargeting = 50,
				heightmod = 0.1,
				damage = {
					commanders = nil,
					default = 42,
					subs = nil,
					vtol = nil,
				},
               },
        },
weapons = {
			[1] = {
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
		},
},
}

-- Command: tweakunits4
{
corobomber = {
weapondefs = {
cannon = {
				burst = 3,
				burstrate = 0.2,
				alwaysvisible = true,
				collidefriendly = false,
				collidefeature = false,
				avoidfriendly = false,
				canattackground = true,
				areaofeffect = 100,
				heightboostfactor = 0,
				cegtag = "missiletrailmship",
				craterareaofeffect = 100,
				edgeeffectiveness = 0.7,
				explosiongenerator = "custom:genericshellexplosion-medium-bomb",
				interceptedbyshieldtype = 1,
				name = "Orbital Bombardment Battery.",
				proximitypriority = 1,
				range = 900,
				reloadtime = 4,
				smoketrail = false,
				weapontype = "Cannon",
				weaponvelocity = 500,
				soundhit = "lrpcexplo",
				soundhitwet = "splshbig",
				soundstart = "lrpcshot2",
				soundhitvolume = 19,
				soundstartvolume = 12,
				soundtrigger = true,
				turret = true,
				damage = {
					default = 500,
					commanders = 166.6,
				},
			},
			heavy_cannon = {
				areaofeffect = 200,
				alwaysvisible = true,
				canattackground = true,
				collidefriendly = false,
				collidefeature = false,
				name = "Heavy long-range orbital payload cannon.",
				explosiongenerator = "custom:genericshellexplosion-huge-bomb",
				range = 900,
				size = 10,
				reloadtime = 7,
				weaponvelocity = 400,
				heightboostfactor = 0,
				edgeeffectiveness = 0.3,
				hightrajectory = 1,
				impulsefactor = 0.5,
				weapontype = "Cannon",
				tolerance = 4000,
				turret = true,
				soundhit = "lrpcexplo",
				soundhitvolume = 20,
				soundhitwet = "splshbig",
				soundstart = "lrpcshot",
				damage = {
					default = 2500,
					shields = 1250,
					commanders = 1000,
				},
			},
		},
		weapons = {
			[1] = {
				def = "HEAVY_CANNON",
				maindir = "0 0.5 1",
				maxangledif = 360,
				onlytargetcategory = "SURFACE",
			},
			[2] = {
				def = "CANNON",
				onlytargetcategory = "SURFACE",
			},
		},
},
legofort = {
		weapondefs = {
			semiauto = {
				collidefriendly = false,
				collidefeature = false,
				accuracy = 1,
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				beamburst = true,
				beamdecay = 1,
				beamtime = 0.07,
				burst = 6,
				burstrate = 0.06667,
				canattackground = false,
				corethickness = 0.35,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.15,
				explosiongenerator = "custom:laserhit-medium-green",
				firestarter = 10,
				impulsefactor = 0,
				largebeamlaser = true,
				laserflaresize = 8.8,
				name = "Rapid-fire close quarters orbital 2 orbital laser",
				noselfdamage = true,
				proximitypriority = 1,
				pulsespeed = 8,
				range = 1050,
				reloadtime = 0.63333,
				rgbcolor = "0 0.75 0",
				rgbcolor2 = "0.9 0.9 0.6",
				soundhitdry = "",
				soundhitwet = "sizzle",
				soundstart = "lasfirerc",
				soundtrigger = 1,
				targetborder = 0.2,
				thickness = 2.4,
				tolerance = 30000,
				turret = true,
				weapontype = "BeamLaser",
				weaponvelocity = 920,
				damage = {
					default = 21.111,
				},
			},
			Omissiles = {
				proximitypriority = -1,
				avoidfriendly = false,
				areaofeffect = 60,
				avoidfeature = false,
				collidefriendly = false,
				collidefeature = false,
				burnblow = true,
				canattackground = false,
				cegtag = "missiletrailaa",
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:genericshellexplosion-medium",
				firestarter = 72,
				fixedLauncher = true,
				flighttime = 7.5,
				impulsefactor = 0.123,
				model = "leglargerocket.s3o",
				name = "Advanced o2o missile launcher",
				noselfdamage = true,
				range = 1050,
				reloadtime = 6,
				smoketrail = true,
				smokePeriod = 5,
				smoketime = 8,
				smokesize = 4.2,
				smokecolor = 1.0,
				smokeTrailCastShadow = false,
				castshadow = false,
				startvelocity = 150,
				soundhit = "rockhit3",
				soundhitwet = "splssml",
				soundstart = "rocklit1",
				soundtrigger = true,
				startvelocity = 400,
				texture1 = "null",
				texture2 = "smoketrailaa",
				tolerance = 9950,
				tracks = true,
				trajectoryHeight = 1,
				turnrate = 52000,
				weaponacceleration = 500,
				weapontype = "StarburstLauncher",
				weapontimer = 0.32,
				weaponvelocity = 1200,
				damage = {
					default = 2600,
				},
			},
},
		weapons = {
			[1] = {
				def = "OMISSILES",
				maindir = "-1 0 0",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
			[2] = {
				def = "OMISSILES",
				maindir = "1 0 0",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT T4AIR",
			},
			[3] = {
				def = "SEMIAUTO",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
			[4] = {
				def = "SEMIAUTO",
				maindir = "-1 0 0",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
			[5] = {
				def = "SEMIAUTO",
				maindir = "1 0 0",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
			[6] = {
				def = "SEMIAUTO",
				maindir = "1 0 0",
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
corohunter = {
weapondefs = {
corviper_missile = {
				areaofeffect = 50,
				avoidfeature = false,
				avoidfriendly = false,
				castshadow = false,
				cegtag = "missiletrailviper",
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				canattackground = false,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:genericshellexplosion-medium-bomb",
				firestarter = 70,
				flighttime = 3,
				impulsefactor = 0.123,
				model = "cormissile3fast.s3o",
				name = "Anti Orbital and Air Rocket Battery.",
				noselfdamage = true,
				range = 600,
				reloadtime = 0.5,
				smokecolor = 0.8,
				smokeperiod = 10,
				smokesize = 10,
				smoketime = 33,
				smoketrail = true,
				smoketrailcastshadow = false,
				soundhit = "SabotHit",
				soundhitwet = "splshbig",
				soundstart = "SabotFire",
				startvelocity = 900,
				texture1 = "null",
				texture2 = "railguntrail",
				tolerance = 65000,
				tracks = true,
				turnrate = 10000,
				turret = true,
				weaponacceleration = 400,
				weapontimer = 0.1,
				weapontype = "MissileLauncher",
				weaponvelocity = 1300,
				cylindertargeting = 0.5,
				damage = {
					default = 200,
				},
			},
},
		weapons = {
			[1] = {
				def = "CORVIPER_MISSILE",
				onlytargetcategory = "SPACENOTOBJECT",
				fastautoretargeting = true,
			},
		},
},
armohorizon = {
	weapondefs = {
		arm_botrail = {
				commandfire = true,
				accuracy = 1,
				areaofeffect = 150,
				avoidfeature = false,
				avoidfriendly = false,
				collidefriendly = false,
				craterareaofeffect = 116,
				craterboost = 0.1,
				cratermult = 0.1,
				edgeeffectiveness = 0.2,
				explosiongenerator = "custom:botrailspawn",
				gravityaffected = "true",
				heightboostfactor = 0,
				impulsefactor = 0.5,
				energypershot = 71000,
				metalpershot = 3300,
				model = "pbr_cube.s3o",
				name = "Orbital Vanguard Deployment Cannon",
				noselfdamage = true,
				range = 2000,
				reloadtime = 1,
				stockpile = true,
				stockpiletime = 60,
				soundhit = "xplonuk1xs",
				soundhitwet = "splshbig",
				soundstart = "lrpcshot3",
				soundstartvolume = 50,
				turret = true,
				weapontype = "Cannon",
				weaponvelocity = 500,
				hightrajectory = 1,
				stages = 24,
				interceptedByShieldType = 1,
				customparams = {
					spawns_name = "armvang",
					spawns_surface = "LAND",
					stockpilelimit = 2,
				},
				damage = {
					default = 1000,
				},
			},
		waterballon = {
				canattackground = false,
				range = 1000,
				reloadtime = 5,
				burnblow = false,
				name = "Orbital Strike Rocket",
				cegtag = "missiletrailviper",
				weapontype = "MissileLauncher",
				turnrate = 10000,
				weaponacceleration = 150,
				weaponvelocity = 800,
				weapontimer = 1,
				flighttime = 5,
				cylindertargeting = 0.4,
				damage = {
					commanders = nil,
					default = 1000,
					subs = nil,
				},
			},
		},
		weapons = {
			[1] = {
				badtargetcategory = "",
				def = "waterballon",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
			[2] = {
				def = "ARM_BOTRAIL",
				onlytargetcategory = "SURFACE",
			},
			[3] = {
				def = "NUCLEAR_LAUNCH",
			},
		},
},
armoplane = {
   weapondefs = {
      			space_rocket = {
				burst = 2,
				burstrate = 0.3,
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "missiletrailfighter",
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.25,
				explosiongenerator = "custom:genericshellexplosion-tiny-air",
				flighttime = 3,
				impulsefactor = 0.123,
				model = "cormissile2fast.s3o",
				name = "Anti Space Rockets",
				noselfdamage = true,
				range = 410,
				reloadtime = 1,
				soundhit = "xplosml2",
				soundhitwet = "splshbig",
				soundstart = "Rocklit3",
				tolerance = 12000,
				tracks = true,
				turnrate = 20000,
				turret = true,
				weapontype = "MissileLauncher",
				startVelocity = 700,
				weaponVelocity = 700,
				canAttackGround = false,
				damage = {
					default = 40,
				},
			},
   },
		weapons = {
			[1] = {
				def = "SPACE_ROCKET",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
coroplane = {
  weapondefs = {
      			space_rocket = {
				burst = 2,
				burstrate = 0.3,
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "missiletrailfighter",
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.25,
				explosiongenerator = "custom:genericshellexplosion-tiny-air",
				flighttime = 3,
				impulsefactor = 0.123,
				model = "cormissile2fast.s3o",
				name = "Anti Space Rockets",
				noselfdamage = true,
				range = 410,
				reloadtime = 1,
				soundhit = "xplosml2",
				soundhitwet = "splshbig",
				soundstart = "Rocklit3",
				tolerance = 12000,
				tracks = true,
				turnrate = 20000,
				turret = true,
				weapontype = "MissileLauncher",
				startVelocity = 700,
				weaponVelocity = 700,
				canAttackGround = false,
				damage = {
					default = 40,
				},
			},
   },
		weapons = {
			[1] = {
				def = "SPACE_ROCKET",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
legoplane = {
   weapondefs = {
      			space_rocket = {
				burst = 2,
				burstrate = 0.3,
				areaofeffect = 20,
				avoidfeature = false,
				avoidfriendly = false,
				cegtag = "missiletrailfighter",
				collidefriendly = false,
				collidefeature = false,
				craterareaofeffect = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.25,
				explosiongenerator = "custom:genericshellexplosion-tiny-air",
				flighttime = 3,
				impulsefactor = 0.123,
				model = "cormissile2fast.s3o",
				name = "Anti Space Rockets",
				noselfdamage = true,
				range = 410,
				reloadtime = 1,
				soundhit = "xplosml2",
				soundhitwet = "splshbig",
				soundstart = "Rocklit3",
				tolerance = 12000,
				tracks = true,
				turnrate = 20000,
				turret = true,
				weapontype = "MissileLauncher",
				startVelocity = 700,
				weaponVelocity = 700,
				canAttackGround = false,
				damage = {
					default = 40,
				},
			},
   },
		weapons = {
			[1] = {
				def = "SPACE_ROCKET",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SPACENOTOBJECT",
			},
		},
},
}

-- Command: tweakdefs4
local _u = {}
function SET(def) _u = table.copy(UnitDefs[def]) end
function ADD(name) UnitDefs[name] = _u end
function CP()    _u.customparams = {} end
function HP(v)    _u.health    = v end
function SD(v)    _u.sightdistance    = v end
function TECH(v) _u.customparams.techlevel  = v end
function NAME(v) _u.customparams.i18n_en_humanname   = v end
function DESC(v) _u.customparams.i18n_en_tooltip    = v end
function SP(v) _u.speed = v end
function RA(v) _u.radiusadjust = v  end
function TR(v) _u.turnrate = v end
function ONAME(v) _u.objectname = v end
function UNAME(v) _u.unitname = v end
function RAPTORS(v)
_u.reclaimable = false
_u.repairable = true
_u.cruisealtitude = v
_u.verticalspeed = 8
_u.category = "SPACENOTOBJECT RAPTOR"
_u.customparams.raptorcustomsquad = true
end
function RSUA(v) _u.customparams.raptorsquadunitsamount = v end
function RSMINA(v) _u.customparams.raptorsquadminanger = v end
function RSMAXA(v) _u.customparams.raptorsquadmaxanger = v end
function RSW(v) _u.customparams.raptorsquadweight = v end
function RSR(v) _u.customparams.raptorsquadrarity = v end
function RSB(v) _u.customparams.raptorsquadbehavior = v end
function RSBD(v) _u.customparams.raptorsquadbehaviordistance = v end
function RSBC(v) _u.customparams.raptorsquadbehaviorchance = v end

SET("raptor_air_fighter_basic_t2_v1")
RAPTORS(1600)
RSUA(4)
RSMINA(10)
RSMAXA(100)
RSW(1)
RSR("basic")
RSB("raider")
RSBD(100)
RSBC(1)
HP(700)
SP(200)
NAME("Gnaw")
DESC("Orbital fighter.")
SD(400)
UNAME("raptor_orbital_fighter_basic_t2_v1")
ADD("raptor_orbital_fighter_basic_t2_v1")

SET("raptor_air_bomber_basic_t2_v1")
RAPTORS(2000)
RSUA(3)
RSMINA(12)
RSMAXA(100)
RSW(2)
RSR("basic")
RSB("artillery")
RSBD(450)
RSBC(0.5)
HP(1000)
SP(100)
NAME("Regurgitator")
DESC("Orbital acid rain.")
SD(500)
UNAME("raptor_orbital_bomber_basic_t2_v1")
ADD("raptor_orbital_bomber_basic_t2_v1")

SET("raptor_air_fighter_basic_t4_v1")
RAPTORS(1600)
RSUA(2)
RSMINA(40)
RSMAXA(100)
RSW(4)
RSR("basic")
RSB("raider")
RSBD(100)
RSBC(1)
HP(3000)
SP(120)
NAME("Apex Gnaw")
DESC("Evolved Orbital Fighter.")
SD(400)
UNAME("raptor_orbital_bruiser_basic_t2_v1")
ADD("raptor_orbital_bruiser_basic_t2_v1")

SET("raptor_air_bomber_basic_t4_v1")
RAPTORS(2000)
RSUA(3)
RSMINA(40)
RSMAXA(100)
RSW(2)
RSR("basic")
RSB("artillery")
RSBD(1000)
RSBC(0.5)
HP(3000)
SP(90)
NAME("Bleeder")
DESC("Orbital Bombardment.")
SD(400)
UNAME("raptor_orbital_bomber_basic_t3_v1")
ADD("raptor_orbital_bomber_basic_t3_v1")

SET("raptor_air_bomber_brood_t4_v4")
RAPTORS(2000)
RSUA(1)
RSMINA(70)
RSMAXA(110)
RSW(1)
RSR("special")
RSB("raider")
RSBD(1000)
RSBC(1)
HP(35000)
SP(80)
NAME("Fleshlord")
DESC("Orbital Biological Battleship.")
SD(1000)
UNAME("raptor_orbital_battleship_basic_t3_v1")
ADD("raptor_orbital_battleship_basic_t3_v1")

SET("raptor_hive")
_u.weapondefs.antiair.collidefeature = false
_u.weapondefs.antiair.damage.default = 500
_u.weapondefs.antiair.burnblow = false
_u.weapons[2].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("raptor_hive")

SET("raptor_turret_antiair_t2_v1")
_u.weapondefs.weapon.collidefeature = false
_u.weapondefs.weapon.damage.default = 700
_u.weapondefs.weapon.burnblow = false
_u.weapons[1].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("raptor_turret_antiair_t2_v1")

SET("raptor_turret_antiair_t3_v1")
_u.weapondefs.weapon.collidefeature = false
_u.weapondefs.weapon.damage.default = 1000
_u.weapondefs.weapon.burnblow = false
_u.weapons[1].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("raptor_turret_antiair_t3_v1")

SET("raptor_turret_antiair_t4_v1")
_u.weapondefs.weapon.collidefeature = false
_u.weapondefs.weapon.damage.default = 1000
_u.weapondefs.weapon.burnblow = false
_u.weapons[1].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("raptor_turret_antiair_t4_v1")

SET("raptor_queen_easy")
_u.weapondefs.yellow_missile.collidefeature = false
_u.weapondefs.yellow_missile.damage.default = 1000*playerCountScale
_u.weapondefs.yellow_missile.burnblow = false
_u.weapons[2].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[3].onlytargetcategory = "VTOL SPACENOTOBJECT"
_u.weapons[4].onlytargetcategory = "VTOL SPACENOTOBJECT"
ADD("raptor_queen_veryeasy")
ADD("raptor_queen_easy")
ADD("raptor_queen_normal")
ADD("raptor_queen_hard")
ADD("raptor_queen_veryhard")
ADD("raptor_queen_epic")

for name, ud in pairs(UnitDefs) do
 local category = ud.category
  if category and category:find("RAPTOR") and not name:match("^raptor_queen") and ud.weapons then
    for i, weapon in ipairs(ud.weapons) do
      if not weapon.onlytargetcategory then
        weapon.onlytargetcategory = "SUB NOTSUB"
      end
    end
  end
end

-- Command: tweakunits5
{
raptor_orbital_fighter_basic_t2_v1 = {
   weapondefs = {
      weapon = {
         areaofeffect = 20,
         range = 500,
         damage = {
            default = 150,
         },
      },
   },
   weapons ={
      [1] = {
         maxangledif = 360,
         onlytargetcategory = "SPACENOTOBJECT",
      },
   },
},
raptor_orbital_bomber_basic_t2_v1 = {
   weapondefs = {
     			acidspit = {
				areaofeffect = 150,
				collidefriendly = 0,
				collidefeature = 0,
				avoidfeature = 0,
				avoidfriendly = 0,
				cegtag = "blob_trail_green",
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.63,
				explosiongenerator = "custom:acid-explosion-xl",
				impulsefactor = 0,
				intensity = 0.7,
				interceptedbyshieldtype = 1,
				name = "ACIDCANNON",
				noselfdamage = true,
				nogap = false,
				size = 9,
				sizedecay = 0.04,
				alphaDecay = 0.18,
				stages = 8,
				proximitypriority = -1,
				range = 500,
				reloadtime = 10,
				rgbcolor = "0.8 0.99 0.11",
				soundhit = "bloodsplash3",
				soundstart = "alien_bombrel",
				tolerance = 5000,
				turret = true,
				weapontype = "Cannon",
				weapontimer = 3,
				weaponvelocity = 520,
				heightBoostFactor = 0,
				customparams = {
					area_onhit_ceg = "acid-area-150-repeat",
					area_onhit_damageCeg = "acid-damage-gen",
					area_onhit_time = 10,
					area_onhit_damage = 100,
					area_onhit_range = 150,
					area_onhit_resistance = "_RAPTORACID_",
				},
				damage = {
					default = 100,
					shields = 100,
				},
			},
   },
   weapons = {
      [1] = {
				badtargetcategory = "MOBILE",
				def = "acidspit",
				onlytargetcategory = "SURFACE",
			},
   },
},
raptor_orbital_bruiser_basic_t2_v1 = {
weapondefs = {
      weapon = {
         areaofeffect = 100,
         range = 800,
         damage = {
            default = 250,
         },
      },
   },
   weapons ={
      [1] = {
         maxangledif = 360,
         onlytargetcategory = "SPACENOTOBJECT",
      },
   },
},
raptor_orbital_bomber_basic_t3_v1 = {
   weapondefs = {
      goolauncher = {
				projectiles = 6,
				areaofeffect = 150,
				collidefriendly = 0,
				collidefeature = 0,
				avoidfeature = 0,
				avoidfriendly = 0,
				cegtag = "blob_trail_red",
				craterareaofeffect = 150,
				craterboost = 0.2,
				cratermult = 0.2,
				edgeeffectiveness = 0.5,
				explosiongenerator = "custom:genericshellexplosion-huge",
				impulsefactor = 0.4,
				intensity = 0.7,
				interceptedbyshieldtype = 1,
				name = "GOOLAUNCHER",
				noselfdamage = true,
				proximitypriority = -1,
				range = 1000,
				reloadtime = 6,
				rgbcolor = "1 0.5 0.1",
				size = 5.5,
				sizedecay = 0.09,
				soundhit = "bombsmed2",
				soundstart = "bugarty",
				sprayangle = 300,
				tolerance = 20000,
				turret = true,
				heightBoostFactor = 0,
				weapontype = "Cannon",
				weaponvelocity = 600,
				damage = {
					default = 500,
				},
			},
		},
		weapons = {
			[1] = {
				def = "GOOLAUNCHER",
				maindir = "0 0 1",
				maxangledif = 360,
				onlytargetcategory = "SURFACE",
			},
		},
},
raptor_orbital_battleship_basic_t3_v1 = {
   weapondefs = {
      goo = {
				areaofeffect = 250,
				avoidfeature = 0,
				avoidfriendly = 0,
				projectiles = 3,
				cegtag = "nuketrail-roost",
				flighttime = 6,
				collidefriendly = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.7,
				explosiongenerator = "custom:genericshellexplosion-large",
				firesubmersed = true,
				impulsefactor = 0,
				intensity = 0.7,
				interceptedbyshieldtype = 1,
				model = "Raptors/SGreyRock1.S3O",
				name = "Blob",
				noselfdamage = true,
				proximitypriority = -1,
				range = 1100,
				reloadtime = 1,
				rgbcolor = "0.1 0.6 1",
				size = 8,
				sizedecay = 0,
				soundhit = "e16",
				soundstart = "bigraptorroar",
				tolerance = 50000,
				turret = true,
				tracks = true,
				turnrate = 30000,
				weapontimer = 0.2,
				weaponvelocity = 1000,
				weaponAcceleration = 100,
				startvelocity = 400,
				weapontype = "MissileLauncher",
				damage = {
					default = 1200,
				},
			},
   },
   weapons = {
[1] = {
				def = "GOO",
				onlytargetcategory = "ALL SPACENOTOBJECT",
				fastautoretargeting = true,
			},
   },
},
}

-- Command: tweakunits6
--NuttyB v1.52 Units Main
-- Authors: ChrispyNut, BackBash
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
{cortron={energycost=42000,metalcost=3600,buildtime=110000,health=12000,weapondefs={cortron_weapon={energypershot=51000,metalpershot=600,range=4050,damage={default=9000}}}},corfort={repairable=true},armfort={repairable=true},legforti={repairable=true},armgate={explodeas='empblast',selfdestructas='empblast'},corgate={explodeas='empblast',selfdestructas='empblast'},legdeflector={explodeas='empblast',selfdestructas='empblast'},corsat={sightdistance=3100,radardistance=4080,cruisealtitude=3300,energyupkeep=1250,category="OBJECT"},armsat={sightdistance=3100,radardistance=4080,cruisealtitude=3300,energyupkeep=1250,category="OBJECT"},legstarfall={weapondefs={starfire={energypershot=270000}}},armflak={airsightdistance=1350,energycost=30000,metalcost=1500,health=4000,weapondefs={armflak_gun={collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,areaofeffect=150,range=1150,reloadtime=0.475,weaponvelocity=2400,intensity=0.18}}},corflak={airsightdistance=1350,energycost=30000,metalcost=1500,health=4000,weapondefs={armflak_gun={collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,areaofeffect=200,range=1350,reloadtime=0.56,weaponvelocity=2100,intensity=0.18}}},legflak={footprintx=4,footprintz=4,airsightdistance=1350,energycost=35000,metalcost=2100,health=6000,weapondefs={legflak_gun={collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,areaofeffect=100,burst=3,range=1050,intensity=0.18}}},armmercury={airsightdistance=2200,weapondefs={arm_advsam={areaofeffect=500,energypershot=2000,explosiongenerator='custom:flak',flighttime=1.5,metalpershot=6,name='Mid-range, rapid-fire g2a guided missile launcher',range=2500,reloadtime=1.2,smoketrail=false,startvelocity=1500,weaponacceleration=1000,weaponvelocity=4000}}},corscreamer={airsightdistance=2800,weapondefs={cor_advsam={areaofeffect=800,energypershot=2000,explosiongenerator='custom:flak',flighttime=1,metalpershot=10,name='Long-range g2a guided heavy flak missile launcher',range=2800,reloadtime=1.8,smoketrail=false,startvelocity=4000,weaponacceleration=1000,weaponvelocity=8000}}},armassistdrone={buildoptions={[31]='armclaw'}},corassistdrone={buildoptions={[32]='cormaw'}},legassistdrone={buildoptions={[31]='legdtf',[32]='legdtl',[33]='legdtr'}},legfortt4={explodeas="fusionExplosionSelfd",selfdestructas="fusionExplosionSelfd"},legfort={explodeas="empblast",selfdestructas="empblast"},raptor_hive={weapondefs={antiground={burst=5,burstrate=0.01,cegtag='arty-heavy-purple',explosiongenerator='custom:dirt',model='Raptors/s_raptor_white.s3o',range=1600,reloadtime=5,rgbcolor='0.5 0 1',soundhit='smallraptorattack',soundstart='bugarty',sprayangle=256,turret=true,stockpiletime=12,proximitypriority='',damage={default=1,shields=100},customparams={spawns_count=15,spawns_expire=11,spawns_mode='random',spawns_name='raptor_acidspawnling raptor_hive_swarmer_basic raptor_land_swarmer_basic_t1_v1 ',spawns_surface='LAND SEA',stockpilelimit=10}}}},armapt3={buildoptions={[58]='armsat'}},corapt3={buildoptions={[58]='corsat'}},legapt3={buildoptions={[58]='corsat'}},armlwall={energycost=25000,metalcost=1300,weapondefs={lightning={energypershot=200,range=430}}},armclaw={collisionvolumeoffsets='0 -2 0',collisionvolumescales='30 51 30',collisionvolumetype='Ell',usepiececollisionvolumes=0,weapondefs={dclaw={energypershot=60}}},legdtl={weapondefs={dclaw={energypershot=60}}},armamd={metalcost=1800,energycost=41000,weapondefs={amd_rocket={coverage=2125,stockpiletime=70}}},corfmd={metalcost=1800,energycost=41000,weapondefs={fmd_rocket={coverage=2125,stockpiletime=70}}},legabm={metalcost=1800,energycost=41000,weapondefs={fmd_rocket={coverage=2125,stockpiletime=70}}},corwint2={metalcost=400},legwint2={metalcost=400},legdtr={buildtime=5250,energycost=5500,metalcost=400,collisionvolumeoffsets='0 -10 0',collisionvolumescales='39 88 39',collisionvolumetype='Ell',usepiececollisionvolumes=0,weapondefs={corlevlr_weapon={areaofeffect=30,avoidfriendly=true,collidefriendly=false,cegtag='railgun',range=650,energypershot=75,explosiongenerator='custom:plasmahit-sparkonly',rgbcolor='0.34 0.64 0.94',soundhit='mavgun3',soundhitwet='splshbig',soundstart='lancefire',weaponvelocity=1300,damage={default=550}}}},armrespawn={blocking=false,canresurrect=true},legnanotcbase={blocking=false,canresurrect=true},correspawn={blocking=false,canresurrect=true},legrwall={collisionvolumeoffsets="0 -3 0",collisionvolumescales="32 50 32",collisionvolumetype="CylY",energycost=21000,metalcost=1400,weapondefs={railgunt2={collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,range=725,reloadtime=3,energypershot=200,damage={default=1500}}},weapons={[1]={def="railgunt2",onlytargetcategory="SURFACE"}}},cormwall={energycost=18000,metalcost=1350,weapondefs={exp_heavyrocket={areaofeffect=70,collidefriendly=0,collidefeature=0,cameraShake=0,energypershot=125,avoidfeature=0,avoidfriendly=0,burst=1,burstrate=0,colormap='0.75 0.73 0.67 0.024   0.37 0.4 0.30 0.021   0.22 0.21 0.14 0.018  0.024 0.014 0.009 0.03   0.0 0.0 0.0 0.008',craterareaofeffect=0,explosiongenerator='custom:burnblack',flamegfxtime=1,flighttime=1.05,name='Raptor Boomer',reloadtime=1.5,rgbcolor='1 0.25 0.1',range=700,size=2,proximitypriority={},impactonly=1,trajectoryheight=1,targetmoveerror=0.2,tracks=true,weaponacceleration=660,weaponvelocity=950,damage={default=1050}}}},cormaw={collisionvolumeoffsets='0 -2 0',collisionvolumescales='30 51 30',collisionvolumetype='Ell',usepiececollisionvolumes=false,metalcost=350,energycost=2500,weapondefs={dmaw={collidefriendly=0,collidefeature=0,areaofeffect=80,edgeeffectiveness=0.45,energypershot=50,burst=24,rgbcolor='0.051 0.129 0.871',rgbcolor2='0.57 0.624 1',sizegrowth=0.80,range=450,intensity=0.68,damage={default=28}}}},legdtf={collisionvolumeoffsets='0 -24 0',collisionvolumescales='30 51 30',collisionvolumetype='Ell',metalcost=350,energycost=2750,weapondefs={dmaw={collidefriendly=0,collidefeature=0,areaofeffect=80,edgeeffectiveness=0.45,energypershot=50,burst=24,sizegrowth=2,range=450,intensity=0.38,sprayangle=500,damage={default=30}}}},corhllllt={collisionvolumeoffsets='0 -24 0',collisionvolumescales='30 51 30',metalcost=415,energycost=9500,buildtime=10000,health=2115},corhlt={energycost=5500,metalcost=520,weapondefs={cor_laserh1={range=750,reloadtime=0.95,damage={default=395,vtol=35}}}},armhlt={energycost=5700,metalcost=510,weapondefs={arm_laserh1={range=750,reloadtime=1,damage={default=405,vtol=35}}}},armbrtha={explodeas='fusionExplosion',energycost=500000,metalcost=18500,buildtime=175000,turnrate=16000,health=10450,weapondefs={ARMBRTHA_MAIN={areaofeffect=50,collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,beamtime=2.5,corethickness=0.1,craterareaofeffect=90,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.30,energypershot=14000,explosiongenerator='custom:laserhit-large-blue',firestarter=90,impulseboost=0,impulsefactor=0,largebeamlaser=true,laserflaresize=1,impactonly=1,name='Experimental Duction Beam',noselfdamage=true,range=2400,reloadtime=13,rgbcolor='0.4 0.2 0.6',scrollspeed=13,soundhitdry="",soundhitwet="sizzle",soundstart="hackshotxl3",soundtrigger=1,targetmoveerror=0.3,texture3='largebeam',thickness=14,tilelength=150,tolerance=10000,turret=true,turnrate=16000,weapontype='LaserCannon',weaponvelocity=3100,damage={commanders=480,default=34000}}},weapons={[1]={badtargetcategory='VTOL GROUNDSCOUT',def='ARMBRTHA_MAIN',onlytargetcategory='SURFACE'}}},corint={explodeas='fusionExplosion',energycost=505000,metalcost=19500,buildtime=170000,health=12450,footprintx=6,footprintz=6,weapondefs={CORINT_MAIN={areaofeffect=70,collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,beamtime=2.5,corethickness=0.1,craterareaofeffect=90,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.30,energypershot=17000,explosiongenerator='custom:laserhit-large-blue',firestarter=90,impulseboost=0,impulsefactor=0,largebeamlaser=true,laserflaresize=1,impactonly=1,name='Mini DeathStar',noselfdamage=true,range=2800,reloadtime=15,rgbcolor='0 1 0',scrollspeed=13,soundhitdry='',soundhitwet='sizzle',soundstart='annigun1',soundtrigger=1,targetmoveerror=0.3,texture3='largebeam',thickness=14,tilelength=150,tolerance=10000,turret=true,turnrate=1600,weapontype='LaserCannon',weaponvelocity=3100,damage={commanders=480,default=50000}}},weapons={[1]={badtargetcategory='VTOL GROUNDSCOUT',def='CORINT_MAIN',onlytargetcategory='SURFACE'}}},leglrpc={explodeas='fusionExplosion',energycost=555000,metalcost=21000,buildtime=150000,health=11000,footprintx=6,footprintz=6,weapondefs={LEGLRPC_MAIN={areaofeffect=70,collidefriendly=0,collidefeature=0,avoidfeature=0,avoidfriendly=0,beamtime=0.5,burst=3,burstrate=0.4,corethickness=0.1,craterareaofeffect=90,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.30,energypershot=10000,explosiongenerator='custom:laserhit-large-red',firestarter=90,impactonly=1,impulseboost=0,impulsefactor=0,largebeamlaser=true,laserflaresize=1,name='The Eagle Standard',noselfdamage=true,range=2150,reloadtime=3,rgbcolor='0/1/0.4',scrollspeed=13,soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw1',soundtrigger=1,targetmoveerror=0.3,texture3='largebeam',thickness=12,tilelength=150,tolerance=10000,turret=true,turnrate=16000,weapontype='LaserCannon',weaponvelocity=3100,damage={commanders=480,default=6000}}},weapons={[1]={badtargetcategory='VTOL GROUNDSCOUT',def='LEGLRPC_MAIN',onlytargetcategory='SURFACE'}}}}

-- Command: tweakdefs5
--NuttyB v1.52b Def Main
-- Authors: ChrispyNut, BackBash
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
local a,b,pairs,c=UnitDefs or{},'repulsor',pairs,table.merge;function addWeapon(d,e,f)a[d]=a[d]or{}a[d].weapons=a[d].weapons or{}a[d].weapondefs=a[d].weapondefs or{}a[d].customparams=a[d].customparams or{}table.insert(a[d].weapons,{def=b,onlytargetcategory=f or''})a[d].weapondefs[b]=e;if e.shield and e.shield.power>0 then e.range=e.shield.radius;a[d].customparams=c(a[d].customparams or{},{off_on_stun='true',shield_color_mult=0.8,shield_power=e.shield.power,shield_radius=e.shield.radius})end end;for g,h in ipairs({'armcom','armcomlvl2','armcomlvl3','armcomlvl4','corcom','corcomlvl2','corcomlvl3','corcomlvl4','legcom','legcomlvl2','legcomlvl3','legcomlvl4','legcomlvl5'})do addWeapon(h,{avoidfeature=false,craterareaofeffect=0,craterboost=0,cratermult=0,edgeeffectiveness=0.15,name='PlasmaRepulsor',range=50,soundhitwet='sizzle',weapontype='Shield',damage={default=100},shield={alpha=0.15,armortype='shields',energyuse=1,force=2.5,intercepttype=1,power=500,powerregen=3,powerregenenergy=3,radius=100,repulser=true,smart=true,startingpower=100,visiblerepulse=true,badcolor={1,0.2,0.2,0.2},goodcolor={0.2,1,0.2,0.17}}})end;for i,j in pairs(a)do if string.sub(i,1,24)=='raptor_air_fighter_basic'then if j.weapondefs then for g,k in pairs(j.weapondefs)do k.name='Spike'k.accuracy=200;k.collidefriendly=0;k.collidefeature=0;k.avoidfeature=0;k.avoidfriendly=0;k.areaofeffect=64;k.edgeeffectiveness=0.3;k.explosiongenerator='custom:raptorspike-large-sparks-burn'k.cameraShake={}k.dance={}k.interceptedbyshieldtype=0;k.model='Raptors/spike.s3o'k.reloadtime=1.1;k.soundstart='talonattack'k.startvelocity=200;k.submissile=1;k.smoketrail=0;k.smokePeriod={}k.smoketime={}k.smokesize={}k.smokecolor={}k.soundhit={}k.texture1={}k.texture2={}k.tolerance={}k.tracks=0;k.turnrate=60000;k.weaponacceleration=100;k.weapontimer=1;k.weaponvelocity=1000;k.weapontype={}k.wobble={}end end elseif i:match'^[acl][ore][rgm]com'and not i:match'_scav$'then table.mergeInPlace(j,{customparams={combatradius=0,fall_damage_multiplier=0,paratrooper=true,wtboostunittype={}},featuredefs={dead={damage=9999999,reclaimable=false,mass=9999999}}})end end;local l={raptor_air_kamikaze_basic_t2_v1={selfdestructas='raptor_empdeath_big'},raptor_land_swarmer_emp_t2_v1={weapondefs={raptorparalyzersmall={damage={shields=70},paralyzetime=6}}},raptor_land_assault_emp_t2_v1={weapondefs={raptorparalyzerbig={damage={shields=150},paralyzetime=10}}},raptor_allterrain_arty_emp_t2_v1={weapondefs={goolauncher={paralyzetime=6}}},raptor_allterrain_arty_emp_t4_v1={weapondefs={goolauncher={paralyzetime=10}}},raptor_air_bomber_emp_t2_v1={weapondefs={weapon={damage={shields=1100,default=2000},paralyzetime=10}}},raptor_allterrain_swarmer_emp_t2_v1={weapondefs={raptorparalyzersmall={damage={shields=70},paralyzetime=6}}},raptor_allterrain_assault_emp_t2_v1={weapondefs={raptorparalyzerbig={damage={shields=150},paralyzetime=6}}},raptor_matriarch_electric={weapondefs={goo={paralyzetime=13},melee={paralyzetime=13},spike_emp_blob={paralyzetime=13}}}}for m,n in pairs(l)do if a[m]then a[m]=c(a[m],n)end end;for g,o in pairs({'raptor_antinuke','raptor_turret_acid_t2_v1','raptor_turret_acid_t3_v1','raptor_turret_acid_t4_v1','raptor_turret_antiair_t2_v1','raptor_turret_antiair_t3_v1','raptor_turret_antiair_t4_v1','raptor_turret_antinuke_t2_v1','raptor_turret_antinuke_t3_v1','raptor_turret_basic_t2_v1','raptor_turret_basic_t3_v1','raptor_turret_basic_t4_v1','raptor_turret_burrow_t2_v1','raptor_turret_emp_t2_v1','raptor_turret_emp_t3_v1','raptor_turret_emp_t4_v1','raptor_worm_green'})do local p=a[o]p.maxthisunit=10;p.health=p.health*2;if p.weapondefs then for g,q in pairs(p.weapondefs)do q.reloadtime=q.reloadtime/1.5;q.range=q.range/2 end end end;for g,r in pairs(a)do if r.builder==true then if r.canfly==true then r.explodeas=''r.selfdestructas=''end end end;local s={'raptor_air_bomber_basic_t2_v1','raptor_air_bomber_basic_t2_v2','raptor_air_bomber_basic_t4_v1','raptor_air_bomber_basic_t4_v2','raptor_air_bomber_basic_t1_v1'}for g,t in pairs(s)do local j=a[t]if j.weapondefs then for g,u in pairs(j.weapondefs)do u.damage.default=u.damage.default/1.30 end end end;local v={'armrespawn','correspawn','legnanotcbase'}for g,i in ipairs(v)do local w=UnitDefs[i]if w then w.cantbetransported,w.footprintx,w.footprintz=false,4,4;w.customparams=w.customparams or{}w.customparams.paratrooper=true;w.customparams.fall_damage_multiplier=0 end end;local UnitDefs=UnitDefs or{}local function x(y)local z={}for A,B in pairs(y)do z[A]=type(B)=="table"and x(B)or B end;return z end;local function C(D,k)for A,B in pairs(k)do if type(B)=="table"then D[A]=D[A]or{}C(D[A],B)elseif D[A]==nil then D[A]=B end end end;local function E(F,G,H)if UnitDefs[F]and not UnitDefs[G]then local z=x(UnitDefs[F])C(z,H)UnitDefs[G]=z end end;local I={{"raptor_land_swarmer_basic_t1_v1","raptor_hive_swarmer_basic",{name="Hive Spawn",customparams={i18n_en_humanname="Hive Spawn",i18n_en_tooltip="Raptor spawned to defend hives from attackers."}}},{"raptor_land_assault_basic_t2_v1","raptor_hive_assault_basic",{name="Armored Assault Raptor",customparams={i18n_en_humanname="Armored Assault Raptor",i18n_en_tooltip="Heavy, slow, and unyielding—these beasts are made to take the hits others cant."}}},{"raptor_land_assault_basic_t4_v1","raptor_hive_assault_heavy",{name="Heavy Armored Assault Raptor",customparams={i18n_en_humanname="Heavy Armored Assault Raptor",i18n_en_tooltip="Lacking speed, these armored monsters make up for it with raw, unbreakable toughness."}}},{"raptor_land_assault_basic_t4_v2","raptor_hive_assault_superheavy",{name="Super Heavy Armored Assault Raptor",customparams={i18n_en_humanname="Super Heavy Armored Assault Raptor",i18n_en_tooltip="These super-heavy armored beasts may be slow, but they’re built to take a pounding and keep rolling."}}},{"raptorartillery","raptor_evolved_motort4",{name="Evolved Lobber",customparams={i18n_en_humanname="Evolved Lobber",i18n_en_tooltip="These lobbers did not just evolve—they became deadlier than anything before them."}}},{"raptor_land_swarmer_basic_t1_v1","raptor_acidspawnling",{name="Acid Spawnling",customparams={i18n_en_humanname="Acid Spawnling",i18n_en_tooltip="This critters are so cute but can be so deadly at the same time."}}}}for g,J in ipairs(I)do E(J[1],J[2],J[3])end;local K=UnitDef_Post;function UnitDef_Post(L,M)if K and K~=UnitDef_Post then K(L,M)end;local N=UnitDefs["raptor_land_swarmer_basic_t1_v1"]and UnitDefs["raptor_land_swarmer_basic_t1_v1"].health;local O={texture1={},texture2={},tracks=false,weaponvelocity=4000,smokePeriod={},smoketime={},smokesize={},smokecolor={},smoketrail=0}local P={accuracy=2048,areaofeffect=256,burst=4,burstrate=0.4,flighttime=12,dance=25,craterareaofeffect=256,edgeeffectiveness=0.7,cegtag="blob_trail_blue",explosiongenerator="custom:genericshellexplosion-huge-bomb",impulsefactor=0.4,intensity=0.3,interceptedbyshieldtype=1,range=2300,reloadtime=10,rgbcolor="0.2 0.5 0.9",size=8,sizedecay=0.09,soundhit="bombsmed2",soundstart="bugarty",sprayangle=2048,tolerance=60000,turnrate=6000,trajectoryheight=2,turret=true,weapontype="Cannon",weaponvelocity=520,startvelocity=140,weaponacceleration=125,weapontimer=0.2,wobble=14500,highTrajectory=1,damage={default=900,shields=600}}local Q={accuracy=1024,areaofeffect=24,burst=1,burstrate=0.3,cegtag="blob_trail_green",edgeeffectiveness=0.63,explosiongenerator="custom:raptorspike-small-sparks-burn",impulsefactor=1,intensity=0.4,interceptedbyshieldtype=1,name="Acid",range=250,reloadtime=1,rgbcolor="0.8 0.99 0.11",size=1,stages=6,soundhit="bloodsplash3",soundstart="alien_bombrel",sprayangle=128,tolerance=5000,turret=true,weapontimer=0.1,weapontype="Cannon",weaponvelocity=320,damage={default=80}}local R={raptor_hive_swarmer_basic={metalcost=350,nochasecategory="OBJECT",icontype="raptor_land_swarmer_basic_t1_v1"},raptor_hive_assault_basic={metalcost=3000,health=25000,speed=20.0,nochasecategory="OBJECT",icontype="raptor_land_assault_basic_t2_v1",weapondefs={aaweapon=O}},raptor_hive_assault_heavy={metalcost=6000,health=30000,speed=17.0,nochasecategory="OBJECT",icontype="raptor_land_assault_basic_t4_v1",weapondefs={aaweapon=O}},raptor_hive_assault_superheavy={metalcost=9000,health=35000,speed=16.0,nochasecategory="OBJECT",icontype="raptor_land_assault_basic_t4_v2",weapondefs={aaweapon=O}},raptor_evolved_motort4={icontype="raptor_allterrain_arty_basic_t4_v1",weapondefs={poopoo=P},weapons={[1]={badtargetcategory="MOBILE",def="poopoo",maindir="0 0 1",maxangledif=50,onlytargetcategory="NOTAIR"}}},raptor_acidspawnling={metalcost=375,energycost=600,health=N*2,icontype="raptor_land_swarmer_basic_t1_v1",buildpic="raptors/raptorh1b.DDS",objectname="Raptors/raptor_droneb.s3o",weapondefs={throwup=Q},weapons={[1]={def="throwup",onlytargetcategory="NOTAIR",maindir="0 0 1",maxangledif=180}}}}for i,S in pairs(R)do local j=UnitDefs[i]if j then for A,B in pairs(S)do if A=="weapondefs"then j.weapondefs=j.weapondefs or{}for T,U in pairs(B)do j.weapondefs[T]=j.weapondefs[T]or{}for V,W in pairs(U)do j.weapondefs[T][V]=W end end elseif A=="weapons"then j.weapons=B else j[A]=B end end end end end

-- Command: tweakdefs6
--T3 Cons & Taxed Factories
-- Authors: Nervensaege, TetrisCo (edited by RandomGuyJunior)
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
local a, b, c, d, e, f, g =
    UnitDefs or {},
    {"arm", "cor", "leg"},
    table.merge,
    {arm = "Armada ", cor = "Cortex ", leg = "Legion "},
    "_taxed",
    1.5,
    table.contains
local function h(i, j, k)
    if a[i] and not a[j] then
        a[j] = c(a[i], k)
    end
end
for l, m in pairs(b) do
    local n, o, p = m == "arm", m == "cor", m == "leg"
    h(
        m .. "nanotct2",
        m .. "nanotct3",
        {
            metalcost = 3700,
            energycost = 62000,
            builddistance = 550,
            buildtime = 108000,
            collisionvolumescales = "61 128 61",
            footprintx = 6,
            footprintz = 6,
            health = 8800,
            mass = 37200,
            sightdistance = 575,
            workertime = 1900,
            icontype = "armnanotct2",
            canrepeat = true,
            objectname = p and "Units/legnanotcbase.s3o" or o and "Units/CORRESPAWN.s3o" or "Units/ARMRESPAWN.s3o",
            customparams = {
                i18n_en_humanname = "T3 Construction Turret",
                i18n_en_tooltip = "More BUILDPOWER! For the connoisseur"
            }
        }
    )
    h(
        p and "legamstor" or m .. "uwadvms",
        p and "legamstort3" or m .. "uwadvmst3",
        {
            metalstorage = 30000,
            metalcost = 4200,
            energycost = 231150,
            buildtime = 142800,
            health = 53560,
            maxthisunit = 3,
            icontype = "armuwadves",
            name = d[m] .. "T3 Metal Storage",
            customparams = {
                i18n_en_humanname = "T3 Hardened Metal Storage",
                i18n_en_tooltip = "The big metal storage tank for your most precious resources. Chopped chicken!"
            }
        }
    )
    h(
        p and "legadvestore" or m .. "uwadves",
        p and "legadvestoret3" or m .. "advestoret3",
        {
            energystorage = 272000,
            metalcost = 2100,
            energycost = 59000,
            buildtime = 93380,
            health = 49140,
            icontype = "armuwadves",
            maxthisunit = 3,
            name = d[m] .. "T3 Energy Storage",
            customparams = {
                i18n_en_humanname = "T3 Hardened Energy Storage",
                i18n_en_tooltip = "Power! Power! We need power!1!"
            }
        }
    )
    for l, q in pairs({m .. "nanotc", m .. "nanotct2"}) do
        if a[q] then
            a[q].canrepeat = true
        end
    end
    local r = n and "armshltx" or o and "corgant" or "leggant"
    local s = a[r]
    h(
        r,
        r .. e,
        {
            energycost = s.energycost * f,
            icontype = r,
            metalcost = s.metalcost * f,
            name = d[m] .. "Experimental Gantry Taxed",
            customparams = {
                i18n_en_humanname = d[m] .. "Experimental Gantry Taxed",
                i18n_en_tooltip = "Produces Experimental Units"
            }
        }
    )
    local t, u = {},
        {
            m .. "afust3",
            m .. "nanotct2",
            m .. "nanotct3",
            m .. "alab",
            m .. "avp",
            m .. "aap",
            m .. "gatet3",
            m .. "flak",
            p and "legadveconvt3" or m .. "mmkrt3",
            p and "legamstort3" or m .. "uwadvmst3",
            p and "legadvestoret3" or m .. "advestoret3",
            p and "legdeflector" or m .. "gate",
            p and "legforti" or m .. "fort",
            n and "armshltx" or m .. "gant"
        }
    for l, v in ipairs(u) do
        t[#t + 1] = v
    end
    local w = {arm = {"corgant", "leggant"}, cor = {"armshltx", "leggant"}, leg = {"armshltx", "corgant"}}
    for l, x in ipairs(w[m] or {}) do
        t[#t + 1] = x .. e
    end
    local y = {
        arm = {
            "armamd",
            "armmercury",
            "armbrtha",
            "armminivulc",
            "armvulc",
            "armanni",
            "armannit3",
            "armlwall",
            "legendary_pulsar",
            "armnanotc3",
            "armspacet3",
        },
        cor = {
            "corfmd",
            "corscreamer",
            "cordoomt3",
            "corbuzz",
            "corminibuzz",
            "corint",
            "cordoom",
            "corhllllt",
            "cormwall",
            "legendary_bulwark",
            "cornanotc3",
            "corspacet3",
        },
        leg = {
            "legabm",
            "legstarfall",
            "legministarfall",
            "leglraa",
            "legbastion",
            "legrwall",
            "leglrpc",
            "legendary_bastion",
            "legapopupdef",
            "legdtf",
            "legnanotc3",
            "legspacet3",
        }
    }
    for l, v in ipairs(y[m] or {}) do
        t[#t + 1] = v
    end
    local j = m .. "t3aide"
    h(
        m .. "decom",
        j,
        {
            blocking = true,
            builddistance = 350,
            buildtime = 140000,
            energycost = 200000,
            energyupkeep = 2000,
            health = 10000,
            idleautoheal = 5,
            idletime = 1800,
            maxthisunit = 1,
            metalcost = 12600,
            speed = 85,
            terraformspeed = 3000,
            turninplaceanglelimit = 1.890,
            turnrate = 1240,
            workertime = 6000,
            reclaimable = true,
            candgun = false,
            name = d[m] .. "Epic Aide",
            customparams = {
                subfolder = "ArmBots/T3",
                techlevel = 3,
                unitgroup = "buildert3",
                i18n_en_humanname = "Epic Ground Construction Aide",
                i18n_en_tooltip = "Your Aide that helps you construct buildings"
            },
            buildoptions = t
        }
    )
    a[j].weapondefs = {}
    a[j].weapons = {}
    j = m .. "t3airaide"
    h(
        "armfify",
        j,
        {
            blocking = false,
            canassist = true,
            cruisealtitude = 3000,
            builddistance = 1750,
            buildtime = 140000,
            energycost = 200000,
            energyupkeep = 2000,
            health = 21100,
            idleautoheal = 5,
            idletime = 1800,
            icontype = "armnanotct2",
            maxthisunit = 1,
            metalcost = 13400,
            speed = 25,
            category = "SPACENOTOBJECT",
            terraformspeed = 3000,
            turninplaceanglelimit = 1.890,
            turnrate = 1240,
            workertime = 1600,
            buildpic = "ARMFIFY.DDS",
            name = d[m] .. "Epic Aide",
            customparams = {
                is_builder = true,
                subfolder = "ArmBots/T3",
                techlevel = 3,
                unitgroup = "buildert3",
                i18n_en_humanname = "Epic Orbital Construction Aide",
                i18n_en_tooltip = "Your Aide that helps you construct buildings"
            },
            buildoptions = t
        }
    )
    a[j].weapondefs = {}
    a[j].weapons = {}
    local z = n and "armshltx" or o and "corgant" or "leggant"
    if a[z] and a[z].buildoptions then
        local A = m .. "t3aide"
        if not g(a[z].buildoptions, A) then
            table.insert(a[z].buildoptions, A)
        end
    end
    z = m .. "apt3"
    if a[z] and a[z].buildoptions then
        local B = m .. "t3airaide"
        if not g(a[z].buildoptions, B) then
            table.insert(a[z].buildoptions, B)
        end
    end
end


-- Command: tweakdefs7
--NuttyB v1.52 1.5X HP
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
for unitName, unitDef in pairs(UnitDefs) do
    if string.sub(unitName, 1, 24) == "raptor_land_swarmer_heal" then
        unitDef.reclaimspeed = 100
        unitDef.stealth = false
        unitDef.builder = false
        unitDef.workertime = unitDef.workertime * 0.5
        unitDef.canassist = false
        unitDef.maxthisunit = 0
    end

    if unitDef.customparams and unitDef.customparams.subfolder == "other/raptors" and unitDef.health and not unitName:match('^raptor_queen_.*') then
        unitDef.health = unitDef.health * 1.5
        unitDef.sfxtypes = {}
        unitDef.explodas = unitDef.explodas
    end
end

local oldUnitDef_Post = UnitDef_Post
function UnitDef_Post(unitID, unitDef)
    if oldUnitDef_Post and oldUnitDef_Post ~= UnitDef_Post then
        oldUnitDef_Post(unitID, unitDef)
    end

    if unitDef.customparams and unitDef.customparams.subfolder == "other/raptors" then
        unitDef.nochasecategory = "OBJECT"
        if unitDef.metalcost and unitDef.health then
            unitDef.metalcost = math.floor(unitDef.health * 0.466666667)
        end
    end
end

-- Command: tweakdefs8
--NuttyB v1.52 1.5X QHP
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
for b, c in pairs(UnitDefs) do
	if b:match('^raptor_queen_.*') then
		c.repairable = 0
		c.canbehealed = 0
		c.buildtime = 9999999
		c.autoheal = 2
		c.canSelfRepair = 0
		c.health = c.health * 1.5
	end
end

-- Command: tweakunits7
--NuttyB v1.52c Legion Com
-- Authors: ChrispyNut, BackBash
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
{legcom={energymake=50,metalmake=5,health=6000,autoheal=40,buildoptions={'legrezbot','legdtl','legdtf','legdtr','legjam','legwin'},customparams={evolution_target='legcomlvl2',evolution_condition='timer_global',evolution_timer=420},weapondefs={legcomlaser={corethickness=0.25,duration=0.09,name='Light close-quarters g2g/g2a laser',range=360,reloadtime=0.20,rgbcolor='0 2 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw1',soundtrigger=true,sprayangle=700,thickness=6,texture1='shot',texture2='empty',weapontype='LaserCannon',weaponvelocity=2100,damage={default=250}},shotgun={areaofeffect=60,energypershot=0,avoidfeature=false,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.65,explosiongenerator='custom:genericshellexplosion-small',impulseboost=0.2,impulsefactor=0.2,intensity=3,name='6 Gauge Shotgun',noselfdamage=true,predictboost=1,projectiles=6,range=320,reloadtime=2,rgbcolor='1 0.75 0.25',size=2,soundhit='xplomed2xs',soundhitwet='splsmed',soundstart='kroggie2xs',soundstartvolume=12,sprayangle=2000,turret=true,commandfire=true,weapontimer=1,weapontype='Cannon',weaponvelocity=600,stockpile=true,stockpiletime=5,customparams={stockpilelimit=10},damage={default=1800,commanders=0}}},weapons={[3]={def='shotgun',onlytargetcategory='SURFACE'}}},legcomlvl2={energymake=150,metalmake=15,speed=57.5,autoheal=100,health=6700,customparams={evolution_condition='timer_global',evolution_timer=1020},buildoptions={'legrezbot','legadvsol','corhllt','leggeo','legnanotc','legjam','legdtf','legmg','legrad','legdtl','legdtr','legrhapsis','legwin'},weapondefs={legcomlaser={accuracy=50,areaofeffect=12,avoidfriendly=false,avoidfeature=false,collidefriendly=false,collidefeature=true,beamtime=0.09,corethickness=0.3,duration=0.09,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=500,reloadtime=0.2,rgbcolor='0 0.95 0.05',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw1',soundtrigger=true,sprayangle=500,targetmoveerror=0.05,thickness=7,tolerance=1000,texture1='shot',texture2='empty',turret=true,weapontype='LaserCannon',weaponvelocity=2200,damage={bombers=180,default=450,fighters=110,subs=5}},shotgun={areaofeffect=65,energypershot=0,avoidfeature=false,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.65,explosiongenerator='custom:genericshellexplosion-small',impulseboost=0.2,impulsefactor=0.2,intensity=3,name='12 Gauge Shotgun',noselfdamage=true,predictboost=1,projectiles=7,range=440,reloadtime=2,rgbcolor='1 0.75 0.25',size=2.5,soundhit='xplomed2xs',soundhitwet='splsmed',soundstart='kroggie2xs',soundstartvolume=12,sprayangle=2250,turret=true,commandfire=true,weapontimer=1,weapontype='Cannon',weaponvelocity=600,stockpile=true,stockpiletime=5,customparams={stockpilelimit=15},damage={default=2200,commanders=0}}},weapons={[1]={def='legcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='shotgun',onlytargetcategory='SURFACE'}}},legcomlvl3={energymake=1280,metalmake=40,speed=70.5,workertime=700,autoheal=150,health=7500,customparams={evolution_condition='timer_global',evolution_timer=1440},buildoptions={'legdeflector','legfus','legbombard','legadvestore','legmoho','legadveconv','legarad','legajam','legforti','legacluster','legamstor','legflak','legabm','legbastion','legdtr','legdtf','legrezbot','legdtl','leglab','legendary_bastion','legnanotct3','legapopupdef'},weapondefs={legcomlaser={accuracy=50,areaofeffect=12,avoidfriendly=true,avoidfeature=true,collidefriendly=false,collidefeature=true,beamtime=0.09,corethickness=0.55,duration=0.09,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=0,impulseboost=0,impulsefactor=0,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=640,reloadtime=0.2,rgbcolor='0 0.2 0.8',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw1',soundtrigger=true,sprayangle=500,targetmoveerror=0.05,thickness=7,tolerance=1000,texture1='shot',texture2='empty',turret=true,weapontype='LaserCannon',weaponvelocity=2500,damage={bombers=180,default=650,fighters=110,subs=5}},shotgun={areaofeffect=90,energypershot=0,avoidfeature=false,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.65,explosiongenerator='custom:genericshellexplosion-small',impulseboost=0.2,impulsefactor=0.2,intensity=3,name='12 Gauge Shotgun',noselfdamage=true,predictboost=1,projectiles=7,range=540,reloadtime=2,rgbcolor='1 0.75 0.25',size=2.5,soundhit='xplomed2xs',soundhitwet='splsmed',soundstart='kroggie2xs',soundstartvolume=12,sprayangle=2500,turret=true,commandfire=true,weapontimer=1,weapontype='Cannon',weaponvelocity=600,stockpile=true,stockpiletime=5,customparams={stockpilelimit=20},damage={default=3200,commanders=0}}},weapons={[1]={def='legcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='shotgun',onlytargetcategory='SURFACE'},[5]={def=''}}},legcomlvl4={energymake=1980,metalmake=46,speed=88.5,workertime=1000,autoheal=180,health=24500,customparams={evolution_condition='timer_global',evolution_timer=1740},buildoptions={'legdeflector','legfus','legbombard','legadvestore','legmoho','legadveconv','legeshotgunmech','legarad','legajam','legkeres','legacluster','legamstor','legflak','legabm','legbastion','legendary_bastion','legnanotct2','legnanotct2plat','legrwall','leglab','legtarg','legsd','legpede','legerailtank','legeheatraymech','legrezbot','legafus','leglraa','legdtl','legdtf','legministarfall','legstarfall','leggatet3','legperdition','legsilo','legsrailt4','legelrpcmech','legdtr','legnanotct3','legapopupdef'},weapondefs={legcomlaser={accuracy=50,areaofeffect=12,avoidfriendly=true,avoidfeature=true,collidefriendly=false,collidefeature=true,beamtime=0.1,corethickness=.5,duration=0.09,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=0,impulseboost=0,impulsefactor=0,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=900,reloadtime=0.1,rgbcolor='0.45 0 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw1',soundtrigger=1,sprayangle=400,targetmoveerror=0.05,thickness=6,tolerance=1000,texture1='shot',texture2='empty',turret=true,weapontype='LaserCannon',weaponvelocity=3000,damage={bombers=180,default=1750,fighters=110,subs=5}},shotgun={areaofeffect=75,energypershot=0,avoidfeature=false,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.65,explosiongenerator='custom:genericshellexplosion-small',impulseboost=0.2,impulsefactor=0.2,intensity=3,name='60 Gauge Raptor Popper',noselfdamage=true,predictboost=1,projectiles=9,range=550,reloadtime=1,rgbcolor='1 0.75 0.25',size=5,soundhit='xplomed2xs',soundhitwet='splsmed',soundstart='kroggie2xs',soundstartvolume=12,sprayangle=3000,turret=true,commandfire=true,weapontimer=1,weapontype='Cannon',weaponvelocity=600,stockpile=true,stockpiletime=4,customparams={stockpilelimit=20},damage={default=4400,commanders=0}}},weapons={[1]={def='legcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='shotgun',onlytargetcategory='SURFACE'},[5]={def=''}}},legcomlvl5={energymake=2280,metalmake=64,speed=100,workertime=1700,autoheal=4500,health=53900,buildoptions={'legdeflector','legfus','legbombard','legadvestore','legmoho','legadveconv','legeshotgunmech','legarad','legajam','legkeres','legacluster','legamstor','legflak','legabm','legbastion','legendary_bastion','legnanotct2','legnanotct2plat','legrwall','leglab','legtarg','legsd','legpede','legerailtank','legeheatraymech','legrezbot','legafus','leglraa','legdtl','legdtf','legministarfall','legstarfall','leggatet3','legperdition','legsilo','legsrailt4','legelrpcmech','legdtr','legnanotct3','legapopupdef'},weapondefs={machinegun={accuracy=80,areaofeffect=10,avoidfeature=false,beamburst=true,beamdecay=1,beamtime=0.07,burst=6,burstrate=0.10667,camerashake=0,corethickness=0.35,craterareaofeffect=0,craterboost=0,cratermult=0,edgeeffectiveness=1,explosiongenerator="custom:laserhit-medium-red",firestarter=10,impulsefactor=0,largebeamlaser=true,laserflaresize=30,name="Rapid-fire close quarters g2g armor-piercing laser",noselfdamage=true,pulsespeed=q8,range=1100,reloadtime=0.50,rgbcolor="0.7 0.3 1.0",rgbcolor2="0.8 0.6 1.0",soundhitdry="",soundhitwet="sizzle",soundstart="lasfirerc",soundtrigger=1,sprayangle=500,targetborder=0.2,thickness=5.5,tolerance=4500,turret=true,weapontype="BeamLaser",weaponvelocity=920,damage={default=1300,vtol=180}},shotgunarm={areaofeffect=112,commandfire=true,avoidfeature=false,craterboost=0,cratermult=0,cameraShake=0,edgeeffectiveness=0.65,explosiongenerator="custom:genericshellexplosion-medium",impulsefactor=0.8,intensity=0.2,mygravity=1,name="GaussCannon",noselfdamage=true,predictboost=1,projectiles=20,range=650,reloadtime=1,rgbcolor="0.8 0.4 1.0",size=4,sizeDecay=0.044,stages=16,alphaDecay=0.66,soundhit="xplomed2xs",soundhitwet="splsmed",soundstart="kroggie2xs",sprayangle=3500,tolerance=6000,turret=true,waterweapon=true,weapontimer=2,weapontype="Cannon",weaponvelocity=900,stockpile=true,stockpiletime=2,customparams={stockpilelimit=50},damage={default=10000,commanders=0}},exp_heavyrocket={areaofeffect=70,collidefriendly=0,collidefeature=0,cameraShake=0,energypershot=125,avoidfeature=0,avoidfriendly=0,burst=4,burstrate=0.3,cegtag="missiletrailsmall-red",colormap='0.75 0.73 0.67 0.024   0.37 0.4 0.30 0.021   0.22 0.21 0.14 0.018  0.024 0.014 0.009 0.03   0.0 0.0 0.0 0.008',craterboost=0,craterareaofeffect=0,cratermult=0,dance=24,edgeeffectiveness=0.65,explosiongenerator="custom:burnblack",firestarter=70,flighttime=1.05,flamegfxtime=1,impulsefactor=0.123,impactonly=1,model="catapultmissile.s3o",movingaccuracy=600,name="Raptor Boomer",noselfdamage=true,proximitypriority={},range=700,reloadtime=1,smoketrail=true,smokePeriod=4,smoketime=16,smokesize=8.5,smokecolor=0.5,size=2,smokeTrailCastShadow=false,soundhit="rockhit",soundhitwet="splsmed",soundstart="rapidrocket3",startvelocity=165,rgbcolor='1 0.25 0.1',texture1="null",texture2="smoketrailbar",trajectoryheight=1,targetmoveerror=0.2,turnrate=5000,tracks=true,turret=true,allowNonBlockingAim=true,weaponacceleration=660,weapontimer=6,weapontype="MissileLauncher",weaponvelocity=950,wobble=2000,damage={default=1300},customparams={exclude_preaim=true,overrange_distance=777,projectile_destruction_method="descend"}}},weapons={[1]={def='machinegun',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='shotgunarm',onlytargetcategory='WEAPON'},[5]={def='exp_heavyrocket',onlytargetcategory='SURFACE'}}}}

-- Command: tweakunits8
--NuttyB v1.52c Armada Com
-- Authors: ChrispyNut, BackBash
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
{armcom={customparams={evolution_target='armcomlvl2',evolution_condition='timer_global',evolution_timer=420},energymake=100,metalmake=10,autoheal=55,health=4500,speed=41,canresurrect=true,buildoptions={'armsolar','armwin','armmstor','armestor','armmex','armmakr','armlab','armvp','armap','armeyes','armrad','armdrag','armllt','armrl','armdl','armtide','armuwms','armuwes','armuwmex','armfmkr','armsy','armfdrag','armtl','armfrt','armfrad','armhp','armfhp','armgeo','armamex','armhp','armbeamer','armjamt','armsy','armrectr','armclaw'},weapondefs={armcomlaser={range=330,rgbcolor='0.7 1 1',soundstart='lasrfir1',damage={default=175}},old_armsnipe_weapon={areaofeffect=32,avoidfeature=true,avoidfriendly=true,collidefeature=true,collidefriendly=false,corethickness=0.75,craterareaofeffect=0,craterboost=0,commandfire=true,cratermult=0,cegtag='railgun',duration=0.12,edgeeffectiveness=0.85,energypershot=400,explosiongenerator='custom:laserhit-large-blue',firestarter=100,impulseboost=0.4,impulsefactor=1,intensity=0.8,name='Long-range g2g armor-piercing rifle',range=550,reloadtime=1,rgbcolor='0 1 1',rgbcolor2='0 1 1',soundhit='sniperhit',soundhitwet='sizzle',soundstart='sniper3',soundtrigger=true,stockpile=true,stockpiletime=7,customparams={stockpilelimit=5},texture1='shot',texture2='empty',thickness=4,tolerance=1000,turret=true,weapontype='LaserCannon',weaponvelocity=3000,damage={commanders=100,default=4900}}},weapons={[3]={def='old_armsnipe_weapon',onlytargetcategory='NOTSUB'}}},armcomlvl2={autoheal=90,builddistance=175,canresurrect=true,energymake=315,health=7000,speed=57.5,metalmake=20,workertime=900,buildoptions={'armsolar','armwin','armmstor','armestor','armmex','armmakr','armlab','armvp','armap','armeyes','armrad','armdrag','armllt','armrl','armdl','armtide','armuwms','armuwes','armuwmex','armfmkr','armsy','armfdrag','armtl','armfrt','armfrad','armhp','armfhp','armadvsol','armgeo','armamex','armnanotcplat','armhp','armnanotc','armclaw','armbeamer','armhlt','armguard','armferret','armcir','armjamt','armjuno','armsy','armrectr'},customparams={evolution_target='armcomlvl3',evolution_condition='timer_global',evolution_timer=1320},weapondefs={armcomlaser={areaofeffect=16,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=7.7,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=425,reloadtime=0.7,rgbcolor='0 1 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrfir1',soundtrigger=1,targetmoveerror=0.05,thickness=4,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={default=950,VTOL=150}},old_armsnipe_weapon={areaofeffect=42,avoidfeature=true,avoidfriendly=true,collidefeature=true,collidefriendly=false,corethickness=0.75,craterareaofeffect=0,craterboost=0,commandfire=true,cratermult=0,cegtag='railgun',duration=0.12,edgeeffectiveness=0.85,energypershot=700,explosiongenerator='custom:laserhit-large-blue',firestarter=100,impulseboost=0.4,impulsefactor=1,intensity=1,name='Long-range g2g armor-piercing rifle',range=700,reloadtime=1,rgbcolor='0.2 0.1 1',rgbcolor2='0.2 0.1 1',soundhit='sniperhit',soundhitwet='sizzle',soundstart='sniper3',soundtrigger=true,stockpile=true,stockpiletime=6,customparams={stockpilelimit=10},texture1='shot',texture2='empty',thickness=4,tolerance=1000,turret=true,weapontype='LaserCannon',weaponvelocity=3000,damage={commanders=10,default=11000}}},weapons={[1]={def='armcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='old_armsnipe_weapon',onlytargetcategory='NOTSUB'}}},armcomlvl3={autoheal=50,builddistance=250,canresurrect=true,energymake=2712,health=10000,speed=71.5,metalmake=62,workertime=1500,buildoptions={'armanni','armpb','armamb','armmoho','armuwmme','armflak','armmercury','armgate','armsd','armfort','armtarg','armarad','armamd','armveil','armuwadvms','armuwadves','armmmkr','armclaw','armjuno','armuwmex','armhp','armsy','armfdrag','armtl','armfrt','armfrad','armhp','armlab','armvp','armap','armsy','armuwmmm','armuwfus','armplat','armfdrag','armfhlt','armfflak','armatl','armkraken','armnanotcplat','armbrtha','armannit3','armlwall','armnanotct2','armafus','armfus','armckfus','armraz','armzeus','armsnipe','armvang','armrectr','armgatet3','legendary_pulsar','armnanotct3'},customparams={evolution_target='armcomlvl4',evolution_condition='timer_global',evolution_timer=1740},weapondefs={old_armsnipe_weapon={areaofeffect=64,avoidfeature=true,avoidfriendly=true,collidefeature=true,collidefriendly=false,corethickness=0.75,craterareaofeffect=0,craterboost=0,commandfire=true,cratermult=0,cegtag='railgun',duration=0.12,edgeeffectiveness=1,energypershot=2000,explosiongenerator='custom:laserhit-large-blue',firestarter=100,impulseboost=0.4,impulsefactor=1,intensity=1.4,name='Long-range g2g armor-piercing rifle',range=1250,reloadtime=.5,rgbcolor='0.4 0.1 0.7',rgbcolor2='0.4 0.1 0.7',soundhit='sniperhit',soundhitwet='sizzle',soundstart='sniper3',soundtrigger=true,stockpile=true,stockpiletime=3,customparams={stockpilelimit=10},texture1='shot',texture2='empty',thickness=6,tolerance=1000,turret=true,weapontype='LaserCannon',weaponvelocity=3000,damage={commanders=10,default=35000}},armcomlaser={areaofeffect=12,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=7.7,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=500,reloadtime=0.6,rgbcolor='0.1 0 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw2',soundtrigger=1,targetmoveerror=0.05,thickness=6,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={default=1450,VTOL=180}}},weapons={[5]={badtargetcategory='MOBILE',def='armcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='old_armsnipe_weapon',onlytargetcategory='NOTSUB'},[4]={def=''},[1]={def=''},[6]={def=''}}},armcomlvl4={autoheal=150,builddistance=300,canresurrect=true,energymake=3112,health=20000,speed=82,metalmake=86,workertime=2000,buildoptions={'armanni','armpb','armamb','armmoho','armuwmme','armflak','armmercury','armgate','armsd','armfort','armtarg','armarad','armamd','armveil','armuwadvms','armuwadves','armmmkr','armclaw','armjuno','armuwmex','armhp','armsy','armfdrag','armtl','armfrt','armfrad','armhp','armlab','armvp','armap','armsy','armuwmmm','armuwfus','armplat','armfdrag','armfhlt','armfflak','armatl','armkraken','armnanotcplat','armbrtha','armannit3','armlwall','armnanotct2','armafus','armfus','armckfus','armraz','armzeus','armsnipe','armvang','armrectr','armgatet3','legendary_pulsar','armnanotct3'},weapondefs={old_armsnipe_weapon={areaofeffect=72,avoidfeature=true,avoidfriendly=true,collidefeature=true,collidefriendly=false,corethickness=0.75,craterareaofeffect=0,craterboost=0,commandfire=true,cratermult=0,cegtag='railgun',duration=0.12,edgeeffectiveness=1,energypershot=2000,explosiongenerator='custom:laserhit-large-blue',firestarter=100,impulseboost=0.4,impulsefactor=1,intensity=1.4,name='Long-range g2g armor-piercing rifle',range=1250,reloadtime=.5,rgbcolor='0.4 0.1 0.7',rgbcolor2='0.4 0.1 0.7',soundhit='sniperhit',soundhitwet='sizzle',soundstart='sniper3',soundtrigger=true,stockpile=true,stockpiletime=2,customparams={stockpilelimit=15},texture1='shot',texture2='empty',thickness=6,tolerance=1000,turret=true,weapontype='LaserCannon',weaponvelocity=3000,damage={commanders=10,default=45000}},ata={areaofeffect=16,avoidfeature=false,beamtime=1.25,collidefriendly=false,corethickness=0.5,craterareaofeffect=0,craterboost=0,cratermult=0,edgeeffectiveness=0.30,energypershot=7000,explosiongenerator='custom:laserhit-large-blue',firestarter=90,impulsefactor=0,largebeamlaser=true,laserflaresize=7,name='Heavy long-range g2g tachyon accelerator beam',noselfdamage=true,range=1100,reloadtime=15,rgbcolor='1 0 1',scrollspeed=5,soundhitdry='',soundhitwet='sizzle',soundstart='annigun1',soundtrigger=1,texture3='largebeam',thickness=10,tilelength=150,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=3100,damage={commanders=480,default=48000}},armcomlaser={areaofeffect=12,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=7.7,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=550,reloadtime=0.5,rgbcolor='0.659 0 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrcrw2',soundtrigger=1,targetmoveerror=0.05,thickness=6,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={default=1750,VTOL=200}}},weapons={[1]={def='armcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='old_armsnipe_weapon',onlytargetcategory='NOTSUB'},[4]={badtargetcategory='VTOL GROUNDSCOUT',def='ATA',onlytargetcategory='SURFACE'},[5]={def=''},[6]={def=''}}}}

-- Command: tweakunits9
--NuttyB v1.52c Cortex Com
-- Authors: ChrispyNut, BackBash
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
{corcom={customparams={evolution_target='corcomlvl2',evolution_condition='timer_global',evolution_timer=420},autoheal=80,speed=45,energymake=75,metalmake=6,health=5500,buildoptions={[28]='corhllt',[29]='cornecro',[30]='corlevlr',[31]='corak',[32]='cormaw'},weapondefs={corcomlaser={range=370,damage={bombers=180,default=260,fighters=110,subs=5}},disintegrator={energypershot=1000,reloadtime=8}}},corcomlvl2={speed=62,health=8500,energymake=255,metalmake=16,autoheal=300,builddistance=200,workertime=600,buildoptions={[1]='corsolar',[2]='coradvsol',[3]='corwin',[4]='corgeo',[5]='cormstor',[6]='corestor',[7]='cormex',[8]='corexp',[9]='cormakr',[10]='corcan',[11]='correap',[12]='corlab',[13]='corvp',[14]='corap',[15]='corhp',[16]='cornanotc',[17]='coreyes',[18]='corrad',[19]='cordrag',[20]='cormaw',[21]='corllt',[22]='corhllt',[23]='corhlt',[24]='corpun',[25]='corrl',[26]='cormadsam',[27]='corerad',[28]='cordl',[29]='corjamt',[30]='corjuno',[31]='corsy',[32]='coruwgeo',[33]='corfasp',[34]='cornerco',[35]='coruwes',[36]='corplat',[37]='corfhp',[38]='coruwms',[39]='corfhlt',[40]='cornanotcplat',[41]='corfmkr',[42]='cortide',[43]='corfrad',[44]='corfrt',[45]='corfdrag',[46]='cortl',[47]='cornecro'},customparams={evolution_target='corcomlvl3',evolution_condition='timer_global',evolution_timer=1320,shield_power=500,shield_radius=100},weapondefs={armcomlaser={areaofeffect=16,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=7.7,name='Light close-quarters g2g/g2a laser',noselfdamage=true,range=500,reloadtime=0.4,rgbcolor='0.6 0.3 0.8',soundhitdry='',soundhitwet='sizzle',soundstart='lasrfir1',soundtrigger=1,targetmoveerror=0.05,thickness=4,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={bombers=180,default=1500,fighters=110,subs=5}},disintegrator={areaofeffect=36,avoidfeature=false,avoidfriendly=false,avoidground=false,bouncerebound=0,cegtag='dgunprojectile',commandfire=true,craterboost=0,cratermult=0.15,edgeeffectiveness=0.15,energypershot=500,explosiongenerator='custom:expldgun',firestarter=100,firesubmersed=false,groundbounce=true,impulseboost=0,impulsefactor=0,name='Disintegrator',noexplode=true,noselfdamage=true,range=250,reloadtime=6,paralyzer={},soundhit='xplomas2s',soundhitwet='sizzlexs',soundstart='disigun1',soundhitvolume=36,soundstartvolume=96,soundtrigger=true,tolerance=10000,turret=true,waterweapon=true,weapontimer=4.2,weapontype='DGun',weaponvelocity=300,damage={commanders=0,default=20000,raptors=10000}}},weapons={[1]={def='armcomlaser',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={def='DISINTEGRATOR',onlytargetcategory='NOTSUB'}}},corcomlvl3={speed=80,health=30000,energymake=2180,metalmake=49,autoheal=1500,workertime=1200,builddistance=250,buildoptions={[1]='corfus',[2]='corafus',[3]='corageo',[4]='corbhmth',[5]='cormoho',[6]='cormexp',[7]='cormmkr',[8]='coruwadves',[9]='coruwadvms',[10]='corarad',[11]='corshroud',[12]='corfort',[13]='corlab',[14]='cortarg',[15]='corsd',[16]='corgate',[17]='cortoast',[18]='corvipe',[19]='cordoom',[20]='corflak',[21]='corscreamer',[22]='corvp',[23]='corfmd',[24]='corap',[25]='corint',[26]='corplat',[27]='corsy',[28]='coruwmme',[29]='coruwmmm',[30]='corenaa',[31]='corfdoom',[32]='coratl',[33]='coruwfus',[34]='corjugg',[35]='corshiva',[36]='corsumo',[37]='corgol',[38]='corkorg',[39]='cornanotc2plat',[40]='cornanotct2',[41]='cornecro',[42]='cordoomt3',[43]='corhllllt',[44]='cormaw',[45]='cormwall',[46]='corgatet3',[47]='legendary_bulwark',[48]='cornanotct3'},customparams={evolution_target='corcomlvl4',evolution_condition='timer_global',evolution_timer=1740},weapondefs={corcomlaser={areaofeffect=12,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=5.5,name='J7Laser',noselfdamage=true,range=900,reloadtime=0.4,rgbcolor='0.7 0 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrfir1',soundtrigger=1,targetmoveerror=0.05,thickness=3,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={default=2000,subs=5}},disintegrator={areaofeffect=36,avoidfeature=false,avoidfriendly=false,avoidground=false,bouncerebound=0,cegtag='dgunprojectile',commandfire=true,craterboost=0,cratermult=0.15,edgeeffectiveness=0.15,energypershot=500,explosiongenerator='custom:expldgun',firestarter=100,firesubmersed=false,groundbounce=true,impulseboost=0,impulsefactor=0,name='Disintegrator',noexplode=true,noselfdamage=true,range=250,reloadtime=3,paralyzer={},soundhit='xplomas2s',soundhitwet='sizzlexs',soundstart='disigun1',soundhitvolume=36,soundstartvolume=96,soundtrigger=true,size=4,tolerance=10000,turret=true,waterweapon=true,weapontimer=4.2,weapontype='DGun',weaponvelocity=300,damage={commanders=0,default=20000,scavboss=1000,raptors=10000}}},weapons={[1]={def='CORCOMLASER',onlytargetcategory='NOTSUB',fastautoretargeting=true},[5]={def=''}}},corcomlvl4={speed=80,health=50000,energymake=2380,metalmake=56,autoheal=3550,workertime=1800,builddistance=300,buildoptions={[1]='corfus',[2]='corafus',[3]='corageo',[4]='corbhmth',[5]='cormoho',[6]='cormexp',[7]='cormmkr',[8]='coruwadves',[9]='coruwadvms',[10]='corarad',[11]='corshroud',[12]='corfort',[13]='corlab',[14]='cortarg',[15]='corsd',[16]='corgate',[17]='cortoast',[18]='corvipe',[19]='cordoom',[20]='corflak',[21]='corscreamer',[22]='corvp',[23]='corfmd',[24]='corap',[25]='corint',[26]='corplat',[27]='corsy',[28]='coruwmme',[29]='coruwmmm',[30]='corenaa',[31]='corfdoom',[32]='coratl',[33]='coruwfus',[34]='corjugg',[35]='corshiva',[36]='corsumo',[37]='corgol',[38]='corkorg',[39]='cornanotc2plat',[40]='cornanotct2',[41]='cornecro',[42]='cordoomt3',[43]='corhllllt',[44]='cormaw',[45]='cormwall',[46]='corgatet3',[47]='legendary_bulwark',[48]='cornanotct3'},customparams={shield_power=500,shield_radius=100},weapondefs={CORCOMLASER={areaofeffect=12,avoidfeature=false,beamtime=0.1,corethickness=0.1,craterareaofeffect=0,craterboost=0,cratermult=0,cylindertargeting=1,edgeeffectiveness=1,explosiongenerator='custom:laserhit-small-red',firestarter=70,impactonly=1,impulseboost=0,impulsefactor=0,laserflaresize=5.5,name='J7Laser',noselfdamage=true,range=1000,reloadtime=0.4,rgbcolor='0.7 0 1',soundhitdry='',soundhitwet='sizzle',soundstart='lasrfir1',soundtrigger=1,targetmoveerror=0.05,thickness=3,tolerance=10000,turret=true,weapontype='BeamLaser',weaponvelocity=900,damage={default=2500,subs=5}},disintegratorxl={areaofeffect=105,avoidfeature=false,avoidfriendly=true,avoidground=false,burst=1,burstrate=0,bouncerebound=0,cegtag='gausscannonprojectilexl',craterareaofeffect=0,craterboost=0,cratermult=0,commandfire=true,cameraShake=0,edgeeffectiveness=1,energypershot=0,explosiongenerator='custom:burnblackbiggest',firestarter=100,firesubmersed=false,gravityaffected=true,impulsefactor=0,intensity=4,name='Darkmatter Photon-Disruptor',noexplode=true,noselfdamage=true,range=500,reloadtime=1,rgbcolor='0.7 0.3 1.0',size=5.5,soundhit='xplomas2',soundhitwet='sizzlexs',soundstart='disigun1',soundtrigger=true,tolerance=10000,turret=true,weapontimer=4.2,weapontype='DGun',weaponvelocity=505,damage={commanders=0,default=20000,scavboss=1000,raptors=10000}},corcomeyelaser={allowNonBlockingAim=true,avoidfriendly=true,areaofeffect=6,avoidfeature=false,beamtime=0.033,camerashake=0.1,collidefriendly=false,corethickness=0.35,craterareaofeffect=12,craterboost=0,cratermult=0,edgeeffectiveness=1,energypershot=0,explosiongenerator='custom:laserhit-small-red',firestarter=90,firetolerance=300,impulsefactor=0,laserflaresize=2,name='EyeLaser',noselfdamage=true,proximitypriority=1,range=870,reloadtime=0.033,rgbcolor='0 1 0',rgbcolor2='0.8 0 0',scrollspeed=5,soundhitdry='flamhit1',soundhitwet='sizzle',soundstart='heatray3burn',soundstartvolume=6,soundtrigger=1,thickness=2.5,turret=true,weapontype='BeamLaser',weaponvelocity=1500,damage={default=185}}},weapons={[1]={def='CORCOMLASER',onlytargetcategory='NOTSUB',fastautoretargeting=true},[3]={badtargetcategory='VTOL',def='disintegratorxl',onlytargetcategory='SURFACE'},[6]={def=''},[5]={badtargetcategory='VTOL GROUNDSCOUT',def='corcomeyelaser',onlytargetcategory='SURFACE'}}}}

-- Command: tweakdefs9
--Mini Bosses v2e
-- Authors: RCore
-- docs.google.com/spreadsheets/d/1QSVsuAAMhBrhiZdTihVfSCwPzbbZWDLCtXWP23CU0ko
local a,b,c,d,e,f=UnitDefs or{},table.merge,table.copy,'raptor_matriarch_basic','customfusionexplo',Spring;local g,h=1.3,1.3;h=a[d].health/60000;g=a['raptor_queen_epic'].health/1250000;local i=1;if f.Utilities.Gametype.IsRaptors()then i=(#f.GetTeamList()-2)/12 end;local j=f.GetModOptions().raptor_spawncountmult or 3;local k=i*j/3;local function l(m)return math.max(1,math.ceil(m*k))end;local n={70,85,90,105,110,125}local o=math.max(1,f.GetModOptions().raptor_queentimemult or 1.3)local p,q=n[1],n[#n]local r=o*n[#n]/1.3;local s=(r-p)/(q-p)for t=2,#n do n[t]=math.floor(p+(n[t]-p)*s)end;local u=f.GetModOptions().raptor_queen_count or 1;local v=1;if g>1.3 then v=math.min(10,g/1.3*0.9)end;local w=math.ceil(v*10*1.06^math.max(0,u-8))local x=o*100+w;local y=math.max(3,l(math.floor((21*u+36)/19)))local function z(A,B,C)if a[A]and not a[B]then a[B]=b(a[A],C or{})end end;local D=a[d].health;z('raptor_queen_veryeasy','raptor_miniq_a',{name='Queenling Prima',icontype='raptor_queen_veryeasy',health=D*5,customparams={i18n_en_humanname='Queenling Prima',i18n_en_tooltip='Majestic and bold, ruler of the hunt.'}})z('raptor_queen_easy','raptor_miniq_b',{name='Queenling Secunda',icontype='raptor_queen_easy',health=D*6,customparams={i18n_en_humanname='Queenling Secunda',i18n_en_tooltip='Swift and sharp, a noble among raptors.'}})z('raptor_queen_normal','raptor_miniq_c',{name='Queenling Tertia',icontype='raptor_queen_normal',health=D*7,customparams={i18n_en_humanname='Queenling Tertia',i18n_en_tooltip='Refined tastes. Likes her prey rare.'}})a.raptor_miniq_b.weapondefs.acidgoo=c(a['raptor_matriarch_acid'].weapondefs.acidgoo)a.raptor_miniq_c.weapondefs.empgoo=c(a['raptor_matriarch_electric'].weapondefs.goo)for E,F in ipairs{{'raptor_matriarch_basic','raptor_mama_ba','Matrona','Claws charged with vengeance.'},{'raptor_matriarch_fire','raptor_mama_fi','Pyro Matrona','A firestorm of maternal wrath.'},{'raptor_matriarch_electric','raptor_mama_el','Paralyzing Matrona','Crackling with rage, ready to strike.'},{'raptor_matriarch_acid','raptor_mama_ac','Acid Matrona','Acid-fueled, melting everything in sight.'}}do z(F[1],F[2],{name=F[3],icontype=F[1],health=D*1.5,customparams={i18n_en_humanname=F[3],i18n_en_tooltip=F[4]}})end;z('critter_penguinking','raptor_consort',{name='Raptor Consort',icontype='corkorg',health=D*4,mass=100000,nochasecategory="MOBILE VTOL OBJECT",sonarstealth=false,stealth=false,speed=67.5,customparams={i18n_en_humanname='Raptor Consort',i18n_en_tooltip='Sneaky powerful little terror.'}})a.raptor_consort.weapondefs.goo=c(a['raptor_queen_epic'].weapondefs.goo)z('raptor_consort','raptor_doombringer',{name='Doombringer',icontype='armafust3',health=D*12,speed=50,customparams={i18n_en_humanname='Doombringer',i18n_en_tooltip='Your time is up. The Queens called for backup.'}})local function G(H,I,J,K,L,M)return{raptorcustomsquad=true,raptorsquadunitsamount=L or 1,raptorsquadminanger=H,raptorsquadmaxanger=I,raptorsquadweight=M or 5,raptorsquadrarity=K or'basic',raptorsquadbehavior=J,raptorsquadbehaviordistance=500,raptorsquadbehaviorchance=0.75}end;local N={selfdestructas=e,explodeas=e,weapondefs={yellow_missile={damage={default=1,vtol=1000}}}}for O,P in pairs{raptor_miniq_a=b(N,{maxthisunit=l(2),customparams=G(n[1],n[2],'berserk'),weapondefs={goo={damage={default=750}},melee={damage={default=4000}}}}),raptor_miniq_b=b(N,{maxthisunit=l(3),customparams=G(n[3],n[4],'berserk'),weapondefs={acidgoo={burst=8,reloadtime=10,sprayangle=4096,damage={default=1500,shields=1500}},melee={damage={default=5000}}},weapons={[1]={def="MELEE",maindir="0 0 1",maxangledif=155},[2]={onlytargetcategory="VTOL",def="yellow_missile"},[3]={onlytargetcategory="VTOL",def="yellow_missile"},[4]={onlytargetcategory="VTOL",def="yellow_missile"},[5]={def="acidgoo",maindir="0 0 1",maxangledif=180}}}),raptor_miniq_c=b(N,{maxthisunit=l(4),customparams=G(n[5],n[6],'berserk'),weapondefs={empgoo={burst=10,reloadtime=10,sprayangle=4096,damage={default=2000,shields=2000}},melee={damage={default=6000}}},weapons={[1]={def="MELEE",maindir="0 0 1",maxangledif=155},[2]={onlytargetcategory="VTOL",def="yellow_missile"},[3]={onlytargetcategory="VTOL",def="yellow_missile"},[4]={onlytargetcategory="VTOL",def="yellow_missile"},[5]={def="empgoo",maindir="0 0 1",maxangledif=180}}}),raptor_consort={explodeas='raptor_empdeath_big',maxthisunit=l(6),customparams=G(n[2],1000,'berserk'),weapondefs={eyelaser={name='Angry Eyes',reloadtime=3,rgbcolor='1 0 0.3',range=500,damage={default=6000,commanders=6000}},goo={name='Snowball Barrage',soundstart='penbray2',soundStartVolume=2,cegtag="blob_trail_blue",burst=8,sprayangle=2048,weaponvelocity=600,reloadtime=4,range=1000,hightrajectory=1,rgbcolor="0.7 0.85 1.0",damage={default=1000}}},weapons={[1]={def="eyelaser",badtargetcategory="VTOL OBJECT"},[2]={def='goo',maindir='0 0 1',maxangledif=180,badtargetcategory="VTOL OBJECT"}}},raptor_doombringer={explodeas="ScavComBossExplo",maxthisunit=y,customparams=G(x,1000,'berserk',nil,1,99),weapondefs={eyelaser={name='Eyes of Doom',reloadtime=3,rgbcolor='0.3 1 0',range=500,damage={default=48000,commanders=24000}},goo={name='Amber Hailstorm',soundstart='penbray1',soundStartVolume=2,cegtag="blob_trail_red",burst=15,sprayangle=3072,weaponvelocity=600,reloadtime=5,rgbcolor="0.7 0.85 1.0",hightrajectory=1,damage={default=5000}}},weapons={[1]={def="eyelaser",badtargetcategory="VTOL OBJECT"},[2]={def='goo',maindir='0 0 1',maxangledif=180,badtargetcategory="VTOL OBJECT"}}},raptor_mama_ba={maxthisunit=l(4),customparams=G(55,n[3]-1,'berserk'),weapondefs={goo={damage={default=750}},melee={damage={default=750}}}},raptor_mama_fi={explodeas='raptor_empdeath_big',maxthisunit=l(4),customparams=G(55,n[3]-1,'berserk'),weapondefs={flamethrowerspike={damage={default=80}},flamethrowermain={damage={default=160}}}},raptor_mama_el={maxthisunit=l(4),customparams=G(65,1000,'berserk')},raptor_mama_ac={maxthisunit=l(4),customparams=G(60,1000,'berserk'),weapondefs={melee={damage={default=750}}}},raptor_land_assault_basic_t4_v2={maxthisunit=l(8),customparams=G(33,50,'raider')},raptor_land_assault_basic_t4_v1={maxthisunit=l(12),customparams=G(51,64,'raider','basic',2)}}do a[O]=a[O]or{}table.mergeInPlace(a[O],P,true)end;local Q={raptor_mama_ba=36000,raptor_mama_fi=36000,raptor_mama_el=36000,raptor_mama_ac=36000,raptor_consort=45000,raptor_doombringer=90000}local R=UnitDef_Post;function UnitDef_Post(H,S)if R then R(H,S)end;local T=1;if h>1.3 then T=h/1.3 end;for U,V in pairs(Q)do if UnitDefs[U]then local W=math.floor(V*T)UnitDefs[U].metalcost=W end end end

