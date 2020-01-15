Money = setmetatable({}, Money)
Money.amount = 5000
function Money:CanBuy(price)

    if price > self.amount then
        RageUI.Popup({ message = "~r~Vous n'avez pas assez d'argent" })
        return false
    else
        return true
    end
end

BlackMoney = setmetatable({}, Money)
BlackMoney.amount = 5000
function BlackMoney:CanBuy(price)
    if price > self.amount then
       -- RageUI.Popup({ message = "~r~Vous n'avez pas assez d'argent" })
        return false
    else
        return true
    end
end


RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	Money.amount = e
end)

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(m, native, current)
	Money.amount = Money.amount + m
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(m, native, current)
	Money.amount = current
end)


RegisterNetEvent('es:activateBlackMoney')
AddEventHandler('es:activateBlackMoney', function(e)
	BlackMoney.amount = e
end)

RegisterNetEvent("es:addedBlackMoney")
AddEventHandler("es:addedBlackMoney", function(m, native, current)
	PBlackMoney.amount = BlackMoney.amount + m
end)

RegisterNetEvent("es:removedBlackMoney")
AddEventHandler("es:removedBlackMoney", function(m, native, current)
    BlackMoney.amount = BlackMoney.amount- m
    TriggerEvent("es:activateBlackMoney'", BlackMoney.amount)
end)