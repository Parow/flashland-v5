local Instances = {}
local existOrNot = {}
function GetInstancedPlayers()
	local players = {}

	for k,v in pairs(Instances) do
		for i=1, #v.players, 1 do
			table.insert(players, v.players[i])
		end
	end

	return players
end

function CreateInstance(type, player, data)
	Instances[player] = {
		type    = type,
		host    = player,
		players = {},
		data    = data
	}

	TriggerEvent('instance:onCreate', Instances[player])
	TriggerClientEvent('instance:onCreate', player, Instances[player])
	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function CloseInstance(instance)
	if Instances[instance] ~= nil then

		for i=1, #Instances[instance].players, 1 do
			TriggerClientEvent('instance:onClose', Instances[instance].players[i])
		end

		Instances[instance] = nil

		TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		TriggerEvent('instance:onClose', instance)
	end
end

function AddPlayerToInstance(instance, player)
	local found = false
	print(instance)
	print(json.encode(Instances[instance]))
	for i=1, #Instances[instance].players, 1 do
		if Instances[instance].players[i] == player then
			found = true
			break
		end
	end

	if not found then
		table.insert(Instances[instance].players, player)
	end

	TriggerClientEvent('instance:onEnter', player, Instances[instance])

	for i=1, #Instances[instance].players, 1 do
		if Instances[instance].players[i] ~= player then
			TriggerClientEvent('instance:onPlayerEntered', Instances[instance].players[i], Instances[instance], player)
		end
	end

	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(instance, player)

	if Instances[instance] ~= nil then

		TriggerClientEvent('instance:onLeave', player, Instances[instance])

		if Instances[instance].host == player then

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', Instances[instance].players[i], Instances[instance], player)
				end
			end

			CloseInstance(instance)

		else

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] == player then
					Instances[instance].players[i] = nil
				end
			end

			for i=1, #Instances[instance].players, 1 do
				if Instances[instance].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', Instances[instance].players[i], Instances[instance], player)
				end

			end

			TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())

		end

	end

end

function InvitePlayerToInstance(instance, type, player, data)
	TriggerClientEvent('instance:onInvite', player, instance, type, data)
end

RegisterServerEvent('instance:checkifexist')
AddEventHandler('instance:checkifexist', function(data)
	TriggerClientEvent("instance:Exist",source,existOrNot[data])
end)


function getSourceFromIdentifier(identifier, cb)
    TriggerEvent("es:getPlayers", function(users)
        for k , user in pairs(users) do
            if (user.getIdentifier ~= nil and user.getIdentifier() == identifier) or (user.identifier == identifier) then
                cb(k)
                return
            end
        end
    end)
    cb(nil)
end
RegisterServerEvent('instance:create')
AddEventHandler('instance:create', function(type, data)
	if type == "property" then
		existOrNot[data.property] = source
	end
	CreateInstance(type, source, data)
end)

RegisterServerEvent('instance:close')
AddEventHandler('instance:close', function()
	CloseInstance(source)
end)

RegisterServerEvent('instance:enter')
AddEventHandler('instance:enter', function(instance)
	AddPlayerToInstance(instance, source)
end)

RegisterServerEvent('instance:leave')
AddEventHandler('instance:leave', function(instance)
	RemovePlayerFromInstance(instance, source)
end)

RegisterServerEvent('instance:invite')
AddEventHandler('instance:invite', function(instance, type, player, data)
	InvitePlayerToInstance(instance, type, player, data)
end)
