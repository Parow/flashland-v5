local self = Inventory
local blocNote = true
local function ClosestVeh()
  if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
      return vehicleFct.GetVehicleInDirection()
  else
      return 0
  end
end
local defaulClothestvalue = {
  male = {
    [8] = 15,
    [3] = 15,
    [11] = 15,
    [6] = 34,
    [4] = 21
  },
  female = {
    [8] = 15,
    [3] = 15,
    [11] = 15,
    [6] = 35,
    [4] = 14
  }
}
function EquipClothes( )
  local item = Inventory.SelectedItem
  local male = isMale()
  if male then
    if item.data.type == 0 then
      if item.data.equiped and item.data.sex == "male"  then
        SetPedComponentVariation(GetPlayerPed(-1), item.data.component, defaulClothestvalue.male[item.data.component], 0)
        if item.data.component == 11 then

          SetPedComponentVariation(GetPlayerPed(-1), 8, defaulClothestvalue.male[8], 0)
          SetPedComponentVariation(GetPlayerPed(-1), 3, defaulClothestvalue.male[3], 0)
        end
      else

        SetPedComponentVariation(GetPlayerPed(-1), item.data.component, item.data.var, item.data.ind)
        if item.data.component == 11 then
          SetPedComponentVariation(GetPlayerPed(-1), 8,item.data.h,item.data.hV, 2)
          SetPedComponentVariation(GetPlayerPed(-1), 3, item.data.bras)
      end
      end 
      item.data.equiped = not item.data.equiped
    else
      if item.data.equiped and item.data.sex == "male"  then
        ClearPedProp(GetPlayerPed(-1), item.data.component)
      else
        SetPedPropIndex(GetPlayerPed(-1), item.data.component, item.data.var, item.data.ind)
      end
      item.data.equiped = not item.data.equiped
    end
  else
    if item.data.type == 0 then
      if item.data.equiped and item.data.sex == "female"  then
        SetPedComponentVariation(GetPlayerPed(-1), item.data.component, defaulClothestvalue.female[item.data.component], 0)
        if item.data.component == 11 then

          SetPedComponentVariation(GetPlayerPed(-1), 8, defaulClothestvalue.female[8], 0)
          SetPedComponentVariation(GetPlayerPed(-1), 3, defaulClothestvalue.female[3], 0)
        end
      else
        SetPedComponentVariation(GetPlayerPed(-1), item.data.component, item.data.var, item.data.ind)
      end
      item.data.equiped = not item.data.equiped
    else
      if item.data.equiped and item.data.sex == "female"  then
        ClearPedProp(GetPlayerPed(-1), item.data.component)
      else
        SetPedPropIndex(GetPlayerPed(-1), item.data.component, item.data.var, item.data.ind,2)
      end
      item.data.equiped = not item.data.equiped
    end
  end
  TriggerServerEvent("core:SyncItemWithBDD",item)
end
function EquipMasks()
  local item = Inventory.SelectedItem
  if item.data.equiped then
    playerPed = GetPlayerPed(-1)
    local dict = 'missfbi4'
    local myPed = PlayerPedId()
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    local animation = ''
    local flags = 0 -- only play the animation on the upper body
    animation = 'takeoff_mask'
    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(1000)
    SetEntityCollision(GetPlayerPed(-1), true, true)
    playerPed = GetPlayerPed(-1)
    Citizen.Wait(200)
    ClearPedTasks(playerPed)
    SetPedComponentVariation(GetPlayerPed(-1), item.data.component, 0, 0)
  else
    playerPed = GetPlayerPed(-1)
    local dict = 'missfbi4'
    local myPed = PlayerPedId()
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    local animation = ''
    local flags = 0 -- only play the animation on the upper body
    animation = 'takeoff_mask'
    TaskPlayAnim(myPed, dict, animation, 8.0, -8.0, -1, 50, 0, false, false, false)
    Citizen.Wait(1000)
    SetEntityCollision(GetPlayerPed(-1), true, true)
    playerPed = GetPlayerPed(-1)
    Citizen.Wait(200)
    ClearPedTasks(playerPed)
    SetPedComponentVariation(GetPlayerPed(-1), item.data.component, item.data.var, item.data.ind)
  end 
  item.data.equiped = not item.data.equiped
end
ItemsFunction = {
  herse = function() useHerse() end,
  usbkey = function() 
    local bool,m = isNearComputer()
    if bool then
        Wait(100)
        AddHackButton()
    end
  end,
  tel = function()
    local item = self.SelectedItem
    if item.data == nil or dump(item.data)== "null" then
      TriggerServerEvent("core:NewPhone",item)

      Wait(1000)
      data = json.decode(item.data)
      while data == nil do
          Wait(1)
      end
      TriggerServerEvent("core:SetNumber",data.num)
      Player.Number = data.num
    else
        data = json.decode(item.data)
        TriggerServerEvent("core:SetNumber",data.num)
        Player.Number = data.num
        
    end
  end,
  blocnote = function()
    local item = self.SelectedItem
    local data = item.data
    data = json.decode(data)
    if type(data) ~= "table" then
        data = json.decode(data)
    end
    text = KeyboardInput("~b~Combien ?", data.text, 255)
    if tostring(text) ~= nil then
        data.text = text
        TriggerServerEvent("ChangeItemData",item.id,data,item)
    end
  end,
  crochetage = function()
    local veh = ClosestVeh()
    if veh ~= 0 then
      self:RemoveItem()
        TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_WELDING', 0, true)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
        local rnadom = math.random(1,10)
        if rnadom >= 6 then
          SetVehicleDoorsLocked(veh, 1)
          SetVehicleDoorsLockedForAllPlayers(veh, false)
          RageUI.Popup({message="Véhicule ~g~déverouillé"})
        else
          RageUI.Popup({message="Vous avez ~r~raté"})
          local random = math.random(1,10)
          if random == 5 then
            local plyCoords = GetEntityCoords(GetPlayerPed(-1))
            local x,y,z = table.unpack(plyCoords)
            TriggerServerEvent("call:makeCall","police",{x=x,y=y,z=z},"J'ai vu quelqu'un crocheté un véhicule !")
          end
        end
    end
  end,
  identity = function()
    local CurrentItem = self.SelectedItem
    data = json.decode(CurrentItem.data)
    SendNUIMessage({ showIdentity = true,identity=data })

    Wait(10000)

    SendNUIMessage({ showIdentity = false })
  end,
  mask = EquipMasks,
  kevlar = EquipKev,
  clothe = EquipClothes,
  tenue = EquipTenue,
  menottes = Police.HandcuffPly,
  pinces = Police.CutMenottes,
  access = EquipClothes,
  bouteille_vin = drinkAlcool,
  sac = OpenSac,
  coke1 = eatCoke,
  meth1 = eatMeth,
  lsd = eatLSD,
  hero = eatHero,
  mdma = eatMdma,
  shield = function() createShield() end,
  cana = eatCana,
  darknet = sendDarknetMessage,
  gants = toggleGloves,
  roulant = toggleRoulant,
  medikit = function()
    SetEntityHealth(GetPlayerPed(-1,200))
    self:RemoveItem()
  end,
  mec = function()
    SetEntityHealth(GetPlayerPed(-1), GetEntityHealth(GetPlayerPed(-1))+50.0)
    self:RemoveItem()
  end,
  moteur = RepairMotor,
  fikit = RepairCaro,
  roue = RepairRoue,
  lavage = function()
    local vehicle = ClosestVeh()
    if vehicle ~= 0 then
        TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_MAID_CLEAN', 0, true)
        player = LocalPlayer()
        player.isBusy = true
        Citizen.CreateThread(function()
            Citizen.Wait(10000)

            SetVehicleDirtLevel(vehicle, 0)
            ClearPedTasksImmediately(GetPlayerPed(-1))

            RageUI.Popup({message="Véhicule ~g~nettoyé"})
            player.isBusy = false
        end)
        self:RemoveItem()
    else
        RageUI.Popup({message="~r~Aucun véhicule"})
    end
  end,
}

function EquipWeapon()
    local name = weapon_name[Inventory.SelectedItem.name]
    if HasPedGotWeapon(GetPlayerPed(-1),GetHashKey(name),false) then -- Test if player have the Weapon

        RemoveWeaponFromPed(playerPed,GetHashKey(name))
    else
    local playerPed = GetPlayerPed(-1)
        SetPedAmmo(GetPlayerPed(-1),GetHashKey(name),0)
        GiveWeaponToPed(playerPed,GetHashKey(name),0,false,true)
        local data = Inventory.SelectedItem.data
        if data.tint ~= nil then
            SetPedWeaponTintIndex(playerPed,GetHashKey(name),data.tint)
        end
        --dump(data.access))
        if data.access ~= nil then
            for i = 1, #data.access,1 do
                GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(name), GetHashKey(data.access[i]))
            end
        end

        cp = nil


        for k,v in pairs(weapon_name) do
            if v == name then
                cp = k
            end
        end
        for k, v in pairs(Inventory.Inventory) do
            if k == weapon_munition[cp] then
                SetPedAmmo(GetPlayerPed(-1),GetHashKey(name),#v)
                Inventory.CurrentAmmo = #v
                break
            else
              Inventory.CurrentAmmo = 0
            end
        end
        Inventory.CurrentWeapon.Name = GetHashKey(name)
        Inventory.CurrentWeapon.Label = name
        Inventory.CurrentMunition = weapon_munition[cp]
        Inventory.IsArmed = true
    end




end


Citizen.CreateThread(function()
  while true do 
      Wait(0)
      playerPed = GetPlayerPed(-1)
      if IsPedShooting(playerPed) then
          if Inventory.Inventory[Inventory.CurrentMunition] ~= nil then
              item = Inventory.Inventory[Inventory.CurrentMunition][1].id
              Inventory.CurrentAmmo = Inventory.CurrentAmmo - 1
              TriggerServerEvent("inventory:RemoveItem",Inventory.Inventory[Inventory.CurrentMunition][1].id,Inventory.Inventory[Inventory.CurrentMunition][1].name)
          end
      end
  end

end)



function DeleteHerse()
  local playerPed = PlayerPedId()
  local coords    = GetEntityCoords(playerPed)

  local closestDistance = -1
  local closestEntity   = nil
  local object = GetClosestObjectOfType(coords, 3.0, GetHashKey('p_ld_stinger_s'), false, false, false)

  if DoesEntityExist(object) then
    local objCoords = GetEntityCoords(object)
    local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

    if closestDistance == -1 or closestDistance > distance then
      DeleteEntity(object)
    else
      ShowNotification("~r~Vous êtes trop loin d'une herse")
    end
  end
end




















local gloves = {}
local gloveModel = GetHashKey("prop_boxing_glove_01")
function toggleGloves()
	for k,v in pairs(gloves) do DeleteEntity(v) end
	if tableCount(gloves) > 0 then gloves = {} return end

	if not HasModelLoaded(gloveModel) then
		RequestModel(gloveModel)
		while not HasModelLoaded(gloveModel) do Citizen.Wait(100) end
	end

	local Player = LocalPlayer()
	local ped, plyPos = Player.Ped, Player.Pos

	local firstGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
	local secondGlove = CreateObject(gloveModel, plyPos, 1, 0, 0)
	table.insert(gloves, firstGlove)
	table.insert(gloves, secondGlove)

	for k,v in pairs(gloves) do
		SetEntityAsMissionEntity(v, 1, 1)
	--	SetEntityCollision(v, 1, 0)
	end

	AttachEntityToEntity(firstGlove, ped, GetPedBoneIndex(ped, 6286), vector3(-0.1, 0.01, -0.01), vector3(90.0, 0.0, 90.0), 0, 0, 0, 0, 0, 1)
	AttachEntityToEntity(secondGlove, ped, GetPedBoneIndex(ped, 36029), vector3(-0.1, 0.02, 0.02), vector3(-90.0, 0.0, -90.0), 0, 0, 0, 0, 0, 1)
	ShowAboveRadarMessage("Vous avez équipé ~g~vos gants~w~.")
end
SpawnObject = function(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, true, true)

		if cb ~= nil then
			cb(obj)
		end
	end)
end
function useHerse()
  self:RemoveItem()
  local playerPed = PlayerPedId()
  local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
  local objectCoords = (coords + forward * 1.0)
  SpawnObject('p_ld_stinger_s', objectCoords, function(obj)
    SetEntityHeading(obj, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(obj)
  end)
end
function EnterZoneEntity()

end

function ExitZoneEntity()

end
-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'p_ld_stinger_s',
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then

          local playerPed = PlayerPedId()
          local coords    = GetEntityCoords(playerPed)
      
          if IsPedInAnyVehicle(playerPed, false) then
            local vehicle = GetVehiclePedIsIn(playerPed)
      
            for i=0, 7, 1 do
              SetVehicleTyreBurst(vehicle, i, true, 1000)
            end
          end
        
				LastEntity = closestEntity
			end
		else
      if LastEntity then
        ExitZoneEntity(LastEntity)
				TriggerEvent('esx_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

local shieldActive = false
local shieldEntity = nil
local hadPistol = false

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = "prop_ballistic_shield"
local pistol = GetHashKey("WEAPON_PISTOL")

function createShield()
    if shieldActive then
        DisableShield()
    else
        EnableShield()
    end
end

function EnableShield()
    shieldActive = true
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey(prop))
    while not HasModelLoaded(GetHashKey(prop)) do
        Citizen.Wait(100)
    end

    local shield = CreateObject(GetHashKey(prop), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

    SetEnableHandcuffs(ped, true)
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
        if shieldActive then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Citizen.Wait(500)
    end
end)