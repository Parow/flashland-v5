local mk1 = {
    "Teinture verte 1000$" ,
    "Teinture or 30000$" ,
       "Teinture rose 1000$" ,
       "Teinture armée 2500$" ,
        "Teinture LSPD 5000$" ,
       "Teinture Orange 4500$" ,
       "Teinture Platine 20000$"
   }
   
   local mk1price = {
       1000,30000,1000,2500,5000,4000,20000
   }
local WeaponsFct = WeaponsFct or {
    interiorIDs = {
        [153857] = true,
        [200961] = true,
		[140289] = {
			weaponRotationOffset = 135.0,
		},
        [180481] = true,
        [168193] = true,
        [164609] = {
			weaponRotationOffset = 150.0,
		},
        [175617] = true,
        [176385] = true,
		[178689] = true,
		[137729] = {
			additionalOffset = 			vec(8.3,-6.5,0.0),
			additionalCameraOffset = 	vec(8.3,-6.0,0.0),
			additionalCameraPoint = 	vec(1.0,-0.91,0.0),
			additionalWeaponOffset =	vec(0.0,0.5,0.0),
			weaponRotationOffset = 		-60.0,
		},
		[248065] = {
			additionalOffset = 			vec(-10.0,3.0,0.0),
			additionalCameraOffset = 	vec(-9.5,3.0,0.0),
			additionalCameraPoint = 	vec(-1.0,0.4,0.0),
			additionalWeaponOffset =	vec(0.4,0.0,0.0),
		},
    },
    closeMenuNextFrame = false,
    weaponClasses = {},
}
weapon_name = {
	pistol = "WEAPON_PISTOL",
	pistolcombat = "WEAPON_COMBATPISTOL",
	pistol50 = "WEAPON_PISTOL50",
	revolver = "WEAPON_REVOLVER",
	pistolvintage = "WEAPON_VINTAGEPISTOL",
	snspistol = "WEAPON_SNSPISTOL",
	stungun =  "WEAPON_STUNGUN",
	flaregun = "WEAPON_FLAREGUN",
	pistoldouble = "WEAPON_DOUBLEACTION",
	knuckle = "WEAPON_KNUCKLE",
	knife1 = "WEAPON_SWITCHBLADE",
 	knife = "WEAPON_KNIFE",
 	nightstick = "WEAPON_NIGHTSTICK",
	hammer = "WEAPON_HAMMER",
	bat = "WEAPON_BAT",
	golf = "WEAPON_GOLFCLUB",
	crowbar = "WEAPON_CROWBAR",
	bottle = "WEAPON_BOTTLE",
	dagger = "WEAPON_DAGGER",
	hatchet = "WEAPON_HATCHET",
	machete = "WEAPON_MACHETE",
	flashlight = "WEAPON_FLASHLIGHT",
	microsmg = "WEAPON_MICROSMG",
	minismg = "WEAPON_MINISMG",
	assaultsmg = "WEAPON_ASSAULTSMG",
	machinepistol = "WEAPON_MACHINEPISTOL",
	mg = "WEAPON_MG",
	combatmg = "WEAPON_COMBATMG",
	gusenberg = "WEAPON_GUSENBERG",
	ak = "WEAPON_ASSAULTRIFLE",
	compactrifle = "WEAPON_COMPACTRIFLE",
	carrabine = "WEAPON_CARBINERIFLE",
	advancedrifle = "WEAPON_ADVANCEDRIFLE",
	bullpuprifle = "WEAPON_BULLPUPRIFLE",
 	musket = "WEAPON_MUSKET",
 	heavysniper = "WEAPON_HEAVYSNIPER",
 	sniperrifle = "WEAPON_SNIPERRIFLE",
 	shootgun = "WEAPON_PUMPSHOTGUN",
 	shootguncompact = "WEAPON_SAWNOFFSHOTGUN",
 	bullpupshootgun = "WEAPON_BULLPUPSHOTGUN",
 	doubleshootgun = "WEAPON_SWEEPERSHOTGUN",
}

weapon_munition = {
	pistol = "mm9",
	pistolcombat = "mm9",
	pistol50 = "mm9",
	revolver = "mm9",
	pistolvintage = "mm9",
	snspistol = "acp45",
	stungun =  nil,
	flaregun = "calibre12",
	pistoldouble = "calibre12",
	--- blanches
	knuckle = nil,
	knife1 = nil,
 	knife = nil,
 	nightstick = nil,
	hammer = nil,
	bat = nil,
	golf = nil,
	crowbar = nil,
	bottle = nil,
	dagger = nil,
	hatchet = nil,
	mmachete = nil,
	flashlight = nil,
	microsmg = "mm9",
	minismg = "mm9",
	assaultsmg = "mm9",
	machinepistol = "mm9",
	mg = "akm",
	combatmg = "akm",
	gusenberg = "akm",
	ak = "akm",
	compactrifle = "akm",
	carrabine = "cab",
	advancedrifle = "cab",
	bullpuprifle = "cab",
 	musket = "cab",
 	heavysniper = "snip",
 	sniperrifle = "snip",
 	shootgun = "calibre12",
 	shootguncompact = "calibre12",
 	bullpupshootgun = "calibre12",
 	doubleshootgun = "calibre12",
}

local globalAttachmentTable = {  
	-- Putting these at the top makes them work properly as they need to be applied to the weapon first before other attachments
	{ "COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_CARBINERIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_ASSAULTRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_MICROSMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_SNIPERRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_PISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_PISTOL50_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_APPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_HEAVYPISTOL_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_SMG_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},
	{ "COMPONENT_MARKSMANRIFLE_VARMOD_LUXE", "Yusuf Amir Luxury Finish",1000},

	{ "COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_SNSPISTOL_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_MG_COMBATMG_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_BULLPUPRIFLE_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_MG_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER", "Lowrider Finish",1000},
	{ "COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER", "Lowrider Finish",1000},

	{ "COMPONENT_CARBINERIFLE_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_COMBATMG_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SMG_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_PISTOL_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_PISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_ASSAULTSHOTGUN_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_HEAVYSHOTGUN_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_PISTOL50_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_COMBATPISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_APPISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_COMBATPDW_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SNSPISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_ASSAULTRIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_COMBATMG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_MG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_ASSAULTSMG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_GUSENBERG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_MICROSMG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_BULLPUPRIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_COMPACTRIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_HEAVYPISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_VINTAGEPISTOL_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_CARBINERIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_ADVANCEDRIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_MARKSMANRIFLE_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SMG_CLIP_02", "Extended Magazine",1000},
	{ "COMPONENT_SPECIALCARBINE_CLIP_02", "Extended Magazine",1000},

	{ "COMPONENT_AT_PI_FLSH_02", "Lampe torche",1000},
	{ "COMPONENT_AT_AR_FLSH	", "Lampe torche",1000},
	{ "COMPONENT_AT_PI_FLSH", "Lampe torche",1000},
	{ "COMPONENT_AT_AR_FLSH", "Lampe torche",1000},
	{ "COMPONENT_AT_PI_FLSH_03", "Lampe torche",1000},

	{ "COMPONENT_AT_PI_SUPP", "Silencieux",1000},
	{ "COMPONENT_AT_PI_SUPP_02", "Silencieux",1000},
	{ "COMPONENT_AT_AR_SUPP", "Silencieux",1000},
	{ "COMPONENT_AT_AR_SUPP_02", "Silencieux",1000},
	{ "COMPONENT_AT_SR_SUPP", "Silencieux",1000},
	{ "COMPONENT_AT_SR_SUPP_03", "Silencieux",1000},

	{ "COMPONENT_AT_PI_COMP", "Compensator",1000},
	{ "COMPONENT_AT_PI_COMP_02", "Compensator",1000},
	{ "COMPONENT_AT_PI_COMP_03", "Compensator",1000},
	{ "COMPONENT_AT_MRFL_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_MRFL_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_SR_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_BP_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_BP_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_SC_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_SC_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_AR_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_SB_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_CR_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_MG_BARREL_01", "Barrel Attachment 1",1000},
	{ "COMPONENT_AT_MG_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_CR_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_SR_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_SB_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_AR_BARREL_02", "Barrel Attachment 2",1000},
	{ "COMPONENT_AT_MUZZLE_01", "Muzzle Attachment 1",1000},
	{ "COMPONENT_AT_MUZZLE_02", "Muzzle Attachment 2",1000},
	{ "COMPONENT_AT_MUZZLE_03", "Muzzle Attachment 3",1000},
	{ "COMPONENT_AT_MUZZLE_04", "Muzzle Attachment 4",1000},
	{ "COMPONENT_AT_MUZZLE_05", "Muzzle Attachment 5",1000},
	{ "COMPONENT_AT_MUZZLE_06", "Muzzle Attachment 6",1000},
	{ "COMPONENT_AT_MUZZLE_07", "Muzzle Attachment 7",1000},

	{ "COMPONENT_AT_AR_AFGRIP", "Grip",1000},
	{ "COMPONENT_AT_AR_AFGRIP_02", "Grip",1000},

	{ "COMPONENT_AT_PI_RAIL", "Holographic Sight",1000},
	{ "COMPONENT_AT_SCOPE_MACRO_MK2", "Holographic Sight",1000},
	{ "COMPONENT_AT_PI_RAIL_02", "Holographic Sight",1000},
	{ "COMPONENT_AT_SIGHTS_SMG", "Holographic Sight",1000},
	{ "COMPONENT_AT_SIGHTS", "Holographic Sight",1000},

	{ "COMPONENT_AT_SCOPE_SMALL", "Scope Small",1000},
	{ "COMPONENT_AT_SCOPE_SMALL_02", "Scope Small",1000},

	{ "COMPONENT_AT_SCOPE_MACRO_02", "Scope",1000},
	{ "COMPONENT_AT_SCOPE_SMALL_02", "Scope",1000},
	{ "COMPONENT_AT_SCOPE_MACRO", "Scope",1000},
	{ "COMPONENT_AT_SCOPE_MEDIUM", "Scope",1000},
	{ "COMPONENT_AT_SCOPE_LARGE", "Scope",1000},
	{ "COMPONENT_AT_SCOPE_SMALL", "Scope",1000},

	{ "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2", "2x Scope",1000},
	{ "COMPONENT_AT_SCOPE_SMALL_MK2", "2x Scope",1000},

	{ "COMPONENT_AT_SCOPE_SMALL_SMG_MK2", "4x Scope",1000},
	{ "COMPONENT_AT_SCOPE_MEDIUM_MK2", "4x Scope",1000},

	{ "COMPONENT_AT_SCOPE_MAX", "Advanced Scope",1000},
	{ "COMPONENT_AT_SCOPE_LARGE", "Scope Large",1000},
	{ "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM_MK2", "Scope Large",1000},
	{ "COMPONENT_AT_SCOPE_LARGE_MK2", "8x Scope",1000},

	{ "COMPONENT_AT_SCOPE_NV", "Nightvision Scope",1000},
	{ "COMPONENT_AT_SCOPE_THERMAL", "Thermal Scope",1000},

	--{ "COMPONENT_KNUCKLE_VARMOD_PLAYER", "Default Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_LOVE", "Love Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_DOLLAR", "Dollar Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_VAGOS", "Vagos Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_HATE", "Hate Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_DIAMOND", "Diamond Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_PIMP", "Pimp Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_KING", "King Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_BALLAS", "Ballas Skin",1000},
	{ "COMPONENT_KNUCKLE_VARMOD_BASE", "Base Skin",1000},
	{ "COMPONENT_SWITCHBLADE_VARMOD_VAR1", "Default Skin",1000},
	{ "COMPONENT_SWITCHBLADE_VARMOD_VAR2", "Variant 2 Skin",1000},
	--{ "COMPONENT_SWITCHBLADE_VARMOD_BASE", "Base Skin",1000},

	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_MARKSMANRIFLERIFLE_MK2_CAMO_IND_01", "American Camo",1000},

	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01", "American Camo",1000},

	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01", "American Camo",1000},

	{ "COMPONENT_REVOLVER_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_REVOLVER_MK2_CAMO_IND_01", "American Camo",1000},

	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01", "American Camo",1000},

	{ "COMPONENT_PISTOL_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_SMG_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO", "Camo 1",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_SMG_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_02", "Camo 2",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_SMG_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_03", "Camo 3",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_SMG_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_04", "Camo 4",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_SMG_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_05", "Camo 5",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_SMG_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_06", "Camo 6",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_SMG_MK2_CAMO_07", "Camo 7",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_SMG_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_08", "Camo 8",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_SMG_MK2_CAMO_09", "Camo 9",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_SMG_MK2_CAMO_10", "Camo 10",1000},
	{ "COMPONENT_PISTOL_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_SMG_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_COMBATMG_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01", "American Camo",1000},
	{ "COMPONENT_SNSPISTOL_MK2_CAMO_IND_01", "American Camo",1000},
}
local ep1 = false
local Indexes2 = {}
local Open = function()
    RageUI.Visible(RMenu:Get('ammunation', "main"),true)
    playerPed = GetPlayerPed(-1)
    for i=0, GetNumberOfPedDrawableVariations(playerPed,9)-1,1 do
        Indexes2[i] = 1
    end
end
local weapon_config = {
    Pos = {x=21.39,y=-1106.51,z=29.8},
    Ped = {
        Pos = {x=22.89,y=-1105.59,z=28.8,a=164.43},
        model = "s_m_y_ammucity_01",
        name = "Freddy"
    },
    Blips = {
        sprite = 110,
        color = 1,
        name = "Ammunation"
    },

    EnterZone = function()
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
        KeySettings:Add("keyboard","E",Open,"Ammu")
        KeySettings:Add("controller",46,Open,"Ammu")
    end,
    ExitZone = function()
        KeySettings:Clear("keyboard","E","Ammu")
        KeySettings:Clear("controller","E","Ammu")
        Hint:RemoveAll()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
        RageUI.GoBack()
    end
}
local globalWeaponTable = {
	blanc = 
	{
        { 'WEAPON_KNUCKLE', 'Poing Americain',78 },
        { 'WEAPON_SWITCHBLADE', "Cran d'arrêt",125 },
        { 'WEAPON_KNIFE', 'Couteau' ,88 },
        { 'WEAPON_HAMMER', 'Marteau',100 },
        { 'WEAPON_BAT', 'Bat',180 },
        { 'WEAPON_GOLFCLUB', 'Club Golf',155 },
        { 'WEAPON_CROWBAR', 'Pied de biche',130 },
        { 'WEAPON_POOLCUE', 'Queue de billard',85 },
        { 'WEAPON_WRENCH', 'Clé anglaise' ,125 },
        { 'WEAPON_FLASHLIGHT', 'Lampe torche',75 },
        { 'WEAPON_BOTTLE', 'Bouteille Cassé',50 },
	},
	pistol = 
    {
        { 'WEAPON_PISTOL', 'Pistolet',4400},
        { 'WEAPON_COMBATPISTOL', 'Pistolet de combat',8000},
        { 'WEAPON_PISTOL50', 'Pistolet Calibre.50',11000 },
        { 'WEAPON_REVOLVER', 'Revolver',5000 },
        { 'WEAPON_VINTAGEPISTOL', 'Vintage Pistol',5600 },
        { 'WEAPON_SNSPISTOL', 'SNS Pistol',2400 },
        { 'WEAPON_HEAVYPISTOL', 'Pistolet Lourd',14500 },
        { 'WEAPON_FLAREGUN', 'Flare Gun',5000 },
        { 'WEAPON_DOUBLEACTION', 'Pistolet double action' ,6600},
	}
}
local munition_index = 1
local function build()
    v = weapon_config
    if not v.Hidden then
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite (blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip,  v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blips.name)
        EndTextCommandSetBlipName(blip)

    end
    Zone:Add(v.Pos,v.EnterZone,v.ExitZone,i,2.5)
    Ped:Add(v.Ped.name,v.Ped.model,v.Ped.Pos,nil)
    RMenu.Add('ammunation', "main", RageUI.CreateMenu(nil, "Catégories disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add('ammunation', "weapons", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Armes disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add('ammunation', "blanches", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Armes blanches disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add('ammunation', "kevlars", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Kevlars disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add('ammunation', "munitions", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Munitions disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))
    RMenu.Add('ammunation', "my_weap", RageUI.CreateSubMenu(RMenu:Get('ammunation', "main"), nil, "Armes disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))

    RMenu.Add('ammunation', "my_weap_1", RageUI.CreateSubMenu(RMenu:Get('ammunation', "my_weap"), nil, "Options disponibles",10,100,"shopui_title_gunclub","shopui_title_gunclub"))

    RMenu:Get('ammunation', "kevlars").Closed = function()
        SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)
    end
end

build()
function indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end
local xp = {}
local price = 0
local amount_index = 1
local munition_type = {"9mm",".45",".12","7.62","5.56"}
local munition_name = {"mm9","acp45","calibre12","akm","cab"}
local myweapIn = nil
local Indexes = 1
local inv_index = 1
local inv_name = nil
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('ammunation', "main")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                RageUI.Button("Armes",nil,{},true,function() end,RMenu:Get('ammunation', "weapons"))
                RageUI.Button("Armes blanches",nil,{},true,function() end,RMenu:Get('ammunation', "blanches"))
                RageUI.Button("Kevlars",nil,{},true,function() end,RMenu:Get('ammunation', "kevlars"))
                RageUI.Button("Munitions",nil,{},true,function() end,RMenu:Get('ammunation', "munitions"))
                RageUI.Button("Mes armes",nil,{},true,function() end,RMenu:Get('ammunation', "my_weap"))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('ammunation', "my_weap_1")) then
            local CurrentWeapon = myweapIn
            RageUI.DrawContent({ header = true, glare = false}, function()
                RageUI.List("Teinture", mk1,Indexes , nil,{}, true,function(Hovered, Active, Selected, Index)
                    Indexes = Index
                    if Selected then
                        playerPed = GetPlayerPed(-1)
                        local canbuy = Money:CanBuy(mk1price[Index])
                        if canbuy then

                            RageUI.Popup({message="Vous avez appliqué la teinture ~b~" .. mk1[Indexes] .. " ~s~à votre arme"})
                                TriggerServerEvent("money:Pay", mk1price[Index])
                                CurrentWeapon.data["tint"] = Index
                                Inventory.Inventory[inv_name][inv_index].data = CurrentWeapon.data
                                TriggerServerEvent("inventory:editData",CurrentWeapon.id,CurrentWeapon.data)
                                if HasPedGotWeapon(playerPed,GetHashKey(weapon_name[CurrentWeapon.name]),false) then
                                    SetPedWeaponTintIndex(playerPed,GetHashKey(weapon_name[CurrentWeapon.name]),Index)
                                end
                        end
    
                    end
                end)
                for k,attachmentObject in ipairs(globalAttachmentTable) do
                    ----dump(attachmentObject))
                    
                    if DoesWeaponTakeWeaponComponent(weapon_name[CurrentWeapon.name], attachmentObject[1]) then	
                        data = myweapIn.data	
                        if data.access ~= nil then	
                            if indexOf(data.access,attachmentObject[1]) then
                                xp[k] = RageUI.BadgeStyle.Gun
                            end
                        end
                        RageUI.Button(attachmentObject[2], nil, {
                            LeftBadge = xp[k],
                                 RightLabel = attachmentObject[3] .. "$"
                             }, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local canbuy = Money:CanBuy(attachmentObject[3])
                                    if canbuy then
                                        xp[k] = RageUI.BadgeStyle.Gun
                                        if CurrentWeapon.data["access"] == nil then
                                            CurrentWeapon.data["access"] = {}
                                        end
                                        table.insert(CurrentWeapon.data["access"],attachmentObject[1])
                                        Inventory.Inventory[inv_name][inv_index].data = CurrentWeapon.data
                                        TriggerServerEvent("inventory:editData",CurrentWeapon.id,CurrentWeapon.data)

                                        TriggerServerEvent("money:Pay", attachmentObject[3])
                                        if HasPedGotWeapon(playerPed,GetHashKey(weapon_name[CurrentWeapon.name]),false) then
                                            GiveWeaponComponentToPed(playerPed,GetHashKey(weapon_name[CurrentWeapon.name]),GetHashKey(attachmentObject[1]))
                                        end
                                    end
                                end
                        end)
                    end
                end
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('ammunation', "my_weap")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                for k , v in pairs(Inventory.Inventory) do
                    if Items[k].category == "weapon" then
                        for i=1, #v , 1 do 

                            RageUI.Button(Items[k].label , nil, { RightLabel = "#"..v[i].data.serial }, true, function(_, _, Selected)
                                if Selected then
                                    myweapIn = v[i]
                                    inv_index = i
                                    inv_name = k
                                end
                            end,RMenu:Get('ammunation', "my_weap_1"))
                        end
                    end
                end
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('ammunation', "weapons")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                for i = 1 , #globalWeaponTable.pistol, 1 do
                    local c = globalWeaponTable.pistol[i]
                    RageUI.Button(c[2],nil,{RightLabel = c[3].."$"},true,function(_,_,Selected) 
                        if Selected then
                            local money = Money:CanBuy(c[3])
                            
                            if money then
                                for m1,m3 in pairs(weapon_name) do
                                    local receive = Inventory.CanReceive(m1,1)
                                    if m3 == c[1] and receive then
                                        local data = {serial=math.random(111111111,999999999)}
                                        items = {name=m1,data=data}
                                        TriggerServerEvent("inventory:AddItem", items)
										TriggerServerEvent("money:Pay", c[3])
										TriggerServerEvent("BuyNewWeapon", data,Items[m1].label)
                                        break
                                    end
                                end
                            else
                                
                            end
                        end
                    end)
                end
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('ammunation', "blanches")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                for i = 1 , #globalWeaponTable.blanc, 1 do
                    local c = globalWeaponTable.blanc[i]
                    RageUI.Button(c[2],nil,{RightLabel = c[3].."$"},true,function(_,_,Selected) 
						if Selected then
							TriggerServerCallback('getArmeblanched', function(Data)
								if Data then
									local money = Money:CanBuy(c[3])
									if money  then
										for m1,m3 in pairs(weapon_name) do
											local receive = Inventory.CanReceive(m1,1)
											if m3 == c[1] and receive then
												local data = {serial=math.random(111111111,999999999)}
												items = {name=m1,data=data}
												TriggerServerEvent("inventory:AddItem", items)
												TriggerServerEvent("money:Pay", c[3])
												TriggerServerEvent("BuyNewWeapon", data,Items[m1].label)
												TriggerServerEvent("ArmeBlanche")
												
												break
											end
										end
									else
										
									end
								end
							end)
                        end
                    end)
                end
            end, function()
            end)
        end

        if RageUI.Visible(RMenu:Get('ammunation', "kevlars")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                playerPed = GetPlayerPed(-1)
                for i = 1,GetNumberOfPedDrawableVariations(playerPed,9)-1,1 do
                    local amount = {}
                    local ind = i+1
                    for c = 1, GetNumberOfPedTextureVariations(playerPed, 9, i), 1 do  
                        amount[c] = c 
                    end
                    if gilItem[ind] == nil then
                        gilItem[ind] =  "Kevlars #"..i
                    end
                    RageUI.List(gilItem[i+1], amount, Indexes2[i], "",{RightLabel="1500$"}, true, function(Hovered, Active, Selected, Index)
                        Indexes2[i] = Index
                        if Active then
                            SetPedComponentVariation(playerPed, 9, i, Index, 2)
                        end		
                        if Selected then
                            local money = Money:CanBuy(1500)
                            local receive = Inventory.CanReceive("kevlar",1)
                            if money and receive then
                                items = {name="kevlar",data={ind=i,var=Index,serial=math.random(111111111,999999999),status=100}}
                                TriggerServerEvent("inventory:AddItem", items)
                                TriggerServerEvent("money:Pay", 1500)
                            end
                        end
                    end)
                end
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('ammunation', "munitions")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                RenderText(price.."$", 1800, 1000, 1, 1.3, 100, 255, 100, 255, 1)
                amount = {}
                for i = 0, 1000,1 do
                    amount[i] = i
                end
                RageUI.List("9mm", munition_type, munition_index, nil,{},true, function(Hovered, Active, Selected, Index)
                    munition_index  = Index

                end)
                RageUI.List("Combien ?", amount, amount_index, nil,{}, true, function(Hovered, Active, Selected, Index)
                    if amount_index ~= Index then
                        amount_index  = Index
                    end
                end)
                RageUI.Button("~g~Acheter",nil,{RightLabel=amount_index*2 .."$"},true,function(_,_,Selected) 
                    if Selected then
                        local money = Money:CanBuy(1500)
                        local receive = Inventory.CanReceive("kevlar",1)
                        if money and receive then
                            TriggerServerEvent("core:buymunition",amount_index,munition_name[munition_index])
                            TriggerServerEvent("money:Pay", money)
                        end
                    end
                end)


            end, function()
            end)
        end
    end
end)
local xp = {}
local CurrentWeapon = nil

local Indexes = 1
local Indexes2 = {}
gilItem = {}
amount = {}
local kx = 20
local price = 0
function indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end
local cam = nil
function DeleteAmmunation()
	RenderScriptCams(false, true, 10, true, true)
	SetCamActive(WeaponsFct.currentMenuCamera, false)
	DeleteObject(WeaponsFct.fakeWeaponObject)
	SetPlayerControl(PlayerId(), true)
end
function RemoveWeaponAmmunation()

end
SetPlayerControl(PlayerId(), true)
Citizen.CreateThread(function()
	function CreateFakeWeaponObject(weapon, keepOldWeapon)


		local weaponWorldModel = GetWeapontypeModel(weapon)
		RequestModel(weaponWorldModel)
		while not HasModelLoaded(weaponWorldModel) do Citizen.Wait(0) end
		
		local interiorID = GetInteriorFromEntity(GetPlayerPed(-1))
		local rotationOffset = 0.0
		local additionalOffset = vec(0,0,0)
		local additionalWeaponOffset = vec(0,0,0)
		if type(WeaponsFct.interiorIDs[interiorID]) == "table" then
			rotationOffset = WeaponsFct.interiorIDs[interiorID].weaponRotationOffset or 0.0
			additionalOffset = WeaponsFct.interiorIDs[interiorID].additionalOffset or additionalOffset
			additionalWeaponOffset = WeaponsFct.interiorIDs[interiorID].additionalWeaponOffset or additionalWeaponOffset
		end

		local fakeWeaponCoords = (GetOffsetFromInteriorInWorldCoords(interiorID, 4.0,6.25,2.0) + additionalOffset) + additionalWeaponOffset 
		local fakeWeapon = CreateWeaponObject(weapon, 1*3, fakeWeaponCoords, true, 0.0)
		SetEntityAlpha(fakeWeapon, 0)
		SetEntityHeading(fakeWeapon, (GetCamRot(GetRenderingCam(), 1).z - 180)+rotationOffset)
		SetEntityCoordsNoOffset(fakeWeapon, fakeWeaponCoords)

		if not keepOldWeapon then
			SetEntityAlpha(fakeWeapon, 255)
			if DoesEntityExist(WeaponsFct.fakeWeaponObject) then DeleteObject(WeaponsFct.fakeWeaponObject) end
			WeaponsFct.fakeWeaponObject = fakeWeapon
		end

		return fakeWeapon
	end
end)

Citizen.CreateThread(function()
	function CreateFakeWeaponObject2(weapon, attachments)

		local weaponWorldModel = GetWeapontypeModel(weapon)
		RequestModel(weaponWorldModel)
		while not HasModelLoaded(weaponWorldModel) do Citizen.Wait(0) end
		
		local interiorID = GetInteriorFromEntity(GetPlayerPed(-1))
		local rotationOffset = 0.0
		local additionalOffset = vec(0,0,0)
		local additionalWeaponOffset = vec(0,0,0)
		if type(WeaponsFct.interiorIDs[interiorID]) == "table" then
			rotationOffset = WeaponsFct.interiorIDs[interiorID].weaponRotationOffset or 0.0
			additionalOffset = WeaponsFct.interiorIDs[interiorID].additionalOffset or additionalOffset
			additionalWeaponOffset = WeaponsFct.interiorIDs[interiorID].additionalWeaponOffset or additionalWeaponOffset
		end

		local fakeWeaponCoords = (GetOffsetFromInteriorInWorldCoords(interiorID, 4.0,6.25,2.0) + additionalOffset) + additionalWeaponOffset 
		local fakeWeapon = CreateWeaponObject(weapon, 1*3, fakeWeaponCoords, true, 0.0)
		SetEntityAlpha(fakeWeapon, 0)
		SetEntityHeading(fakeWeapon, (GetCamRot(GetRenderingCam(), 1).z - 180)+rotationOffset)
		SetEntityCoordsNoOffset(fakeWeapon, fakeWeaponCoords)

		for i,attach in ipairs(attachments) do
			if DoesPlayerWeaponHaveComponent(weapon.model, attach.model) then
				GiveWeaponComponentToWeaponObject(fakeWeapon, attach.model)
			end
		end


		return fakeWeapon
	end
end)










