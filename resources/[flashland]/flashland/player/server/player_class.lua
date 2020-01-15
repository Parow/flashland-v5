
Users = {}

function Player.NewPlayerConnected(source)
    local _source = source
    Users[source] = Player.CreatePlayer(_source)
end
function Player.GetSourceFromUUID(UUID)
    for i = 1 , #Users , 1 do
        if Users[i].uuid == UUID then
            return Users[i].source
        end
    end
end
function Player.Disconnected(source)
    Users[source] = nil
    MySQL.Async.execute(
        'UPDATE users SET is_active=@skin where is_active=1 and identifier=@identifier',
           {
                ['@table']   = "is_active",
                ['@skin'] = 0,
                ['@identifier'] = GetIdentifiers(source).steam,
            }
    )
end
function Player.GetPlayer(source)
    if Users[source] == nil then
        Users[source] = Player.CreatePlayer(source)
    end
    return Users[source]
end

function Player.CreatePlayer(_source)
    local FLT = {}
    local self = FLT
    FLT.identifers = GetIdentifiers(_source)
    FLT.name = GetPlayerName(_source)
    FLT.uuid = Player.GetCurrentUuid(_source)

    FLT.Weight = 0
    FLT.source = _source
    FLT.money = 0
    FLT.black_money = 0
    FLT.xp = 0
    FLT.firstname = ""
    FLT.surname = ""
    -- TODO Fix this
    while FLT.uuid == nil do
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
            ["@identifiers"] = GetIdentifiers(_source).steam
        }, function(result)
            if result[1] ~= nil then
            FLT.uuid = result[1].uuid
            FLT.money = result[1].money
            FLT.black_money = result[1].black_money
            FLT.xp = result[1].xp
            TriggerClientEvent('es:activateBlackMoney', self.source , self.black_money)
            TriggerClientEvent('es:activateMoney', self.source , self.money)
            end
        end)
        Wait(1)
    end
    
    FLT.AddItem = function(item,amount,data,label)
        local userX = MySQL.Sync.fetchAll("SELECT * FROM players_inventory ORDER BY id ASC")
        for i = 1 ,amount,1 do
            MySQL.Async.execute(
                'INSERT INTO players_inventory (uuid,name,data,label) VALUES(@uuid,@item,@data,@label)',
                {
                    ['@uuid']   = FLT.uuid ,
                    ['@item'] = item,
                    ['@data'] = json.encode(data),
                    ['@label'] = label,

                }
            )
            userX[#userX].id = userX[#userX].id+1
            TriggerClientEvent("inventory:AddItem", FLT.source,item,data,label,userX[#userX].id )
        end
    end
    FLT.RemoveItem = function(id,name)
        print(id)

            MySQL.Async.execute(
                'DELETE From players_inventory WHERE id = @id',
                {
                    ['@id']   = id,
                }
            )
            TriggerClientEvent("inventory:removeItem",FLT.source,id,name)
    end
    FLT.RenameItem = function(id,label)
        MySQL.Async.execute(
            'UPDATE players_inventory SET label=@label where id=@id',
               {
                    ['@id']   = id,
                    ['@label'] = label,
    
                }
            )
    end

    FLT.EditData = function(id,data,name)
        MySQL.Async.execute(
            'UPDATE players_inventory SET data=@data where id=@id',
               {
                    ['@id']   = id,
                    ['@data'] = json.encode(data),
    
                }
            )
            TriggerClientEvent("inventory:editData",FLT.source,id,data,name)
    end

    FLT.RemoveAll = function()
        MySQL.Async.execute(
            'DELETE FROM players_inventory WHERE uuid=@identifier',
               {
                    ['@identifier']   = FLT.uuid,
                }
            )
    end

    FLT.EditSkin = function(skin,table)
        MySQL.Async.execute(
            'UPDATE players_inventory SET @table=@skin where uuid=@id',
               {
                    ['@table']   = table,
                    ['@skin'] = json.encode(skin),
                    ['@id'] = FLT.uuid,
                }
        )
    end

    FLT.removeBlackMoney = function(m)
		if m ~= nil then
			if m < 0 then
				TriggerEvent("banImACheater",FLT.source)
			end
			if type(m) == "number" then
				local newMoney = FLT.black_money - m
                FLT.black_money = newMoney
                
                TriggerClientEvent('es:activateBlackMoney', FLT.source , FLT.black_money)
				TriggerClientEvent("es:removedBlackMoney", FLT.source, m, false, FLT.black_money)
			end	
		end
    end
    
    FLT.removeMoney = function(m)
		if m ~= nil then
			if m < 0 then
				TriggerEvent("banImACheater",FLT.source)
			end
			if type(m) == "number" then
				local newMoney = FLT.money - m
				FLT.money = newMoney
                TriggerClientEvent('es:activateMoney', FLT.source , FLT.money)
				TriggerClientEvent("es:removedMoney", FLT.source, m, false, FLT.money)
			end	
		end
    end
    
    FLT.addMoney = function(m)
		if m ~= nil then
			if m < 0 then
				TriggerEvent("banImACheater",FLT.source)
			end
			if type(m) == "number" then
				local newMoney = FLT.money + m
				FLT.money = newMoney
                TriggerClientEvent('es:activateMoney', FLT.source , FLT.money)
				TriggerClientEvent("es:addedMoney", FLT.source, m, false, FLT.money)
			end	
		end
    end

    FLT.addBlackMoney = function(m)
		if m ~= nil then
			if m < 0 then
				TriggerEvent("banImACheater",FLT.source)
			end
			if type(m) == "number" then
				local newMoney = FLT.black_money + m
                FLT.black_money = newMoney
                
                TriggerClientEvent('es:activateBlackMoney', FLT.source , FLT.black_money)
				TriggerClientEvent("es:removedBlackMoney", FLT.source, m, false, FLT.black_money)
			end	
		end
    end

    FLT.getMoney = function(m)
        return FLT.money
    end
    
    FLT.getBlackMoney = function(m)
        return FLT.black_money
	end

    return FLT
end

function Player.GetCurrentUuid(_source)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = GetIdentifiers(_source).steam
    }, function(result)
        if result[1] ~= nil then
            return result[1].uuid
        end
    end)
end

AddEventHandler("mugroom:SelectedPlayer", function() 
    Player.NewPlayerConnected(source)
end)

AddEventHandler('playerDropped', function (reason)
    Player.Disconnected(source)
end)


RegisterServerEvent("money:Pay")
AddEventHandler("money:Pay", function(price)
    local player = Player.GetPlayer(source)
    player.removeMoney(price)
end)
function Player.Save()
    for k, v in pairs(Users) do
        MySQL.Async.execute(
            "UPDATE users SET money=@money,black_money=@black,xp=@xp,updated_at=@updated where uuid=@uuid",
            {
                ["@money"] = v.money,
                ["@black"] = v.black_money,
                ["@coowner"] = v.xp,
                ["@uuid"] = v.uuid,
                ["@updated"] = GetDatetime()
            }
        )
    end
    print("^3[Players] ^4Players saved ^0")
    SetTimeout(20000, Player.Save)
end

SetTimeout(20000, Player.Save)

RegisterServerEvent("player:Handcuff")
AddEventHandler("player:Handcuff", function(trgtSource,bool)
    TriggerClientEvent("player:HandCuff",trgtSource,bool)
end)


RegisterServerEvent("money:Add")
AddEventHandler("money:Add", function(price)
    local player = Player.GetPlayer(source)
    player.addMoney(price)
end)

RegisterServerEvent("money:Add2")
AddEventHandler("money:Add2", function(price,_source)
    local player = Player.GetPlayer(_source)
    player.addMoney(price)
end)

RegisterServerEvent("money:Remove2")
AddEventHandler("money:Remove2", function(price,_source)
    local player = Player.GetPlayer(_source)
    player.removeMoney(price)
end)

RegisterServerEvent("black_money:Add")
AddEventHandler("black_money:Add", function(price)
    local player = Player.GetPlayer(source)
    player.addBlackMoney(price)
end)

RegisterServerEvent("black_money:Pay")
AddEventHandler("black_money:Pay", function(price)
    local player = Player.GetPlayer(source)
    player.removeBlackMoney(price)
end)

AddEventHandler('playerDropped', function()
	local Source = source

	if(Users[Source])then
		TriggerEvent("es:playerDropped", Users[Source])
        --Users[Source].getMoney())
        MySQL.Async.execute(
        'UPDATE users SET money=@data where uuid=@id',
        {
             ['@id']   = Users[Source].uuid,
             ['@money'] = Users[Source].money,
             ['@black_money'] = Users[Source].black_money,
         }
        )
		Users[Source] = nil
	end
end)


RegisterServerCallback('player:GetInventory', function(source, callback,targetSource)
    local targetPlayer = Player.GetPlayer(targetSource)
    local money = Users[targetSource].getMoney()
    local black_money = Users[targetSource].getBlackMoney()
    local Inventory = {}
    MySQL.Async.fetchAll('SELECT * FROM players_inventory WHERE uuid = @uuid', {
        ["@uuid"] = targetPlayer.uuid
    }, function(result)
        Inventory = result
        callback(Inventory,{money=money,dark_money=black_money})
    end)
    
end)
RegisterServerEvent("tatoo:add")
AddEventHandler("tatoo:add", function(data)
    local users = Users[source]
    MySQL.Async.execute(
        'UPDATE players_appearance SET tattoo=@tattoo where uuid=@uid',
        {
             ['@uid']   = users.uuid,
             ['@tattoo'] = json.encode(data),

         }
        )
end)



RegisterServerCallback('core:GetAllIdentityPlayers', function(source, callback)
    local _source = source
    local identifers = GetIdentifiers(_source).steam

    MySQL.Async.fetchAll('SELECT * FROM players_identity', {
    }, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_vehicles', {
        }, function(_result)
                callback(_result,result)
        end)
            
    end)

end)
RegisterServerEvent("core:SyncItemWithBDD")
AddEventHandler("core:SyncItemWithBDD", function(item)
    MySQL.Async.execute(
        'UPDATE players_inventory SET data=@data where id=@id',
        {
             ['@id']   = item.id,
             ['@data'] = json.encode(item.data),

         }
        )
end)
----

RegisterServerEvent("player:serviceOn")
RegisterServerEvent("player:serviceOff")
RegisterServerEvent("call:makeCall")
RegisterServerEvent("call:getCall")

local inService = {
    ["ltd"] = {},
}
local callActive = {
    ["ltd"] = {taken = false},
}
local timing = 60000

-- Add the player to the inService table
AddEventHandler("player:serviceOn", function(job)
local source = source
--job)
print ("Prise de service !!")
    table.insert(inService[job], source)
    --json.encode(inService[job]))	
end)

-- Remove the player to the inService table
AddEventHandler("player:serviceOff", function(job)
local source = source
    if job == nil then
        for _,v in pairs(inService) do
            removeService(v)
        end
    end
    removeService(source, job)

end)

-- Receive call event
AddEventHandler("call:makeCall", function(job, pos, message)
local source = source
--job)
	 -- Players can't call simultanously the same service
    if callActive[job].taken then
        TriggerClientEvent("target:call:taken", callActive[job].target, 2)
        CancelEvent()
    end
    -- Save the target of the call
    callActive[job].target = source
    callActive[job].taken = true
    -- Send notif to all players in service
    --dump(inService[job]))
    for _, player in pairs(inService[job]) do
        --player)
        TriggerClientEvent("call:callIncoming", player, job, pos, message)
    end
    -- Say to the target after 'timing' seconds that nobody will come
    SetTimeout(timing, function()
        if callActive[job].taken then
            TriggerClientEvent("target:call:taken", callActive[job].target, 0)
        end
        callActive[job].taken = false
    end)
end)


RegisterServerEvent('gcPhone:CallServerNumber')
AddEventHandler('gcPhone:CallServerNumber', function (number)

    for _, player in pairs(inService[number]) do
        --TriggerEvent("parow:MakeServiceCall", player,number,source)
      --  TriggerClientEvent("call:callIncoming", player, job, pos, message)
    end
end)


AddEventHandler("call:getCall", function(job)
    callActive[job].taken = false
    -- Say to other in service people that the call is taken
    for _, player in pairs(inService[job]) do
        if player ~= source then
            TriggerClientEvent("call:taken", player,GetPlayerName(source))
        end
    end
    -- Say to a target that someone come
    if not callActive[job].taken then
        TriggerClientEvent("target:call:taken", callActive[job].target, 1)
    end
end)

function removeService(player, job)
    for i,val in pairs(inService[job]) do
        if val == player then
            table.remove(inService[job], i)
            return
        end
    end
end


RegisterServerEvent("core:SetService")
AddEventHandler("core:SetService", function(job,bool)
    if bool then
        table.insert(inService[job], source)
    else
        local source = source
        if job == nil then
            for _,v in pairs(inService) do
                removeService(v)
            end
        end
        removeService(source, job)
    end

    local player = Player.GetPlayer(source)
    player.service = bool
end)

RegisterServerCallback('GetJobServices', function(source, callback)
    print(json.encode(inService))
    callback(inService)
end)
