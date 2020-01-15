

function CreateFacture(account)
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        local _facture = {
            title = KeyboardInput("Titre de la facture","",30),
            montant = tonumber(KeyboardInput("Montant de la facture","",30)),
            playerId = playerId,
            account = account
        }

        if _facture.title ~= nil and _facture.title ~= "" and tonumber(_facture.montant) ~= nil and _facture.montant ~= 0 then
            TriggerServerEvent("facture:send",_facture)
            _facture = {}
        else
            _facture = {}
            RageUI.Popup({message="Facture ~r~invalide"})
        end
    else
        RageUI.Popup({message="~r~Aucun joueur proche"})
    end
end
RegisterNetEvent("facture:paied")
AddEventHandler("facture:paied",function()
    RageUI.Popup({message="~g~Facture payé"})
end)

RegisterNetEvent("facture:get")
AddEventHandler("facture:get",function(_facture)
    RageUI.Popup({message="~b~Facture:\n~s~Titre : ~p~".._facture.title.."\n~s~Montant : ~o~".._facture.montant.."$~s~\n~g~E ~s~pour accepter"})
    KeySettings:Add("keyboard","E",function() 
        local canBuy = Money:CanBuy(_facture.montant)
        if canBuy then
            TriggerServerEvent("facture:pay",_facture) 
            TriggerServerEvent("money:Pay",_facture.montant)
            RageUI.Popup({message="~g~Vous avez payé la facture "})
        end
    end,"facture")
    Wait(6000)
    _facture = {}
    KeySettings:Clear("keyboard","E","facture")
end)

