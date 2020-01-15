Police = {}

local function ClosestVeh()
    if GetEntityType(vehicleFct.GetVehicleInDirection()) == 2 then
        return vehicleFct.GetVehicleInDirection()
    else
        return 0
    end
end

function Police.PlateCheck()
    local veh = ClosestVeh()
    if veh ~= 0 then
        local plate = GetVehicleNumberPlateText(veh)
        RageUI.Popup({message="La plaque de ce véhicule est : ~b~"..plate})
    end
end

function Police.Crocheter() 
    local veh = ClosestVeh()
    if veh ~= 0 then
        TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_WELDING', 0, true)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))

        SetVehicleDoorsLocked(veh, 1)
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        RageUI.Popup({message="Véhicule ~g~déverouillé"})
    end
end

function Police.Immobiliser() 
    local veh = ClosestVeh()
    if veh ~= 0 then
        SetVehicleUndriveable(veh, true)
        RageUI.Popup({message="Vous avez ~r~immobilisé~s~ le véhicule"})
    end
end

function Police.HandcuffPly()
    local count = Inventory:GetItemCount("menottes")
    if count > 0 then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then

            local isHandcuff = IsPlyHandcuff(playerId)
            if not isHandcuff then
                if Inventory.SelectedItem ~= nil then
                    Inventory:RemoveItem()
                else
                    local _v = Inventory.Inventory["menottes"]
                    local i = 1
                    if _v[i] ~= nil then
                        TriggerServerEvent("inventory:RemoveItem",_v[i].id,"menottes")
                    end
                    
                end
                TriggerServerEvent("player:Handcuff",playerId,true)
            else
                RageUI.Popup({message="Ce joueur est déjà menotté"})
            end
        else
            RageUI.Popup({message="~r~Aucun joueur proche"})
        end
    else
        RageUI.Popup({message="Vous n'avez pas de ~r~menottes"})
    end
end

function Police.RetraitPermis()
    Citizen.CreateThread(function()
    RageUI.GoBack()
    Wait(20)
    RageUI.GoBack()
    Wait(20)
    RageUI.GoBack()
    Wait(20)
    RageUI.GoBack()
    Wait(20)
    RageUI.GoBack()

    RageUI.Visible(RMenu:Get('police',"permis"),true)
    end)
--Wait(300)
   --

end
RMenu.Add('police', 'permis', RageUI.CreateSubMenu(RMenu:Get('personnal', 'main'), "", "Permis disponibles"))

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('police',"permis")) then
            RageUI.DrawContent({ header = false, glare = false}, function()
                if #Inventory.Inventory["permis-conduire"] == 0 then
                    RageUI.Button("Vide", nil, { RightLabel =  nil }, true, function(_, _, Selected)
                        if Selected then
                            
                        end
                    end)
                end
                for i = 1 , #Inventory.Inventory["permis-conduire"] , 1 do
                        local v = Inventory.Inventory["permis-conduire"][i]
                        local data = v.data
                        RageUI.Button("Permis " .. data.uid , nil, { RightLabel = data.points .. " points" }, true, function(_, _, Selected)
                            if Selected then
                                local am = KeyboardInput("Nombre de points à enlever",nil,2)
                                local am = tonumber(am)
                                if am ~= nil then
                                    data.points = data.points - am
                                end
                            end
                        end)
                end

            end, function()
            end)
        end
    end
end)
function Police.CutMenottes()
    local count = Inventory:GetItemCount("pinces") > 0 or Inventory:GetItemCount("crochetage") > 0 
    if count then
        local playerId = GetPlayerServerIdInDirection(5.0)
        if (playerId ~= false) then
            local isHandcuff = IsPlyHandcuff(playerId)
            if isHandcuff then
                if Inventory.SelectedItem ~= nil then
                    Inventory:RemoveItem()
                else
                    local _v = Inventory.Inventory["pinces"]
                    local i = 1
                    if _v[i] ~= nil then
                        TriggerServerEvent("inventory:RemoveItem",_v[i].id,"pinces")
                    end
                    
                end
                TriggerServerEvent("player:Handcuff",playerId,false)
            else
                RageUI.Popup({message="ce joueur n'est pas menotté"})
            end
        else
            RageUI.Popup({message="~r~Aucun joueur proche"})
        end
    else
        RageUI.Popup({message="Vous n'avez pas de ~r~pinces"})
    end

end

