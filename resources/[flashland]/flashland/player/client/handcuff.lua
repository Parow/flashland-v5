Citizen.CreateThread(function()
    while true do
        Wait(0)
        local Player = LocalPlayer()
        if Player.Handcuff then
            Player.isBusy = true
            DisableControlAction(0, 69, true)  -- INPUT_VEH_ATTACK
            DisableControlAction(0, 92, true)  -- INPUT_VEH_PASSENGER_ATTACK
            DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
            DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
            DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
            DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
            DisableControlAction(0, 257, true) -- INPUT_ATTACK2
            DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
            DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
            DisableControlAction(0, 24, true)  -- INPUT_ATTACK
            DisableControlAction(0, 25, true)  -- INPUT_AIM
            DisableControlAction(0, 21, true)  -- SHIFT
            DisableControlAction(0, 22, true)  -- SPACE
            DisableControlAction(0, 288, true) -- F1
            DisableControlAction(0, 289, true) -- F2
            DisableControlAction(0, 170, true) -- F3
            DisableControlAction(0, 166, true) -- F5
            DisableControlAction(0, 167, true) -- F6
            DisableControlAction(0, 168, true) -- F7
            DisableControlAction(0, 57, true)  -- F10
            DisableControlAction(0, 37, true)  -- M
            DisableControlAction(0, 0, true)  -- v
            DisableControlAction(0, 26, true)  -- c
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local Player = LocalPlayer()
        if Player.Handcuff then
            TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end
    end
end)
local function ShowNotification(msg)
    RageUI.Popup({message=msg})
end
local HandCuffObj = nil
RegisterNetEvent('player:HandCuff')
AddEventHandler('player:HandCuff', function(m)
    local Player = LocalPlayer()
    Player.Handcuff = m
    if m then
        local playerPed = GetPlayerPed(-1)
        ShowNotification('Vous avez été ~r~menotté.')
        SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
        Citizen.CreateThread(function()
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Wait(100)
            end
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            SetEnableHandcuffs(playerPed, true)
            SetPedCanPlayGestureAnims(playerPed, false)

        end)
        local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
        HandCuffObj = CreateObject(GetHashKey("prop_cs_cuffs_01"), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        
        AttachEntityToEntity(HandCuffObj, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 60309), 0.0, 0.05, 0.0, 0.0, 0.0, 80.0, 1, 0, 0, 0, 0, 1)
    else
        local playerPed = GetPlayerPed(-1)
        ShowNotification('Vous avez été ~g~démenotté.')
        Citizen.CreateThread(function()
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
        end)
        DeleteObject(HandCuffObj)
    end
end)