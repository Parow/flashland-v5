resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
server_script '@mysql-async/lib/MySQL.lua'

client_script "cl_trigger.lua"
server_script "sv_trigger.lua"
files {
    'data/*.json',
}
-- extrapos
client_scripts {
    "vehicle/cl_tow.lua"
}
server_script {
    "vehicle/sv_tow.lua"
}
client_script "illegal/xp/client.lua"

client_scripts {
    "assets/Animations.lua",
    "assets/Items.lua",
    "assets/Jobs.lua"
}

server_script {
    "assets/Items.lua",
    "assets/Jobs.lua"
}
client_script "help.lua"

--
client_scripts {
    "vendor/rageui/rageui/RageUI.lua",
    "vendor/rageui/rageui/Menu.lua",
    "vendor/rageui/rageui/MenuController.lua",

    "vendor/rageui/components/Rectangle.lua",
    "vendor/rageui/components/Sprite.lua",
    "vendor/rageui/components/Text.lua",
    "vendor/rageui/components/Visual.lua",
    "vendor/rageui/components/Audio.lua",
    "vendor/rageui/components/Scaleform.lua",
    "vendor/rageui/components/Screen.lua",

    "vendor/rageui/rageui/elements/ItemsBadge.lua",
    "vendor/rageui/rageui/elements/ItemsColour.lua",
    "vendor/rageui/rageui/elements/PanelColour.lua",
    "vendor/rageui/rageui/items/UIButton.lua",
    "vendor/rageui/rageui/items/UICheckBox.lua",
    "vendor/rageui/rageui/items/UIList.lua",
    "vendor/rageui/rageui/items/UIProgress.lua",
    "vendor/rageui/rageui/items/UISlider.lua",
    "vendor/rageui/rageui/items/UISliderHeritage.lua",

    "vendor/rageui/rageui/panels/UIColourPanel.lua",
    "vendor/rageui/rageui/panels/UIGridPanel.lua",
    "vendor/rageui/rageui/panels/UIGridPanelHorizontal.lua",
    "vendor/rageui/rageui/panels/UIGridPanelVertical.lua",
    "vendor/rageui/rageui/panels/UIPercentagePanel.lua",
    "vendor/rageui/rageui/windows/UIHeritage.lua",

}

client_scripts {
    'vendor/natives-libraries/entity/client/basic.lua',
    'vendor/natives-libraries/entity/client/ped.lua',
    'vendor/natives-libraries/entity/client/animations.lua',
    'vendor/natives-libraries/entity/client/freemode.lua',
    'vendor/natives-libraries/entity/client.lua',
    'vendor/natives-libraries/streaming/client.lua',
    'vendor/natives-libraries/scaleform/client.lua',
    'vendor/natives-libraries/screen/Prompt.lua',
    'vendor/natives-libraries/screen/KeyboardInput.lua',
    'vendor/natives-libraries/math/client.lua',
    'vendor/natives-libraries/blips/client.lua',
    'vendor/natives-libraries/zones/client.lua',
    'vendor/natives-libraries/vehicle/client.lua',
    'vendor/natives-libraries/zones/marker.lua',
    --- Spawning
    "vendor/server-callback/client.lua"
}


server_scripts {
    "vendor/server-callback/server.lua",
    'vendor/natives-libraries/player/server.lua',
}

client_script "handler/spawned/client.lua"
server_script "handler/spawned/server.lua"

client_script "handler/key.lua"
server_script "handler/sha1.js"
client_script "handler/cl_commands.lua"
server_script "handler/sv_commands.lua"
client_script 'handler/position/client.lua'
server_script 'handler/position/server.lua'


--[[
 MUGROOM START
]]--
client_scripts {
    "mugroom/selector/class/camera.lua",
    "mugroom/selector/class/ped.lua",
    "mugroom/selector/selector.lua",

    "mugroom/creator/class/camera.lua",
    "mugroom/creator/class/ped.lua",
    "mugroom/creator/class/ia.lua",
    "mugroom/creator/creator.lua",

    "mugroom/client.lua",
}

server_scripts {
    "mugroom/server.lua",
}
--[[
 MUGROOM STOP
]]--

client_scripts {
    "vehicle/cl_keylock.lua",
    "vehicle/cl_ownedvehicles.lua",
    "vehicle/cl_vehdoor.lua",
    "vehicle/garage.lua",
    "vehicle/cl_coffre.lua"
}


client_scripts {


    'menus/handler.lua',

    "menus/mugroom/selector.lua",

    "menus/mugroom/creator/categories/appearance.lua",
    "menus/mugroom/creator/categories/clothes.lua",
    "menus/mugroom/creator/categories/faceFeature.lua",
    "menus/mugroom/creator/categories/heritage.lua",
    "menus/mugroom/creator/categories/roleplayContent.lua",
    "menus/mugroom/creator/main.lua",

    "menus/personnal/main.lua",
    "menus/personnal/inventory.lua",
    "menus/personnal/animations.lua",
    "menus/personnal/other.lua",
    "menus/personnal/admin.lua",
    "menus/personnal/boss.lua",

    "menus/computer/main.lua",
    "menus/computer/mail.lua",
    "menus/computer/casier.lua",
    "menus/computer/cameras.lua",
    "menus/crafting/main.lua",
    "menus/tow_menu.lua",
    "menus/stockage.lua",
    "menus/banks.lua",
    "menus/cl_fuel.lua",
    "shops/clothes/cl_tatoo.lua",
    "menus/jobs/menuHandlerJob.lua",
    "menus/jobs/mecano.lua",
    "menus/jobs/police.lua"
}

server_scripts {
    "player/server/player_class.lua",
    "player/server/inventory.lua",
    "player/server/skin.lua",
    "player/server/settings.lua",
    "player/server/position.lua"
}

client_scripts {
    "items/item_handler_cl.lua"
}

client_scripts {
    "shops/shop/cl_shop.lua",
    "shops/shop/cl_ltd.lua",
    "shops/shop/cl_wepshop.lua",
    "shops/tattoo/client.lua",
    "shops/vehicle/cl_vehshop.lua",
    "shops/clothes/cl_clothes.lua",
    "shops/clothes/cl_barber.lua",
    
}

server_scripts {
    "shops/tattoo/server.lua",
    "shops/vehicle/sv_vehshop.lua"
}
client_scripts {
    -- Ply handler
    "player/client/player_handler.lua",
    "player/client/job_handler.lua",
    "player/client/handcuff.lua",
    "player/client/money_handler.lua",
}

server_script 'uuid.js'
server_scripts {
    "vehicle/sv_garage.lua"
}
client_scripts {
    "jobs/clotheRoom.lua",
    "jobs/permManager.lua",
    "jobs/basicWork.lua",
    "jobs/jobLister.lua",
    "jobs/facture.lua",
    "jobs/cl_immo.lua"
}
server_script "jobs/sv_jobLister.lua"
server_script "jobs/sv_immo.lua"
client_script "handler/comas.lua"

--- 
---- Illegal
---
client_scripts {
    "illegal/drugs/cl_drugbuyer.lua"
}

server_scripts {
    "illegal/drugs/sv_drugbuyer.lua"
}

--- 
---- World
---
client_scripts {
    "world/cl_computer.lua",
    "world/cl_appart.lua",


}
server_scripts {
    "world/sv_computer.lua",


    "banking/banking_class.lua"
}

client_script 'cl_permis.lua'
client_script 'cl_blips.lua'
client_script "cl_test.lua"

export 'OnNewPlayerSpawn'

export 'OnPlayerSpawn'

export 'TriggerServerCallback'

export 'LoadingPrompt'

export 'SetCoords'

export 'UpdatePlayerPedFreemodeCharacter'

export 'GenerateEntityFace'

export 'GenerateEntityTattoo'

export 'GenerateEntityOutfit'

export 'GenerateFreemodeModel'

server_export 'RegisterServerCallback'

server_export ''