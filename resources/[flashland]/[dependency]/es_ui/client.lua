local cashType = 1

RegisterNetEvent('es:setMoneyIcon')
AddEventHandler('es:setMoneyIcon', function(i)
	SendNUIMessage({
		seticon = true,
		icon = i
	})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({
		setmoney = true,
		money = e
	})
end)

RegisterNetEvent('es:activateJob')
AddEventHandler('es:activateJob', function(e)

	if e == nil then
		e = ""
	end
	SendNUIMessage({
		setJob = true,
		job = e
	})
end)
RegisterNetEvent('es:activateJob2')
AddEventHandler('es:activateJob2', function(e)
	if e == nil then
		e = ""
	end
	SendNUIMessage({
		setJob2 = true,
		job2 = e
	})
end)
RegisterNetEvent('es:activateBlackMoney')
AddEventHandler('es:activateBlackMoney', function(e)
	SendNUIMessage({
		setblack= true,
		 blackmoney = e
	})
end)


RegisterNetEvent("es:addedBlackMoney")
AddEventHandler("es:addedBlackMoney", function(m, native, current)


end)
RegisterNetEvent("es:removedBlackMoney")
AddEventHandler("es:removedBlackMoney", function(m, native, current)

end)
RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(m, native, current)


		SendNUIMessage({
			addcash = true,
			money = m
		})


end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(m, native, current)

		SendNUIMessage({
			removecash = true,
			money = m
		})

end)

RegisterNetEvent('es:addedBank')
AddEventHandler('es:addedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, math.floor(m))
end)

RegisterNetEvent('es:removedBank')
AddEventHandler('es:removedBank', function(m)
	Citizen.InvokeNative(0x170F541E1CADD1DE, true)
	SetPlayerCashChange(0, -math.floor(m))
end)

RegisterNetEvent("es:setMoneyDisplay")
AddEventHandler("es:setMoneyDisplay", function(val)
	SendNUIMessage({
		setDisplay = true,
		display = val
	})
end)

RegisterNetEvent("es_ui:setSeperatorType")
AddEventHandler("es_ui:setSeperatorType", function(val)
	SendNUIMessage({
		setType = true,
		value = val
	})
end)

Citizen.CreateThread(function()
	Wait(1000)


	while true do
		Wait(25)

		if cashType == 2 then
			ShowHudComponentThisFrame(4)

		end
	end
	
end)