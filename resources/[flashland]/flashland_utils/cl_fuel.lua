
petrolCanPrice = 20

lang = "fr"
-- lang = "fr"
blacklistedModels = { -- Vehicles which doesn't need fuel
	"BMX",
	"CRUISER",
	"TRIBIKE2",
	"FIXTER",
	"SCORCHER",
	"TRIBIKE3",
	"TRIBIKE"
}


electric_model = {
	"VOLTIC",
	"SURGE",
	"DILETTANTE",
	"KHAMELION",
	"CADDY",
	"CADDY2",
	"AIRTUG"
}


plane_model = {
	"BESRA",
	"CARGOPLANE",
	"CUBAN800",
	"DODO",
	"DUSTER",
	"HYDRA",
	"JET",
	"LUXOR",
	"LUXOR2",
	"STUNT",
	"MAMMATUS",
	"MILJET",
	"NIMBUS",
	"LAZER",
	"SHAMAL",
	"TITAN",
	"VELUM",
	"VELUM2",
	"VESTRA"
}


heli_model = {
	"ANNIHILATOR",
	"BUZZARD",
	"BUZZARD2",
	"CARGOBOB",
	"CARGOBOB2",
	"CARGOBOB3",
	"FROGGER",
	"FROGGER2",
	"MAVERICK",
	"POLMAV",
	"SAVAGE",
	"SKYLIFT",
	"SVOLITO",
	"SVOLITO2",
	"SWIFT",
	"SWIFT2",
	"VALKYRIE",
	"VALKYRIE2",
	"VOLATUS"
}
settings = {}
settings["en"] = {
	openMenu = "Press ~g~E~w~ to open the menu.",
	electricError = "~r~You have an electric vehicle.",
	fuelError = "~r~You're not in the good place.",
	buyFuel = "buy fuel",
	liters = "liters",
	percent = "percent",
	confirm = "Confirm",
	fuelStation = "Fuel station",
	boatFuelStation = "Fuel station | Boat",
	avionFuelStation = "Fuel station | Plane ",
	heliFuelStation = "Fuel station | Helicopter",
	getJerryCan = "Press ~g~E~w~ to buy a Petrol can ("..petrolCanPrice.."$)",
	refuel = "Press ~g~E~w~ to refuel the car.",
	price = "price"
}

settings["fr"] = {
	openMenu = "Appuyez sur ~g~E~w~ pour ouvrir le menu.",
	electricError = "~r~Vous avez une voiture électrique.",
	fuelError = "~r~Vous n'êtes pas au bon endroit.",
	buyFuel = "acheter de l'essence",
	liters = "litres",
	percent = "pourcent",
	confirm = "Valider",
	fuelStation = "Station essence",
	boatFuelStation = "Station d'essence | Bateau",
	avionFuelStation = "Station d'essence | Avions",
	heliFuelStation = "Station d'essence | Hélicoptères",
	getJerryCan = "Appuyez sur ~g~E~w~ pour acheter un bidon d'essence ("..petrolCanPrice.."$)",
	refuel = "Appuyez sur ~g~E~w~ pour remplir votre voiture d'essence.",
	price = "prix"
}


showBar = true
showText = true


hud_form = 1 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.086
hud_y = 0.9883

text_x = 0.2575
text_y = 0.975


electricityPrice = 1 -- NOT RANOMED !!

randomPrice = false --Random the price of each stations
price = 1 --If random price is on False, set the price here for 1 liter
essence = 0.142
local stade = 0
local lastModel = 0

local vehiclesUsed = {}

local currentCans = 0


Citizen.CreateThread(function()
	TriggerServerEvent("essence:addPlayer")
	while true do
		Citizen.Wait(2)
		if not IsPedInAnyVehicle(GetPlayerPed(-1), -1) then
			
			Citizen.Wait(2000)
		else
			
		
		CheckVeh()
		renderBoxes()

		if(currentCans > 0) then
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
			local veh = GetClosestVehicle(x, y, z, 4.001, 0, 70)
			if(GetVehicleNumberPlateText(veh) == nil) then
				Citizen.Wait(15000)
			end
			if(GetVehicleNumberPlateText(veh) ~= nil) then
				local _, number = GetCurrentPedWeapon(GetPlayerPed(-1))

				if(number == 883325847) then
					Info(settings[lang].refuel)
					if(IsControlJustPressed(1, 38)) then

						RequestAnimDict("weapon@w_sp_jerrycan")
						while not HasAnimDictLoaded("weapon@w_sp_jerrycan") do
							Citizen.Wait(100)
						end

						local toPercent = essence/0.142
						print(5000/toPercent)

						TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire", 8.0, -8, -1, 49, 0, 0, 0, 0)
						local done = false
						local amountToEssence = 0.142-essence
						while done == false do
							Wait(0)
							local _essence = essence
							if(amountToEssence-0.0005 > 0) then
								amountToEssence = amountToEssence-0.0005
								essence = _essence + 0.0005
								_essence = essence
								if(_essence > 0.142) then
									essence = 0.142
									TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(veh), GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
									done = true
								end
								SetVehicleUndriveable(veh, true)
								SetVehicleEngineOn(veh, false, false, false)
								local essenceToPercent = (essence/0.142)*65
								SetVehicleFuelLevel(veh,round(essenceToPercent))
								Wait(100)
							else
								essence = essence + amountToEssence
								local essenceToPercent = (essence/0.142)*65
								SetVehicleFuelLevel(veh,round(essenceToPercent))
								TriggerEvent("advancedFuel:setEssence", 100, GetVehicleNumberPlateText(veh), GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
								done = true
							end
						end
						TaskPlayAnim(GetPlayerPed(-1),"weapon@w_sp_jerrycan","fire_outro", 8.0, -8, -1, 49, 0, 0, 0, 0)
						Wait(500)
						ClearPedTasks(GetPlayerPed(-1))
						currentCans = currentCans-1

						if(currentCans == 0) then
							RemoveWeaponFromPed(GetPlayerPed(-1),  0x34A67B97)
						end
						SetVehicleEngineOn(veh, true, false, false)
						SetVehicleUndriveable(veh, false)
					end
				end
			end
		end
	
end
	end

end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)
		if  (not IsPedInAnyVehicle(GetPlayerPed(-1), -1)) then
			Citizen.Wait(20000)
		else

		if  (IsPedInAnyVehicle(GetPlayerPed(-1), -1)) then
		if(IsPedInAnyVehicle(GetPlayerPed(-1), -1) and GetPedVehicleSeat(GetPlayerPed(-1)) == -1 and not isBlackListedModel()) then
			local kmh = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6
			local vitesse = math.ceil(kmh)

			if(vitesse > 0 and vitesse <20) then
				stade = 0.00001
			elseif(vitesse >= 20 and vitesse <50) then
				stade = 0.00002
			elseif(vitesse >= 50 and vitesse < 70) then
				stade = 0.00003
			elseif(vitesse >= 70 and vitesse <90) then
				stade = 0.00004
			elseif(vitesse >=90 and vitesse <130) then
				stade = 0.00005
			elseif(vitesse >= 130) then
				stade = 0.00006
			else
				stade = 0.0000001
			end

			if(essence - stade > 0) then
				essence = essence - stade
				local essenceToPercent = (essence/0.142)*65
				SetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1)),round(essenceToPercent))
			else
				essence = 0
				SetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1)),0)
				SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
			end			
		end
	end
end
end
end)

-- 0.0001 pour 0 à 20, 0.142 = 100%
-- Donc 0.0001 km en moins toutes les 10 secondes
RegisterNetEvent("getess")
AddEventHandler("getess", function()
	renderBoxes()
end)
local lastPlate = 0
local refresh = true
function CheckVeh()
	if(IsPedInAnyVehicle(GetPlayerPed(-1)) and not isBlackListedModel()) then

		--if((lastPlate == GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) and lastModel ~= GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) or (lastPlate ~= GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) and lastModel == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) or (lastPlate ~= GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) and lastModel ~= GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) then
		if(refresh) then
			TriggerServerEvent("vehicule:getFuel", GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))))
			lastModel = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))
			lastPlate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)))
		end
		refresh = false
	else
		if(not refresh) then
			TriggerServerEvent("essence:setToAllPlayerEscense", essence, lastPlate, lastModel)
			refresh = true
		end
	end



	if(essence == 0 and GetVehiclePedIsUsing(GetPlayerPed(-1)) ~= nil) then
		SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), false, false, false)
	end
end
Citizen.CreateThread(function()
while true do
Citizen.Wait(100)
--Citizen.Wait(5000)
	if essence == 0.142 then
		Citizen.Wait(5000)
	else
		local percent = (essence/0.142)*100
	end
	
	
	


end

end)
function drawRct2(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
function renderBoxes()
	if(IsPedInAnyVehicle(GetPlayerPed(-1), -1) and GetPedVehicleSeat(GetPlayerPed(-1)) == -1 and not isBlackListedModel()) then

	
				local percent = (essence/0.142)*100
				
			--	DrawAdvancedText(text_x, text_y, 0.005, 0.0028, 0.4,round(percent,1).."%", 255, 255, 255, 255, 0, 1)
			
		
			if(showBar) then 
				
				drawRct2(hud_x-0.073, hud_y-0.005, 0.145, 0.015,0,0,0,180)
				drawRct2(hud_x-0.071, hud_y-0.0025, essence,0.010,	241, 196, 15,255) 
		--		DrawRect(hud_x, hud_y, 0.142, 0.0119999999999998, 255, 255, 255, 255)
				if percent > 50 then
				--	DrawRect(hud_x, hud_y +0.0005, essence, 0.0079999999999998, 255, 215, 0, 185)
				else

				--	DrawRect(hud_x, hud_y +0.0005, essence, 0.0079999999999998, 255, 48, 48, 185)
				end
			end

			if(showText) then
				local percent = (essence/0.142)*100
				TriggerEvent("sendessence", percent)
		--		DrawAdvancedText(text_x, text_y, 0.005, 0.0028, 0.4,round(percent,1).."%", 255, 255, 255, 255, 0, 1)
			end
		
	end
end








function isNearStation()
	local ped = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

	for _,items in pairs(station) do
		if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 3) then
			return true, items.s
		end
	end

	return false
end


function isNearPlaneStation()
	local ped = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

	for _,items in pairs(avion_stations) do
		if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 10) then
			return true, items.s
		end
	end

	return false
end


function isNearHeliStation()
	local ped = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

	for _,items in pairs(heli_stations) do
		if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 10) then
			return true, items.s
		end
	end

	return false
end


function isNearBoatStation()
	local ped = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

	for _,items in pairs(boat_stations) do
		if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 10) then
			return true, items.s
		end
	end

	return false
end


function isNearElectricStation()
	local ped = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

	for _,items in pairs(electric_stations) do
		if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 2) then
			return true
		end
	end

	return false
end

--100% = 100L = 100$
-- 1% = 1L = 1


function Info(text, loop)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, loop, 1, 0)
end



function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end


function isBlackListedModel()
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1))))
	local isBL = false
	for _,k in pairs(blacklistedModels) do
		if(k==model) then
			isBL = true
			break;
		end
	end

	return isBL
end

function isElectricModel()
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1))))
	local isEL = false
	for _,k in pairs(electric_model) do
		if(k==model) then
			isEL = true
			break;
		end
	end

	return isEL
end


function isHeliModel()
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1))))
	local isHe = false
	for _,k in pairs(heli_model) do
		if(k==model) then
			isHe = true
			break;
		end
	end

	return isHe
end


function isPlaneModel()
	local model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1))))
	local isPl = false
	for _,k in pairs(plane_model) do
		if(k==model) then
			isPl = true
			break;
		end
	end

	return isPl
end


function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end


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



RegisterNetEvent("essence:setEssence")
AddEventHandler("essence:setEssence", function(ess,vplate,vmodel)
	if(ess ~= nil and vplate ~= nil and vmodel ~=nil) then
		local bool,index = searchByModelAndPlate(vplate,vmodel)

		if(bool and index ~=nil) then
			vehiclesUsed[index].es = ess
		else
			table.insert(vehiclesUsed, {plate = vplate, model = vmodel, es = ess})
		end
	end
end)




RegisterNetEvent("essence:hasBuying")
AddEventHandler("essence:hasBuying", function(amount)
	local amountToEssence = (amount/60)*0.142
	print("k")
	local done = false
	while done == false do
		Wait(0)
		local _essence = essence
		if(amountToEssence-0.0005 > 0) then
			amountToEssence = amountToEssence-0.0005
			essence = _essence + 0.0005
			_essence = essence
			if(_essence > 0.142) then
				essence = 0.142
				done = true
			end
			SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
			SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), false, false, false)
			local essenceToPercent = (essence/0.142)*65
			SetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1)),round(essenceToPercent))
			Wait(100)
		else
			essence = essence + amountToEssence
			local essenceToPercent = (essence/0.142)*65
			SetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1)),round(essenceToPercent))
			done = true
		end
	end

	TriggerServerEvent("essence:setToAllPlayerEscense", essence, GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))))


	SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
	SetVehicleEngineOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), true, false, false)
end)



RegisterNetEvent("essence:buyCan")
AddEventHandler("essence:buyCan", function()

	GiveWeaponToPed(GetPlayerPed(-1), 0x34A67B97, currentCans+1,  0, true)
	currentCans = currentCans +1
end)


RegisterNetEvent("vehicule:sendFuel")
AddEventHandler("vehicule:sendFuel", function(bool, ess)

	if(bool == 1) then
		essence = ess
	else
		essence = (math.random(30,100)/100)*0.142
		--table.insert(vehiclesUsed, {plate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), model = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))), es = essence})
		vehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
		TriggerServerEvent("essence:setToAllPlayerEscense", essence, GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))), GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1)))))
	--	TriggerEvent("sendessence", percent)
	end

end)

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end


AddEventHandler("playerSpawned", function()
	TriggerServerEvent("essence:playerSpawned")
	TriggerServerEvent("essence:addPlayer")
end)


RegisterNetEvent("showNotif")
AddEventHandler("showNotif", function(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end)







RegisterNetEvent("advancedFuel:setEssence")
AddEventHandler("advancedFuel:setEssence", function(percent, plate, model)
	local toEssence = (percent/100)*0.142

	if(GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) == plate and model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) then
		essence = toEssence
		local essenceToPercent = (essence/0.142)*65
		SetVehicleFuelLevel(GetVehiclePedIsIn(GetPlayerPed(-1)),round(essenceToPercent))
	end

	TriggerServerEvent("advancedFuel:setEssence_s",percent,plate,model)
end)


RegisterNetEvent('essence:sendEssence')
AddEventHandler('essence:sendEssence', function(array)
	for i,k in pairs(array) do
		vehiclesUsed[i] = {plate=k.plate,model=k.model,es=k.es}
	end
end)





function IsVehInArray()
	for _,k in pairs(vehiclesUsed) do
		if(k.plate == GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) and k.model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) then
			return true
		end
	end

	return false
end


function searchByModelAndPlate(plate, model)
	for i,k in pairs(vehiclesUsed) do
		if(k.plate == plate and k.model == model) then
			return true, i
		end
	end

	return false, nil
end


function getVehIndex()
	local index = -1

	for i,k in pairs(vehiclesUsed) do
		if(k.plate == GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1))) and k.model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(GetPlayerPed(-1))))) then
			index = i
		end
	end

	return index
end





showBar = true
showText = true


hud_form = 1 -- 1 : Vertical | 2 = Horizontal
hud_x = 0.086
hud_y = 0.9883

text_x = 0.2575
text_y = 0.975


electricityPrice = 1 -- NOT RANOMED !!

randomPrice = false --Random the price of each stations
price = 1 --If random price is on False, set the price here for 1 liter

local blipNameFuel = settings[lang].fuelStation
local blipNameFuelBoat = settings[lang].boatFuelStation
local blipNameFuelAvions = settings[lang].avionFuelStation
local blipNameFuelHeli = settings[lang].heliFuelStation

--[[
================================================= COORDS =================================================
]]--
local blips = {

    {name=blipNameFuel, id=361, x=49.4187,   y=2778.793,  z=58.043},
    {name=blipNameFuel, id=361, x=263.894,   y=2606.463,  z=44.983},
    {name=blipNameFuel, id=361, x=1039.958,  y=2671.134,  z=39.550},
    {name=blipNameFuel, id=361, x=1207.260,  y=2660.175,  z=37.899},
    {name=blipNameFuel, id=361, x=2539.685,  y=2594.192,  z=37.944},
    {name=blipNameFuel, id=361, x=2679.858,  y=3263.946,  z=55.240},
    {name=blipNameFuel, id=361, x=2005.055,  y=3773.887,  z=32.403},
    {name=blipNameFuel, id=361, x=1687.156,  y=4929.392,  z=42.078},
    {name=blipNameFuel, id=361, x=1701.314,  y=6416.028,  z=32.763},
    {name=blipNameFuel, id=361, x=179.857,   y=6602.839,  z=31.868},
    {name=blipNameFuel, id=361, x=-94.4619,  y=6419.594,  z=31.489},
    {name=blipNameFuel, id=361, x=-2554.996, y=2334.40,  z=33.078},
    {name=blipNameFuel, id=361, x=-1800.375, y=803.661,  z=138.651},
    {name=blipNameFuel, id=361, x=-1437.622, y=-276.747,  z=46.207},
    {name=blipNameFuel, id=361, x=-2096.243, y=-320.286,  z=13.168},
    {name=blipNameFuel, id=361, x=-724.619, y=-935.1631,  z=19.213},
    {name=blipNameFuel, id=361, x=-526.019, y=-1211.003,  z=18.184},
    {name=blipNameFuel, id=361, x=-70.2148, y=-1761.792,  z=29.534},
    {name=blipNameFuel, id=361, x=265.648,  y=-1261.309,  z=29.292},
    {name=blipNameFuel, id=361, x=819.653,  y=-1028.846,  z=26.403},
    {name=blipNameFuel, id=361, x=1208.951, y= -1402.567, z=35.224},
    {name=blipNameFuel, id=361, x=1181.381, y= -330.847,  z=69.316},
    {name=blipNameFuel, id=361, x=620.843,  y= 269.100,  z=103.089},
    {name=blipNameFuel, id=361, x=2581.321, y=362.039, z=108.468},

    --------- BOATS ---------
    {name=blipNameFuelBoat, id=427, x=-802.513, y=-1504.675,z=1.305},
    {name=blipNameFuelBoat,id=427,x=3855.96,y=4465.36,z=2.71},


    --------- AVIONS ---------
    {name = blipNameFuelAvions, id=251,x=-1229.625,y=-2877.264,z=13.945},

    --------- Helicopters ---------
    {name = blipNameFuelHeli, id=43,x=-1112.407,y=-2883.893,z=13.946},
}




station = {
    {x=-82.098,y=-1761.612,z=29.635,s=1},
    {x=-79.506,y=-1754.321,z=29.604,s=1},
    {x=-78.241,y=-1762.897,z=29.592,s=1},
    {x=-75.489,y=-1756.029,z=29.603,s=1},
    {x=-73.959,y=-1764.495,z=29.427,s=1},
    {x=-71.135,y=-1757.619,z=29.42,s=1},
    {x=-70.017,y=-1765.910,z=29.356,s=1},
    {x=-67.389,y=-1758.793,z=29.366,s=1},
    {x=-65.458,y=-1767.296,z=29.138,s=1},
    {x=-62.760,y=-1760.176,z=29.133,s=1},
    {x=-61.468,y=-1768.718,z=29.077,s=1},
    {x=-59.106,y=-1761.805,z=29.078,s=1},



    {x=1214.171,y=-1405.432,z=35.224,s=2},
    {x=1211.517,y=-1408.289,z=35.198,s=2},
    {x=1211.747,y=-1402.370,z=35.224,s=2},
    {x=1208.667,y=-1405.622,z=35.224,s=2},
    {x=1208.224,y=-1399.316,z=35.224,s=2},
    {x=1205.354,y=-1402.141,z=35.224,s=2},
    {x=1205.686,y=-1397.004,z=35.224,s=2},
    {x=1202.977,y=-1399.678,z=35.224,s=2},

    {x=254.526,y=-1268.720,z=29.148,s=3},
    {x=254.465,y=-1261.328,z=29.145,s=3},
    {x=254.431,y=-1253.17,z=29.193,s=3},
    {x=258.271,y=-1268.676,z=29.143,s=3},
    {x=258.309,y=-1261.318,z=29.143,s=3},
    {x=258.324,y=-1253.436,z=29.143,s=3},
    {x=263.091,y=-1268.743,z=29.143,s=3},
    {x=263.130,y=-1261.356,z=29.143,s=3},
    {x=263.058,y=-1253.579,z=29.143,s=3},
    {x=266.983,y=-1268.678,z=29.144,s=3},
    {x=266.964,y=-1261.245,z=29.143,s=3},
    {x=266.801,y=-1253.554,z=29.143,s=3},
    {x=272.069,y=-1268.790,z=29.145,s=3},
    {x=271.992,y=-1261.357,z=29.143,s=3},
    {x=271.987,y=-1253.431,z=29.143,s=3},
    {x=275.562,y=-1253.391,z=29.159,s=3},
    {x=275.751,y=-1261.135,z=29.161,s=3},
    {x=275.746,y=-1268.520,z=29.164,s=3},

    {x=-517.408,y=-1207.231,z=18.265,s=4},
    {x=-520.156,y=-1205.908,z=18.245,s=4},
    {x=-524.803,y=-1203.655,z=18.236,s=4},
    {x=-527.604,y=-1202.526,z=18.228,s=4},
    {x=-529.784,y=-1207.092,z=18.185,s=4},
    {x=-526.845,y=-1208.236,z=18.185,s=4},
    {x=-522.081,y=-1210.286,z=18.185,s=4},
    {x=-519.478,y=-1211.580,z=18.185,s=4},
    {x=-521.226,y=-1215.387,z=18.185,s=4},
    {x=-524.0596,y=-1214.104,z=18.185,s=4},
    {x=-528.617,y=-1212.008,z=18.185,s=4},
    {x=-531.552,y=-1210.861,z=18.185,s=4},
    {x=-533.238,y=-1214.797,z=18.222,s=4},
    {x=-530.4897,y=-1216.199,z=18.226,s=4},
    {x=-525.775,y=-1218.204,z=18.2196,s=4},
    {x=-523.142,y=-1219.551,z=18.223,s=4},


    {x=-712.8,y=-939.076,z=19.017,s=5},
    {x=-712.671,y=-932.42,z=19.017,s=5},
    {x=-717.642,y=-932.702,z=19.017,s=5},
    {x=-717.805,y=-939.401,z=19.017,s=5},
    {x=-721.448,y=-939.311,z=19.017,s=5},
    {x=-721.194,y=-932.431,z=19.017,s=5},
    {x=-726.673,y=-932.539,z=19.017,s=5},
    {x=-726.786,y=-939.402,z=19.017,s=5},
    {x=-729.805,y=-939.128,z=19.017,s=5},
    {x=-729.859,y=-932.606,z=19.017,s=5},
    {x=-735.479,y=-932.548,z=19.017,s=5},
    {x=-735.46,y=-939.304,z=19.017,s=5},

    {x=829.205,y=-1026.126,z=26.639,s=6},
    {x=829.19,y=-1030.921,z=26.644,s=6},
    {x=825.634,y=-1031.114,z=26.411,s=6},
    {x=825.527,y=-1026.295,z=26.383,s=6},
    {x=821.075,y=-1026.074,z=26.256,s=6},
    {x=821.109,y=-1030.78,z=26.288,s=6},
    {x=817.243,y=-1030.984,z=26.298,s=6},
    {x=817.062,y=-1026.27,z=26.264,s=6},
    {x=812.567,y=-1026.071,z=26.24,s=6},
    {x=812.552,y=-1030.897,z=26.293,s=6},
    {x=808.941,y=-1030.992,z=26.287,s=6},
    {x=808.542,y=-1026.427,z=26.254,s=6},

    {x=1186.53,y=-340.309,z=69.174,s=7},
    {x=1179.598,y=-341.844,z=69.18,s=7},
    {x=1178.429,y=-337.235,z=69.179,s=7},
    {x=1185.646,y=-335.332,z=69.175,s=7},
    {x=1185.367,y=-332.38,z=69.174,s=7},
    {x=1178.171,y=-333.305,z=69.177,s=7},
    {x=1177.089,y=-328.684,z=69.176,s=7},
    {x=1184.271,y=-327.465,z=69.174,s=7},
    {x=1183.672,y=-323.215,z=69.174,s=7},
    {x=1176.257,y=-324.663,z=69.175,s=7},
    {x=1175.17,y=-319.89,z=69.174,s=7},
    {x=1182.66,y=-318.644,z=69.174,s=7},

    {x=-1437.312,y=-286.044,z=46.208,s=8},
    {x=-1446.43,y=-276.008,z=46.227,s=8},
    {x=-1443.389,y=-273.284,z=46.22,s=8},
    {x=-1434.062,y=-283.562,z=46.208,s=8},
    {x=-1430.493,y=-280.436,z=46.208,s=8},
    {x=-1439.556,y=-270.2,z=46.208,s=8},
    {x=-1436.778,y=-267.439,z=46.208,s=8},
    {x=-1427.062,y=-277.362,z=46.208,s=8},

    {x=-2107.887,y=-325.411,z=13.021,s=9},
    {x=-2107.643,y=-318.982,z=13.023,s=9},
    {x=-2106.943,y=-310.851,z=13.024,s=9},
    {x=-2102.681,y=-311.261,z=13.025,s=9},
    {x=-2103.46,y=-319.553,z=13.025,s=9},
    {x=-2104.055,y=-325.896,z=13.023,s=9},
    {x=-2099.485,y=-326.493,z=13.025,s=9},
    {x=-2098.887,y=-319.953,z=13.026,s=9},
    {x=-2097.994,y=-311.942,z=13.025,s=9},
    {x=-2093.86,y=-312.045,z=13.025,s=9},
    {x=-2094.759,y=-320.407,z=13.026,s=9},
    {x=-2095.541,y=-326.675,z=13.025,s=9},
    {x=-2090.85,y=-327.063,z=13.023,s=9},
    {x=-2090.183,y=-320.594,z=13.025,s=9},

    {x=-2089,y=-312.438,z=13.023,s=9},
    {x=-2085.3,y=-313.258,z=13.022,s=9},
    {x=-2086.29,y=-321.439,z=13.023,s=9},
    {x=-2087.07,y=-327.707,z=13.021,s=9},

    {x=610.642,y=263.84,z=103.089,s=11},
    {x=610.487,y=274.025,z=103.089,s=11},
    {x=614.158,y=273.897,z=103.089,s=11},
    {x=613.999,y=263.946,z=103.089,s=11},
    {x=618.761,y=263.787,z=103.089,s=11},
    {x=619.319,y=274.03,z=103.089,s=11},
    {x=622.839,y=274.157,z=103.089,s=11},
    {x=622.803,y=263.882,z=103.089,s=11},
    {x=628.062,y=263.682,z=103.089,s=11},
    {x=627.883,y=274.04,z=103.089,s=11},
    {x=631.485,y=273.982,z=103.089,s=11},
    {x=631.268,y=263.801,z=103.089,s=11},

    {x=2571.546,y=364.883,z=108.457,s=12},
    {x=2571.674,y=359.022,z=108.457,s=12},
    {x=2575.468,y=359.222,z=108.457,s=12},
    {x=2575.691,y=364.609,z=108.457,s=12},
    {x=2579.197,y=364.535,z=108.457,s=12},
    {x=2578.942,y=358.71,z=108.457,s=12},
    {x=2582.92,y=358.653,z=108.457,s=12},
    {x=2583.109,y=364.208,z=108.457,s=12},
    {x=2586.732,y=364.159,z=108.457,s=12},
    {x=2586.38,y=358.222,z=108.468,s=12},
    {x=2590.354,y=358.396,z=108.457,s=12},
    {x=2590.786,y=364.089,z=108.457,s=12},

    {x=-1804.793,y=793.065,z=138.515,s=13},
    {x=-1810.376,y=798.735,z=138.516,s=13},
    {x=-1807.252,y=801.005,z=138.522,s=13},
    {x=-1802.277,y=795.508,z=138.514,s=13},
    {x=-1798.711,y=799.15,z=138.523,s=13},
    {x=-1803.762,y=804.526,z=138.523,s=13},
    {x=-1801.253,y=807.34,z=138.513,s=13},
    {x=-1795.465,y=801.903,z=138.515,s=13},
    {x=-1792.444,y=804.804,z=138.513,s=13},
    {x=-1797.53,y=810.42,z=138.522,s=13},
    {x=-1794.563,y=813.348,z=138.513,s=13},
    {x=-1789.008,y=807.492,z=138.514,s=13},

    {x=-2551.511,y=2325.05,z=33.073,s=14},
    {x=-2558.042,y=2324.596,z=33.072,s=14},
    {x=-2558.206,y=2328.878,z=33.073,s=14},
    {x=-2551.687,y=2329.217,z=33.072,s=14},
    {x=-2552.436,y=2332.262,z=33.06,s=14},
    {x=-2558.387,y=2331.756,z=33.072,s=14},
    {x=-2558.517,y=2336.213,z=33.073,s=14},
    {x=-2552.635,y=2336.533,z=33.06,s=14},
    {x=-2552.219,y=2339.827,z=33.073,s=14},
    {x=-2558.59,y=2339.32,z=33.072,s=14},
    {x=-2558.816,y=2343.877,z=33.109,s=14},
    {x=-2552.367,y=2344.159,z=33.109,s=14},

    {x=49.162,y=2777.058,z=57.884,s=15},
    {x=47.811,y=2777.97,z=57.884,s=15},
    {x=50.043,y=2781.144,z=57.884,s=15},
    {x=51.367,y=2779.877,z=57.884,s=15},

    {x=262.636,y=2608.435,z=44.896,s=16},
    {x=265.346,y=2605.549,z=44.85,s=16},

    {x=1035.65,y=2672.706,z=39.551,s=17},
    {x=1043.192,y=2672.968,z=39.551,s=17},
    {x=1035.687,y=2666.274,z=39.551,s=17},
    {x=1043.431,y=2666.217,z=39.551,s=17},

    {x=1207.123,y=2662.956,z=37.81,s=18},
    {x=1209.731,y=2660.546,z=37.81,s=18},
    {x=1210.722,y=2659.631,z=37.81,s=18},

    {x=2538.21,y=2594.137,z=37.945,s=19},

    {x=2679.949,y=3261.648,z=55.241,s=20},
    {x=2682.505,y=3265.69,z=55.241,s=20},
    {x=2679.16,y=3267.362,z=55.241,s=20},
    {x=2676.994,y=3263.163,z=55.241,s=20},

    {x=2000.82,y=3774.122,z=32.181,s=21},
    {x=2003.129,y=3775.418,z=32.181,s=21},
    {x=2005.051,y=3776.813,z=32.181,s=21},
    {x=2008.517,y=3778.995,z=32.181,s=21},
    {x=2010.64,y=3774.883,z=32.181,s=21},
    {x=2006.902,y=3772.949,z=32.181,s=21},
    {x=2004.598,y=3771.526,z=32.181,s=21},
    {x=2002.138,y=3769.921,z=32.181,s=21},

    {x=1682.869,y=4932.726,z=42.07,s=22},
    {x=1685.909,y=4930.688,z=42.079,s=22},
    {x=1688.638,y=4928.758,z=42.078,s=22},
    {x=1691.594,y=4926.91,z=42.078,s=22},

    {x=1705.103,y=6412.621,z=32.747,s=23},
    {x=1700.705,y=6414.56,z=32.712,s=23},
    {x=1697.003,y=6416.653,z=32.672,s=23},
    {x=1698.584,y=6420.036,z=32.638,s=23},
    {x=1702.779,y=6418.326,z=32.64,s=23},
    {x=1706.708,y=6416.178,z=32.638,s=23},

    {x=189.383,y=6606.512,z=31.85,s=24},
    {x=184.984,y=6606.252,z=31.849,s=24},
    {x=181.602,y=6605.191,z=31.848,s=24},
    {x=177.916,y=6604.186,z=31.849,s=24},
    {x=174.111,y=6603.921,z=31.849,s=24},
    {x=170.189,y=6603.134,z=31.848,s=24},

    {x=-98.26,y=6417.974,z=31.458,s=25},
    {x=-92.331,y=6423.958,z=31.459,s=25},
    {x=-90.086,y=6421.26,z=31.484,s=25},
    {x=-95.719,y=6415.342,z=31.482,s=25}
}


electric_stations = {
    {x=-55.938,y=-1756.631,z=29.121},
    {x=1217.986,y=-1385.517,z=35.139},
    {x=286.122,y=-1264.363,z=29.284},
    {x=-545.695,y=-1222.068,z=18.279},
    {x=820.384,y=-1038.054,z=26.549},
    {x=-714.51,y=-919.327,z=19.014},
    {x=1170.2,y=-320.836,z=69.177},
    {x=-1414.777,y=-279.977,z=46.293},
    {x=-2076.135,y=-324.185,z=13.158},
    {x=626.667,y=249.346,z=103.046},
    {x=2563.333,y=353.385,z=108.464},
    {x=-1816.798,y=798.601,z=138.106},
    {x=2541.891,y=2609.431,z=37.945},
    {x=1189.907,y=2658.11,z=37.831},
    {x=1031.292,y=2660.109,z=39.551},
    {x=265.647,y=2600.547,z=44.774},
    {x=63.991,y=2787.675,z=57.88},
    {x=-2553.863,y=2321.008,z=33.06},
    {x=2680.59,y=3274.363,z=55.241},
    {x=1984.787,y=3783.526,z=32.181},
    {x=1696.633,y=4917.12,z=42.078},
    {x=1689.197,y=6435.085,z=32.559},
    {x=152.939,y=6629.043,z=31.717},
    {x=-92.825,y=6393.375,z=31.452}
}


boat_stations = {
    {x=-801.0068,y=-1507.842,z=1.03,s=26},
    {x=-803.487,y=-1501.317,z=1.03,s=26},
    {x=3855.96,y=4465.36,z=2.71,s=29}
}


avion_stations = {
    {x=-1229.625,y=-2877.264,z=13.945,s=31}
}


heli_stations = {
    {x=-1112.407,y=-2883.893,z=13.946,s=33}
}


stationsText = {}

stationsText[1] = {x=-74.592,y=-1760.252,z=31.918}
stationsText[2] = {x=1208.313,y=-1402.669,z=40.767}
stationsText[3] = {x=265.023,y=-1261.405,z=33.168}
stationsText[4] = {x=-529.663,y=-1209.177,z=21.466}
stationsText[5] = {x=-723.968,y=-934.613,z=21.266}
stationsText[6] = {x=818.99,y=-1027.275,z=31.054}
stationsText[7] = {x=1181.935,y=-330.186,z=71.619}
stationsText[8] = {x=-1434.47,y=-279.401,z=49.933}
stationsText[9] = {x=-2096.767,y=-320.107,z=15.805}
stationsText[11] = {x=620.982,y=268.854,z=104.687}
stationsText[12] = {x=2581.117,y=361.841,z=110.219}
stationsText[13] = {x=-1798.993,y=802.521,z=140.814}
stationsText[14] = {x=-2555.255,y=2334.299,z=34.852}
stationsText[15] = {x=49.59,y=2779.02,z=60.281}
stationsText[16] = {x=264.326,y=2606.995,z=46.209}
stationsText[17] = {x=1038.993,y=2667.874,z=41.174}
stationsText[18] = {x=1207.744,y=2660.217,z=39.659}
stationsText[19] = {x=2539.638,y=2594.742,z=40.245}
stationsText[20] = {x=2679.517,y=3263.776,z=57.554}
stationsText[21] = {x=2005.045,y=3774.279,z=33.887}
stationsText[22] = {x=1687.317,y=4929.79,z=43.837}
stationsText[23] = {x=1701.67,y=6416.484,z=35.091}
stationsText[24] = {x=179.988,y=6602.996,z=33.918}
stationsText[25] = {x=-94.239,y=6419.58,z=32.615}


--- Boats stations
stationsText[26] = {x=-802.513, y=-1504.675,z=2}
stationsText[27] = {x=7.313,y=-2777.435,z=3.451} 
stationsText[28] = {x=1326.863,y=4218.219,z=33.55}



stationsText[31] = {x=-1229.625,y=-2877.264,z=15.921}

--- Helicopters stations
stationsText[33] = {x=-1112.407,y=-2883.893,z=15.921}

--[[
================================================= FUNCTIONS =================================================
]]--

StationsPrice = {}

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      if AddBlipForCoord ~= nil then
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipAsShortRange(item.blip, true)
      SetBlipColour(item.blip,1)
      SetBlipScale(item.blip, 0.8)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
      end
    end
    if AddBlipForCoord ~= nil then
    TriggerServerEvent("essence:requestPrice")
    end
    Wait(5)

end)



function isNearStationMarker(items)
    local ped = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

    if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 250) then
        return true, GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    end

    return false
end


function isNearBoatStationMarker(items)
    local ped = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

    if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 250) then
        return true, GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    end

    return false
end


function isNearElectricStationMarker(items)
    local ped = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), 0)

    if(GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 250) then
        return true, GetDistanceBetweenCoords(items.x, items.y, items.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    end

    return false
end




function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("essence:sendPrice")
AddEventHandler("essence:sendPrice",function(st)
    StationsPrice = st
end)





local inMenu = false
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		if not IsPedInAnyVehicle(GetPlayerPed(-1), -1) then
			Citizen.Wait(25000)
		else
		------------------------------- VEHICLE FUEL PART -------------------------------
			if(IsControlJustPressed(1, 38)) then
				local isNearFuelStation, stationNumber = isNearStation()
				local isNearFuelPStation, _ = isNearPlaneStation()
				local isNearFuelHStation, _ = isNearHeliStation()
				local isNearFuelBStation, _ = isNearBoatStation()

				if isNearFuelStation or isNearFuelPStation or isNearFuelHStation or isNearFuelBStation then
				
					TriggerEvent("essence:OpenMenu",true)
					inMenu = true
				end
			end
		end
	end
end)



