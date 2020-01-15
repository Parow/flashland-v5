locksound = false
local wait = 15
local count = 60
local dead = false
local weaponHashType = { "inconnue", "dégâts de mêlée", "blessure par balle", "chute", "dégâts explosifs", "feu", "chute", "éléctrique", "écorchure", "gaz", "gaz", "eau" }
local boneTypes = {
	["Dos"] = {0, 23553, 56604, 57597},
	["Crâne"] = {1356, 11174, 12844, 17188, 17719, 19336, 20178, 20279, 20623, 21550, 25260, 27474, 29868, 31086, 35731, 43536, 45750, 46240, 47419, 47495, 49979, 58331, 61839, 39317},
	["Coude droit"] = {2992},
	["Coude gauche"] = {22711},
	["Main gauche"] = {4089, 4090, 4137, 4138, 4153, 4154, 4169, 4170, 4185, 4186, 18905, 26610, 26611, 26612, 26613, 26614, 60309},
	["Main droite"] = {6286, 28422, 57005, 58866, 58867, 58868, 58869, 58870, 64016, 64017, 64064, 64065, 64080, 64081, 64096, 64097, 64112, 64113},
	["Bras gauche"] = {5232, 45509, 61007, 61163},
	["Bras droit"] = {28252, 40269, 43810},
	["Jambe droite"] = {6442, 16335, 51826, 36864},
	["Jambe gauche"] = {23639, 46078, 58271, 63931},
	["Pied droit"] = {20781, 24806, 35502, 52301},
	["Pied gauche"] = {2108, 14201, 57717, 65245},
	["Poîtrine"] = {10706, 64729, 24816, 24817, 24818},
	["Ventre"] = {11816 },
}
function tableHasValue(tbl, value, k)
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end
local deathTime, waitTime, deathCause = 0, 60 * 1000 * 5, {}
local function RespawnPed(ped, coords)
  --  coords = GetPlayerCoords()
    --dump(coords))
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
	ClearPedBloodDamage(ped)
	if RespawnToHospitalMenu ~= nil then
		RespawnToHospitalMenu.close()
		RespawnToHospitalMenu = nil
	end
end
local put = nil

local function canBeRevived()
	local bool = not DoesEntityExist(GetEntityAttachedTo(GetPlayerPed(-1)))
	if not bool then
		RageUI.Popup({message="~r~Votre situation vous contraint d'accéder à une réanimation."})
	end
	return bool
end

Citizen.CreateThread(function()
   while true do
       Citizen.Wait(0) 
        local Player = LocalPlayer()
        Player.isDead = dead
        
            if dead then 
                local ped = GetPlayerPed(-1)
				-- Citizen.Wait(0)
				
				-- 	StartScreenEffect("DeathFailOut", 0, 0)
				-- 	if not locksound then
                --     PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
				-- 	locksound = true
				-- 	end
				-- 	ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
					
				-- 	local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")

				-- 	if HasScaleformMovieLoaded(scaleform) then
				-- 		Citizen.Wait(0)

				-- 	PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
				-- 	BeginTextComponent("STRING")
				-- 	AddTextComponentString("~r~Vous êtes dans le coma")
				-- 	EndTextComponent()
				-- 	PopScaleformMovieFunctionVoid()

				--     Citizen.Wait(500)

				-- 	PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
                --     while Player.isDead do
                --         if IsControlJustReleased(0, 38) then
                --             TriggerServerEvent("user:RemoveMoney",Player.money ,false)
                --             Player.Inventory = {}
                --             TriggerServerEvent("user:RemoveAllInventory")
                --             RespawnPed(GetPlayerPed(-1),{x=358.13,y=-591.67,z=28.79})
                --             Player.isDead = false
                            
                --         end
                --         if IsControlJustReleased(0, Keys["X"]) then
                --             TriggerServerEvent("call:makeCall","lsms",GetPlayerCoords(),"Besoin d'un medecin!")
                --         end
                --         put = ShowNotification("~r~E~s~ pour réapparaitre\n~r~X~s~ pour appeller les médecins")
                --         DrawRect( 0.01,0.01, 2.073, 2.05,0, 0, 0, 255 )
                --       DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                      
				-- 	  Citizen.Wait(0)
                --     end

                -- --    RemoveNotification(put)
                     
				--   StopScreenEffect("DeathFailOut")
				--   locksound = false
                -- end
            
                ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
                SetTimecycleModifier("rply_vignette")
                Citizen.Wait(1000)
                while dead do
                    SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
                    drawTxt(.15, .85, .4, "Origine: ~p~" .. (deathCause[2] or "inconnue"), 4, nil, nil, 100)
                    drawTxt(.15, .875, .4, "Cause: ~p~" .. (deathCause[3] or "inconnue"), 4, nil, nil, 100)
                    drawTxt(.15, .90, .4, "Blessure: ~p~" .. (deathCause[4] or "inconnu"), 4, nil, nil, 100)
                    deathTime = deathTime or GetGameTimer()
                    local t = deathTime + waitTime

                    drawTimer(t - GetGameTimer(), true)
                    
    
                    local RespawnPressed, CallPressed = IsControlJustPressed(1, Keys["Y"]) , IsControlJustPressed(1, Keys["E"]) 
                    if (RespawnPressed or CallPressed) and canBeRevived() and (CallPressed or t < GetGameTimer()) then
                        if not CallPressed then
                            Player = LocalPlayer()
                            TriggerServerEvent("user:RemoveMoney",Player.money ,false)
                            Inventory.Inventory = {}
                            TriggerServerEvent("user:RemoveAllInventory")
                            RespawnPed(GetPlayerPed(-1),{x=358.13,y=-591.67,z=28.79})
                            dead = false
                        else
                            
                            RageUI.Popup({message="~b~Vous avez appelé les urgences."})
                            TriggerServerEvent("call:makeCall","lsms",GetPlayerCoords(),"Accident mortel")
                        end
                    end
                        Citizen.Wait(0)
                end

            end
            
    end
end)
function drawTimer(time, bl)
	DrawRect(0.22, 0.95, 0.14, 0.03, 0, 0, 0, 100)
	drawScrTxt(0.2275, 0.9475, 0.14, 0.03, 0, 0.325, "TEMPS:")
	drawScrTxt(0.2675, 0.945, 0.14, 0.03, 4, 0.45, bl and MilliSecondsToClock(time) or SecondsToClock(time))
end
local xSMS = 0.15
function drawScrTxt(x, y, w, h, f, s, text, outline, center, wr)
	SetTextFont(f)
	SetTextScale(s, s)
	SetTextColour(255, 255, 255, 255)
	if center then
		SetTextCentre(true)
	end
	SetTextDropShadow()
	if outline then
		SetTextOutline()
	end
	if wr then
		SetTextWrap(0.0, xSMS + 0.125)
	end
	SetTextEntry("jamyfafi")
	AddTextComponentString(text)
	if string.len(text) > 99 and AddLongString then AddLongString(text) end
	DrawText(x - w / 2, y - h / 2 + 0.005)
end

function RevivePlayer()
	local ped = PlayerPedId()
	NetworkResurrectLocalPlayer(GetEntityCoords(ped), 0, true, true, false)

	ped = GetPlayerPed(-1)
	SetEntityInvincible(ped, false)
	SetEntityHealth(ped, 125)
end
function SecondsToClock(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function MilliSecondsToClock(seconds)
	seconds = tonumber(seconds / 1000)

	if seconds <= 0 then
		return "00:00.00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		milli = string.format("%02.f", math.floor(seconds * 1000 - mins * 60000 - secs * 1000))
		return string.format("%s:%s.%s", mins, secs, milli)
	end
end
function drawTxt(x,y,scale, text, f,c,n, a)
	a = a or 255
	if not r then r = 255 g = 255 b = 255 end
	if not f then f = 4 end
	SetTextFont(f)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextCentre(c)
	if not n then
		SetTextDropShadow()
		SetTextOutline()
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(2, 0, 0, 0, 255)
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end


AddEventHandler('baseevents:onPlayerKilled', function(_, tab)

    Player = LocalPlayer()
    local ped = GetPlayerPed(-1)
    weapon = tab.weaponhash
    deathCause = table.pack(GetAllCauseOfDeath(GetPlayerPed(-1)))
    if GetWeapontypeGroup(weapon) == -728555052 or weapon == -1569615261 then
        Player.KO = true
    else
        Player.isDead = true
        RageUI.Popup({message="~r~Coma.\n~w~Voulez-vous contacter une ambulance?"})
        RageUI.Popup({message="Appeler: ~g~E ~w~ou ~r~Y"})
        deathTime = GetGameTimer() or 0
    end

    RevivePlayer()
    SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
    Player:Set("isBusy",true)
end)

function GetAllCauseOfDeath(ped)
	local exist, lastBone = GetPedLastDamageBone(ped)
	local cause, what, timeDeath = GetPedCauseOfDeath(ped), Citizen.InvokeNative(0x93C8B64DEB84728C, ped), Citizen.InvokeNative(0x1E98817B311AE98A, ped)
	if what and DoesEntityExist(what) then
		if IsEntityAPed(what) then
			what = "traces de combat"
		elseif IsEntityAVehicle(what) then
			what = "écrasé par un véhicule"
		elseif IsEntityAnObject(what) then
			what = "semble s'être pris un objet"
		end
	end
	what = type(what) == "string" and what or "inconnue"

	if cause then
		if IsWeaponValid(cause) then
			cause = weaponHashType[GetWeaponDamageType(cause)] or "inconnue"
		elseif IsModelInCdimage(cause) then
			cause = "véhicule"
		end
	end
	cause = type(cause) == "string" and cause or "mêlée"

	local boneName = "Dos"
	if exist and lastBone then
		for k,v in pairs(boneTypes) do
			if tableHasValue(v, lastBone) then boneName = k break end
		end
	end

	return timeDeath, what, cause, boneName
end

AddEventHandler('baseevents:onPlayerDied', function(_, _)
    deathCause = table.pack(GetAllCauseOfDeath(GetPlayerPed(-1)))
    dead = true
    local ped = GetPlayerPed(-1)
    RageUI.Popup({message="~r~Coma.\n~w~Voulez-vous contacter une ambulance?"})
    RageUI.Popup({message="Appeler: ~g~E ~w~ou ~r~Y"})
    deathTime = GetGameTimer() or 0
    RevivePlayer()
    SetPedToRagdoll(ped, 1000, 1000, 0, 1, 1, 0)
    Player:Set("isBusy",true)
end)
function startAttitude(_, anim)
    Citizen.CreateThread(function()
   
        local playerPed = GetPlayerPed(-1)
   
        RequestAnimSet(anim)
         
        while not HasAnimSetLoaded(anim) do
            Citizen.Wait(1)
        end
		SetPedMotionBlur(playerPed, false)
        SetPedMovementClipset(playerPed, anim, true)
    end)
 
end 
function createAnEffect(name, cam, time)
	Citizen.CreateThread(function()
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)

		SetTimecycleModifier(name or "spectator3")
		if cam then SetCamEffect(2) end
		DoScreenFadeIn(1000)

		Citizen.Wait(1000 * (time or effetTime))
		setSobre()
	end)
end
function setSobre()
	Citizen.CreateThread(function()
		local ped = LocalPlayer().Ped
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(ped, 0)
		SetPedIsDrunk(ped, false)
		SetCamEffect(0)
	end)
end
effetTime = 180
RegisterNetEvent('player:Revive')
AddEventHandler('player:Revive',function()
    playerCoords = {}
    playerPed = Citizen.InvokeNative(0x43A66C31C68491C0, -1) -- Use native GET_PLAYER_PED
    local coords = GetEntityCoords(playerPed)
    coords = { ["x"] = coords.x, ["y"] = coords.y, ["z"] = coords.z }
    local Player = LocalPlayer()
    dead  = false
    Player.KO = false
	local ped = Player.Ped

    DoScreenFadeOut(800)
    if IsEntityDead(ped) then RevivePlayer() end
    ped = GetPlayerPed(-1)
    RageUI.Popup({message="~g~Réanimation\n~w~Vous venez d'être réanimé, ~h~~r~vous êtes blessé."})
    ClearTimecycleModifier()
    createAnEffect("rply_vignette", true)
    ClearPedBloodDamage(ped)
    SetEntityHealth(ped, 150)
    SetEntityInvincible(ped, false)
    ClearAreaOfPeds(LocalPlayer().Pos, 6.0, 1)
    Player.isDead = false
    Player.KO = false
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
    Player:Set("isBusy",false)
    
    RespawnPed(GetPlayerPed(-1),coords)
    StartScreenEffect("PeyoteOut", 0, 0)
    Wait(2200)
    
    startAttitude("move_m@injured","move_m@injured")
end)
ClearTimecycleModifier()
DoScreenFadeIn(800)
Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = nil
					else killerinvehicle = false
					end
				end

				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    TriggerServerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                TriggerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })
                TriggerServerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })

                hasBeenDead = true
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                hasBeenDead = false
            end
        end
    end
end)

function GetPlayerByEntityID(id)
	for i=0,255 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end