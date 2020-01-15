


RegisterServerCallback('getSettings', function(source, callback)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = identifers
    }, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_settings WHERE uuid = @uuid', {
            ["@uuid"] = result[1].uuid
        }, function(result)
            callback(result)
        end)
    end)
end)
local armeBuyed = {}


RegisterServerCallback('getArmeblanched', function(source, callback)
    local player = Player.GetPlayer(source)
    callback(armeBuyed[player.uuid] == nil)
end)
RegisterServerEvent("ArmeBlanche")
AddEventHandler("ArmeBlanche", function()
    local player = Player.GetPlayer(source)

    table.insert(armeBuyed,player.uuid)
end)
RegisterServerEvent("BuyNewWeapon")
AddEventHandler("BuyNewWeapon", function(data,label)

    local player = Player.GetPlayer(source)

    MySQL.Async.execute(
        'INSERT INTO players_weapon (serial,weapon_name,user) VALUES(@serial,@weapon_name,@user)',
        {
            ['@serial']   =data.serial,
            ['@weapon_name'] = label,
            ['@user'] = {name=player.firstname,surname=player.surname},
        }
    )
end)
RegisterServerEvent("saveMyColor")
AddEventHandler("saveMyColor", function(color)
    local _source = source
    local identifers = GetIdentifiers(_source).steam

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = identifers
    }, function(result)
        MySQL.Async.fetchAll('UPDATE players_settings SET colors=@color WHERE uuid = @uuid', {
            ["@uuid"] = result[1].uuid,
            ["@color"] = json.encode(color)
        }, function(result)
        end)
    end)
end)
RegisterServerEvent("saveMyBind")
AddEventHandler("saveMyBind", function(bind)
    local _source = source
    local identifers = GetIdentifiers(_source).steam

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = identifers
    }, function(result)
        MySQL.Async.fetchAll('UPDATE players_settings SET bind=@bind WHERE uuid = @uuid', {
            ["@uuid"] = result[1].uuid,
            ["@bind"] = json.encode(bind)
        }, function(result)
        end)
    end)
end)


AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
	local _source = source
	
	local steam64 = GetPlayerIdentifiers(_source)[1]

	local steam_name = GetPlayerName(_source)
	local rockstar = nil
	local ipv4 = nil
	deferrals.defer()

	deferrals.update(string.format("Bonjour %s. Nous vérifions que vous êtes bien whitelist.", name))
	
	Wait(1000)
	for _, foundID in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(foundID, "license:") then
			rockstar = string.sub(foundID, 9)
		elseif string.match(foundID, "ip:") then
			ipv4 = string.sub(foundID, 4)
		elseif string.match(foundID, "steam:") then
			steam64 = foundID
		end
	end
	local listed = MySQL.Sync.fetchScalar("SELECT * FROM whitelist WHERE identifier=@name", {['@name'] = steam64})
	   if listed ~= nil then
			deferrals.done()
	   else
			   deferrals.done()
	   end
   

	

end)