local servicesxx = nil
function GetServicesJob(job)
    TriggerServerCallback('GetJobServices', function(service)
        servicesxx = service
    end)
end
local blip = nil
local libreServ  = false
local Pos = {x=-48.4,y=-1757.78,z=29.42}
local Blips = {
    name = "LTD",
    sprite = 52,
    color = 83
}
local _Items = Items
local Items = {
    {
        name = "water",
        price = 25,
    },
    {
        name = "bread",
        price = 50
    }
}
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
local function Open()
    RageUI.Visible(RMenu:Get('ltd', "libreservice"),true)
end
function no(ms)
    RageUI.Popup({message=ms})
end
local function Open1()
    no("Vous avez appelé un ~o~épicier")
    MakeCall("ltd")
end
local function EnterZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",Open,"LTD")
    KeySettings:Add("controller",46,Open,"LTD")

end
local function EnterZone1()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour appeller un épicier")
    KeySettings:Add("keyboard","E",Open1,"LTD")
    KeySettings:Add("controller",46,Open1,"LTD")

end
local function ExitZone()
    KeySettings:Clear("keyboard","E","Shop")
    KeySettings:Clear("controller","E","Shop")
    Hint:RemoveAll()
end
RMenu.Add('ltd', "libreservice", RageUI.CreateMenu(nil, "Objets disponibles",10,100))
Citizen.CreateThread(function()
    Wait(400)

    blip = AddBlipForCoord(Pos.x, Pos.y, Pos.z)
    SetBlipSprite (blip, Blips.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.1)
    SetBlipColour (blip,  Blips.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Blips.name)
    EndTextCommandSetBlipName(blip)
    while true do
        GetServicesJob()
        while servicesxx == nil do
            Wait(1)
        end
        if tablelength(servicesxx["ltd"]) == 0 then
            if libreServ == false then
                Zone:Remove(Pos)
                Zone:Add(Pos,EnterZone,ExitZone,"ltd",2.5)
                libreServ = true
            end
        else
            if libreServ == true then
                Zone:Remove(Pos)
                Zone:Add(Pos,EnterZone1,ExitZone,"ltd",2.5)
                libreServ = false
            end
        end
        Wait(5000)
    end
end)

function MakeCall(job,msg)
    local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
    TriggerServerEvent("call:makeCall", job, {x=plyPos.x,y=plyPos.y,z=plyPos.z}, msg)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('ltd', "libreservice")) then
            RageUI.DrawContent({ header = false, glare = false}, function()
                for i = 1 , #Items, 1 do
                    RageUI.Button(_Items[Items[i].name].label,nil,{RightLabel=Items[i].price.."$"},true,function(_,_,Selected)
                        if Selected then
                            local canbuy = Money:CanBuy(Items[i].price)
                            local canReceive = Inventory.CanReceive(Items[i].name,1)
                            if canbuy and canReceive then
                                items = {name=Items[i].name}
                                TriggerServerEvent("inventory:AddItem", items)
                                TriggerServerEvent("money:Pay",Items[i].price)
                            end
                        end
                    end)

                end
            end, function()
            end)
        end
    end
end)











local callActive = false
local haveTarget = false
local isCall = false
local work = {}
local target = {}
ShowAdvancedNotification = function(title, subject, msg, icon, iconType)
	SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        -- if IsControlJustPressed(1, 56) then
        --     local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
        --     TriggerServerEvent("call:makeCall", "uber", {x=plyPos.x,y=plyPos.y,z=plyPos.z})
        -- end

        -- Press Y key to get the call
        if IsControlJustPressed(1, 246) and callActive then
			if isCall == false then
				TriggerServerEvent("call:getCall", work)
				SendNotification("~b~Vous avez pris l'appel !")
				target.blip = AddBlipForCoord(target.pos.x, target.pos.y, target.pos.z)
				SetBlipRoute(target.blip, true)
				haveTarget = true
				isCall = true
				callActive = false
			else
				SendNotification("~r~Vous avez déjà un appel en cours !")
			end
        -- Press L key to decline the call
        elseif IsControlJustPressed(1, 182) and callActive then
            SendNotification("~r~Vous avez refusé l'appel.")
            callActive = false
        end
        if haveTarget then
            DrawMarker(1, target.pos.x, target.pos.y, target.pos.z-1, 0, 0, 0, 0, 0, 0, 2.001, 2.0001, 0.5001, 255, 255, 0, 200, 0, 0, 0, 0)
            local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
            if Vdist(target.pos.x, target.pos.y, target.pos.z, playerPos.x, playerPos.y, playerPos.z) < 2.0 then
                RemoveBlip(target.blip)
                haveTarget = false
				isCall = false
            end
        end
    end
end)

RegisterNetEvent("call:cancelCall")
AddEventHandler("call:cancelCall", function()
	if haveTarget then
		RemoveBlip(target.blip)
        haveTarget = false
		isCall = false
	else
		TriggerEvent("itinerance:notif", "~r~Vous n'avez aucun appel en cours !")
	end
end)

RegisterNetEvent("call:callIncoming")
AddEventHandler("call:callIncoming", function(job, pos, msg)
    callActive = true
    work = job
    target.pos = pos
	

	coords = GetEntityCoords(GetPlayerPed(-1))
	dist = CalculateTravelDistanceBetweenPoints(coords.x,coords.y,coords.z,target.pos.x,target.pos.y,target.pos.z)
	streetname = GetStreetNameFromHashKey(GetStreetNameAtCoord(target.pos.x,target.pos.y,target.pos.z)) .. " ("..math.ceil(dist).."m)"
	
	if work == "police" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 911', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '\n', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
		--SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
	elseif work == "mecano" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 907', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
	elseif work == "chauffeur" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 906', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
		--SendNotification("Appuyez sur ~g~Y~s~ pour prendre l'appel ou ~g~L~s~ pour le refuser")
	elseif work == "lsms" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 912', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
	elseif work == "fib" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "pilot" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "epicerie" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "brinks" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "army" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "realestateagent" then
		SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
	elseif work == "unicorn" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 902', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
	elseif work == "journaliste" then
		ShowAdvancedNotification('Centrale', '~b~Appel d\'urgence: 900', '~b~Identité: ~s~Inconnu\n~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
		SendNotification('~b~Détails:~s~ '..msg)
	elseif work == "state" then
        SendNotification("~r~APPEL EN COURS:~w~ " ..tostring(msg))
    else
        ShowAdvancedNotification('Centrale', '~b~Appel', '~b~Localistion: ~s~'.. streetname.. '', "CHAR_CALL911", 1)
	end
	SendNotification("Appuyez sur ~b~Y~s~ pour prendre l'appel ou ~r~L~s~ pour le refuser")
	
end)

RegisterNetEvent("call:taken")
AddEventHandler("call:taken", function(a)
   -- callActive = false
    SendNotification("~b~L'appel a été pris par "..a)
end)

RegisterNetEvent("target:call:taken")
AddEventHandler("target:call:taken", function(taken)
    if taken == 1 then
        SendNotification("~b~Quelqu'un arrive !")
    end
end)

-- If player disconnect, remove him from the inService server table
AddEventHandler('playerDropped', function()
	TriggerServerEvent("player:serviceOff", nil)
end)

function SendNotification(message)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(message)
    DrawNotification(false, false)
end
