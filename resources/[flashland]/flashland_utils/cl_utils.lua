local relationshipTypes = {
    "PLAYER",
    --"CIVMALE",
    --"CIVFEMALE",
    --"COP",
    "SECURITY_GUARD",
    "PRIVATE_SECURITY",
    "FIREMAN",
    "GANG_1",
    "GANG_2",
    "GANG_9",
    "GANG_10",
    "AMBIENT_GANG_LOST",
    "AMBIENT_GANG_MEXICAN",
    "AMBIENT_GANG_FAMILY",
    "AMBIENT_GANG_BALLAS",
    "AMBIENT_GANG_MARABUNTE",
    "AMBIENT_GANG_CULT",
    "AMBIENT_GANG_SALVA",
    "AMBIENT_GANG_WEICHENG",
    "AMBIENT_GANG_HILLBILLY",
    "DEALER",
    "HATES_PLAYER",
    "HEN",
    --"WILD_ANIMAL",
    --"SHARK",
    --"COUGAR",
    "NO_RELATIONSHIP",
    "SPECIAL",
    "MISSION2",
    "MISSION3",
    "MISSION4",
    "MISSION5",
    "MISSION6",
    "MISSION7",
    "MISSION8",
    "ARMY",
    "GUARD_DOG",
    "AGGRESSIVE_INVESTIGATE",
    "MEDIC",
    "CAT",
    }
    
    local RELATIONSHIP_HATE = 1
    
    Citizen.CreateThread(function()
        while true do
            Wait(50)
    
            for _, group in ipairs(relationshipTypes) do
                -- not sure about argument order, players don't have AI so only one of these should be needed
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey('PLAYER'), GetHashKey(group))
                SetRelationshipBetweenGroups(RELATIONSHIP_HATE, GetHashKey(group), GetHashKey('PLAYER'))
            end
        end
    end)
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end
local once = true
local oldval = false
local oldvalped = false
local ishandcuff = false


Citizen.CreateThread(function()
    while true do
        Wait(0)


        if once then
            once = false
        end
        if ishandcuff == false then
        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
	end

    end
end)
Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        SetVehicleDensityMultiplierThisFrame(0.4)
        DisablePlayerVehicleRewards(PlayerId())
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 50.0, 0)
        SetPlayerHealthRechargeMultiplier(GetPlayerPed(-1),0.0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(100)
        if GetPlayerWantedLevel(PlayerId()) ~= 0 then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPoliceIgnorePlayer(PlayerId(), true)
            SetDispatchCopsForPlayer(PlayerId(), false)
            SetDitchPoliceModels()
        end

        local playerPed = GetPlayerPed(-1)
        local playerLocalisation = GetEntityCoords(playerPed)
        ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)
    end
end)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end


Citizen.CreateThread(function()
    Config						= {}
    Config.InfiniteLocks		= false  -- Should one lockpick last forever?
    Config.LockTime			    = 60     -- In seconds, how long should lockpicking take?
    Config.AlarmTime            = 60     -- Second to have the alarm activated once vehicle is lockpicked
    Config.JammedHandbrakeTime  = 10     -- Second to have the handbrake jammed
    Config.IgnoreAbort			= true   -- Remove lockpick from inventory even if user aborts lockpicking?
    Config.AllowMecano			= true   -- Allow mechanics to use this lockpick?
    Config.NPCVehiclesLocked    = true   -- Locks all vehicles (MUST HAVE SOME SORT OF LOCKSYSTEM FOR OWNED CAR) Will be adding a check for owned vehicle in the future. 
    Config.Locale				= 'en'   -- Change the language. Currently only en  but will add fr soon.
    Config.percentage           = 100	 -- In percentage
    Config.CallCops             = true   -- Set to true if you want cops to be alerted when lockpicking a vehicle no matter what the outcome is.
    Config.CallCopsPercent      = 1      -- (min1) if 1 then cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%.
    Config.chance               = 0      -- chance of being unlocked in percentage
    
    Config.blacklist = { -- vehicles that will always be locked when spawned naturally
      "T20",
      "police",
      "police2",
      "sheriff3",
      "sheriff2",
      "sheriff",
      "riot",
      "fbi",
      "hwaycar2",
      "hwaycar3",
      "hwaycar10",
      "hwaycar",
      "polf430",
      "policeb",
      "police7",
      "RHINO"
    }
    
    Config.job_whitelist = {
    "police",
    "EMS"
    }
	while true do
		-- gets if player is entering vehicle
		if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId())) then
			-- gets vehicle player is trying to enter and its lock status
			local veh = GetVehiclePedIsTryingToEnter(PlayerPedId())
			local lock = GetVehicleDoorLockStatus(veh)
				
				-- Get the conductor door angle, open if value > 0.0
				--local doorAngle = GetVehicleDoorAngleRatio(veh, 0)
			
				-- normalizes chance
				if Config.chance >= 100 then
					Config.chance = 100
				elseif Config.chance <= 0 then
					Config.chance = 0
				end
			
				-- check if got lucky
				local lucky = (math.random(100) < Config.chance)
			
				-- Set lucky if conductor door is open
				--[[ if doorAngle > 0.5 then
					lucky = true
				end ]]
				-- check if vehicle is in blacklist
				local blacklisted = false
				for k,model in pairs(Config.blacklist) do
					if IsVehicleModel(veh, GetHashKey(model)) then
						blacklisted = true
					end
				end

				-- gets ped that is driving the vehicle
				local pedd = GetPedInVehicleSeat(veh, -1)
				local plate = GetVehicleNumberPlateText(veh)
				-- lock doors if not lucky or blacklisted
				if ((lock == 7) or (pedd ~= 0 )) then
                        if not lucky or blacklisted then
                            SetVehicleDoorsLocked(veh, 2)
							TriggerServerEvent('setVehicleDoorsForEveryone', {veh, 2, plate})
						else
							TriggerServerEvent('setVehicleDoorsForEveryone', {veh, 1, plate})
						end
                    end
			end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('setVehicleDoors')
AddEventHandler('setVehicleDoors', function(veh, doors)
	SetVehicleDoorsLocked(veh, doors)
end)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
local kmh= 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if( not IsPedInAnyVehicle(GetPlayerPed(-1), false))then
			Citizen.Wait(10)
		else

		if(IsPedInAnyVehicle(GetPlayerPed(-1), false))then
			IsInVehiclex = true
			
			drawRct(0.11, 0.932, 0.046,0.03,0,0,0,100) 	-- UI:panel kmh
			drawTxt(0.61, 1.42, 1.0,1.0,0.64 , "~w~" .. math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6), 255, 255, 255, 255)  -- INT: kmh
			drawTxt(0.633, 1.432, 1.0,1.0,0.4, "~w~ km/h", 255, 255, 255, 255)	-- TXT: kmh
		end
	end
	end
end)




Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		if  not ishandcuff then
			if IsControlPressed(1, 323) and IsPedOnFoot(PlayerPedId())  then
				local ped = GetPlayerPed(-1)
		
				if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
		
					RequestAnimDict( "random@mugging3" )
		
					while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
						Citizen.Wait( 1 )
					end

					if handsup then
						ClearPedSecondaryTask(ped)
						handsup = false
						TriggerServerEvent("core:updateHands",handsup)
						Citizen.Wait(500)
					else
						TaskPlayAnim(ped, "random@mugging3", "handsup_standing_enter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						Wait(100)
						TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						handsup = true
						TriggerServerEvent("core:updateHands", handsup)
						Citizen.Wait(500)
					end
				end
			end
		end
	end
end)

-- Citizen.CreateThread(function()
--     while true do
--         Wait( 0 )

--         local ped = PlayerPedId()
--         -- if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not IsEntityDead( ped ) then
--         -- if DoesEntityExist( ped ) and not IsEntityDead( ped ) and CheckSkin(ped) then
--             if not IsPauseMenuActive() then 
--                 loadAnimDict( "random@arrests" )
--                 if IsControlJustReleased( 0, 19 ) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
--                     TriggerServerEvent('InteractSound_SV:PlayOnSource', 'off', 0.1)
--                     ClearPedTasks(ped)
--                     SetEnableHandcuffs(ped, false)
--                 else
--                     if IsControlJustPressed( 0, 19 ) and not IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
--                         TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
--                         TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
--                         SetEnableHandcuffs(ped, true)
--                     elseif IsControlJustPressed( 0, 19 ) and IsPlayerFreeAiming(PlayerId()) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
--                         TriggerServerEvent('InteractSound_SV:PlayOnSource', 'on', 0.1)
--                         TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
--                         SetEnableHandcuffs(ped, true)
--                     end 
--                     if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
--                         DisableActions(ped)
--                     elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
--                         DisableActions(ped)
--                     end
--                 end
--             end 
--         -- end 
--     end
-- end )


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end

function DisableActions(ped)
    DisableControlAction(1, 140, true)
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
    DisablePlayerFiring(ped, true) -- Disable weapon firing
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
    RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
    RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
    RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
  end
end)

RegisterNetEvent('core:HandCuff')
AddEventHandler('core:HandCuff', function(m)

    ishandcuff = m
end)
local blessed = false
RegisterNetEvent('changeBlessed')
AddEventHandler('changeBlessed', function(bool,time)
    blessed = true
    SetTimeout(time,function()blessed = false end)
end)
Citizen.CreateThread(function()

    while true do
        Wait(1)
        if blessed then
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
            DisableControlAction(0, 37, true)  -- M
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetEveryoneIgnorePlayer(PlayerId(), true)
    end
end)


AddEventHandler("playerSpawned", function()
  Citizen.CreateThread(function()

    local player = PlayerId()
    local playerPed = GetPlayerPed(-1)

    -- Enable pvp
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(playerPed, true, true)

  end)
end)

Citizen.CreateThread(function()
    RequestAnimDict('facials@gen_male@variations@normal')
    RequestAnimDict('mp_facial')

    while true do
        Citizen.Wait(300)
        local myId = PlayerId()

        for _,player in ipairs(GetActivePlayers()) do
            local boolTalking = NetworkIsPlayerTalking(player)

            if player ~= myId then
                if boolTalking and not talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
                    talkingPlayers[player] = true
                elseif not boolTalking and talkingPlayers[player] then
                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
                    talkingPlayers[player] = nil
                end
            end
        end
    end
end)