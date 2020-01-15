TriggerEvent("es:addGroup", "mod", "user", function(group) end)

-- Modify if you want, btw the _admin_ needs to be able to target the group and it will work
local groupsRequired = {
	slay = "mod",
	noclip = "admin",
	crash = "superadmin",
	freeze = "mod",
	bring = "mod",
	["goto"] = "mod",
	slap = "mod",
	slay = "mod",
	kick = "mod",
	ban = "admin"
}

local banned = ""
local bannedTable = {}

function loadBans()
	banned = LoadResourceFile("es_admin2", "data/bans.txt") or ""
	if banned then
		local b = stringsplit(banned, "\n")
		for k,v in ipairs(b) do
			bannedTable[v] = true
		end
	end

	if GetConvar("es_admin2_globalbans", "0") == "1" then
		PerformHttpRequest("http://essentialmode.com/bans.txt", function(_, rText, _)
			local b = stringsplit(rText, "\n")
			for k,v in pairs(b)do
				bannedTable[v] = true
			end
		end)
	end
end

function isBanned(id)
	return bannedTable[id]
end

function banUser(id)
	banned = banned .."\n" .. id .. "\n"
	SaveResourceFile("es_admin2", "data/bans.txt", banned, -1)
	bannedTable[id] = true
end

AddEventHandler('playerConnecting', function(user, set)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if isBanned(v) then
			set(GetConvar("es_admin_banreason", "Vous avez été banni de VLife."))
			for x,t in ipairs(GetPlayerIdentifiers(source))do
				if t ~= v then
					banUser(t)
				end
			end

			CancelEvent()
			break
		end
	end
end)
RegisterServerEvent('banImACheater')
AddEventHandler('banImACheater', function(source)
	for k,v in ipairs(GetPlayerIdentifiers(source))do
		banUser(v)
	end
	DropPlayer(source, GetConvar("es_admin_banreason", "Vous avez été banni de VLife."))
end)
RegisterServerEvent('es_admin:all')
AddEventHandler('es_admin:all', function(type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available or user.getGroup() == "superadmin" then
				if type == "slay_all" then TriggerClientEvent('es_admin:quick', -1, 'slay') end
				if type == "bring_all" then TriggerClientEvent('es_admin:quick', -1, 'bring', Source) end
				if type == "slap_all" then TriggerClientEvent('es_admin:quick', -1, 'slap') end
			else
				TriggerClientEvent('chatMessage', Source, "VLife", {255, 0, 0}, "Vous n'avez pas la permission de faire cela.")
			end
		end)
	end)
end)

RegisterServerEvent('es_admin:quick')
AddEventHandler('es_admin:quick', function(id, type)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:getPlayerFromId', id, function(target)
			TriggerEvent('es:canGroupTarget', user.getGroup(), groupsRequired[type], function(available)
				--'Available?: ' .. tostring(available))
				TriggerEvent('es:canGroupTarget', user.getGroup(), target.getGroup(), function(canTarget)
					if canTarget and available then
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "noclip" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "freeze" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "crash" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "bring" then TriggerClientEvent('es_admin:quick', id, type, Source) end
						if type == "goto" then TriggerClientEvent('es_admin:quick', Source, type, id) end
						if type == "slap" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "slay" then TriggerClientEvent('es_admin:quick', id, type) end
						if type == "kick" then DropPlayer(id, 'Kicked by es_admin GUI') end
					
						if type == "ban" then
							for k,v in ipairs(GetPlayerIdentifiers(id))do
								banUser(v)
							end
							DropPlayer(id, GetConvar("es_admin_banreason", "Vous avez été banni de VLife."))
						end
					else
						if not available then
							TriggerClientEvent('chatMessage', Source, 'VLife', {255, 0, 0}, "Votre groupe ne peut pas utiliser cette commande.")
						else
							TriggerClientEvent('chatMessage', Source, 'VLife', {255, 0, 0}, "Permission refusée.")
						end
					end
				end)
			end)
		end)
	end)
end)

AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Joueur non trouvé")
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chatMessage', -1, "VLife :", {0, 0, 0}, "Groupe de ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 a été mis à ^2^*" .. GROUP)
							end)
						else
							TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Groupe non trouvé")
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Joueur non trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent("es:setPlayerData", USER, "permission_level", GROUP, function(response, success)
							if(true)then
								TriggerClientEvent('chatMessage', -1, "CONSOLE", {0, 0, 0}, "Niveau de permission de ^2" .. GetPlayerName(tonumber(USER)) .. "^0 a été mis à ^2 " .. tostring(GROUP))
							end
						end)	
					else
						TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Entré invalide")
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Joueur non trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Entré invalide")
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Joueur non trouvé")
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "Entré invalide")
					end
				end
			end
			else
				TriggerClientEvent('chatMessage', source, 'VLife', {255, 0, 0}, "superadmin nécessaire pour le faire")
			end
		end)
	end)	
end)


TriggerEvent('es:addGroupCommand', 'tp', 'user', function(source, args, _)
	local x = tonumber(args[1])
	local y = tonumber(args[2])
	local z = tonumber(args[3])
	
	if x and y and z then
		TriggerClientEvent("esx:teleport", source, {
			x = x,
			y = y,
			z = z
		})
	else
		TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Coordonnées non valides !")
	end
end, function(source, _, _)
  TriggerClientEvent('chat:addMessage', source, { args = { '^1VLife', 'Permissions insuffisantes.' } })
end)

-- Noclip
TriggerEvent('es:addGroupCommand', 'noclip', "admin", function(source, _, _)
	TriggerClientEvent("es_admin:noclip", source)
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)


-- Kicking
TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, _)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Expulser : Vous avez été expulsé du serveur"
				else
					reason = "Expulser : " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chatMessage', -1, "VLife", {255, 0, 0}, "Joueur ^2" .. GetPlayerName(player) .. "^0 a été expulser (^2" .. reason .. "^0)")
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
		TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

TriggerEvent('es:addGroupCommand', 'ban', "mod", function(_, args, _)

			local player = tonumber(args[1])
			print(player)
			-- User permission check
			for k,v in ipairs(GetPlayerIdentifiers(player))do
				banUser(v)
			end

			DropPlayer(player, GetConvar("es_admin_banreason", "Vous avez était banni de VLife."))
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Announcing
TriggerEvent('es:addGroupCommand', 'announce', "admin", function(_, args, _)
	TriggerClientEvent('chatMessage', -1, "VLife", {255, 0, 0}, "" .. table.concat(args, " "))
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'freeze', "mod", function(source, args, _)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				if(frozen[player])then
					frozen[player] = false
				else
					frozen[player] = true
				end

				TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])

				local state = "unfrozen"
				if(frozen[player])then
					state = "frozen"
				end

				TriggerClientEvent('chatMessage', player, "VLife", {255, 0, 0}, "Vous avez été " .. state .. " par ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Joueurs ^2" .. GetPlayerName(player) .. "^0 a été " .. state)
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect!")
		end
	else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect!")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'bring', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.getCoords().x, user.getCoords().y, user.getCoords().z)

				TriggerClientEvent('chatMessage', player, "VLife", {255, 0, 0}, "Vous avez amené par ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Joueurs ^2" .. GetPlayerName(player) .. "^0 a été amené")
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
		TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Bring
local frozen = {}
TriggerEvent('es:addGroupCommand', 'slap', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:slap', player)

				TriggerClientEvent('chatMessage', player, "VLife", {255, 0, 0}, "Vous avez giflé ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Joueur ^2" .. GetPlayerName(player) .. "^0 a été giflé")
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Freezing
local frozen = {}
TriggerEvent('es:addGroupCommand', 'goto', "mod", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)
				if(target)then

					TriggerClientEvent('es_admin:teleportUser', source, target.getCoords().x, target.getCoords().y, target.getCoords().z)

					TriggerClientEvent('chatMessage', player, "VLife", {255, 0, 0}, "Vous avez été téléporté par ^2" .. GetPlayerName(source))
					TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Téléport au joueur ^2" .. GetPlayerName(player) .. "")
				end
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Kill yourself
TriggerEvent('es:addCommand', 'die', function(source, args, user)
	TriggerClientEvent('es_admin:kill', source)
	TriggerClientEvent('chatMessage', source, "", {0,0,0}, "^1^*Tu t'es tuer")
end, {help = "Suicide"})

-- Killing
TriggerEvent('es:addGroupCommand', 'slay', "admin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:kill', player)

				TriggerClientEvent('chatMessage', player, "VLife", {255, 0, 0}, "Vous avez été tué par ^2" .. GetPlayerName(source))
				TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Joueur ^2" .. GetPlayerName(player) .. "^0 a été tué.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Crashing
TriggerEvent('es:addGroupCommand', 'crash', "superadmin", function(source, args, user)
	if args[1] then
		if(GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				TriggerClientEvent('es_admin:crash', player)

				TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Joueur ^2" .. GetPlayerName(player) .. "^0 a crash.")
			end)
		else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
		end
	else
			TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "ID de joueur incorrect !")
	end
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Permissions insuffisantes.")
end)

-- Position
TriggerEvent('es:addGroupCommand', 'pos', "owner", function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Cette commande a été supprimée")
end, function(source, _, _)
	TriggerClientEvent('chatMessage', source, "VLife", {255, 0, 0}, "Cette commande a été supprimée")
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

loadBans()