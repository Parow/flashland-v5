RegisterServerEvent('core:NewAppartDuSexe')
AddEventHandler('core:NewAppartDuSexe', function(bool)

    MySQL.Async.execute(
        "INSERT INTO players_appartement (capacity,name,pos,price,indexx) VALUES(@capacity,@name,@pos,@price,@index)",
           {

                ['@capacity']   = bool.max,
                ['@name']   = bool.name,
                ['@pos']   = bool.entry,
                ['@price']   = bool.price, 
                ['@index'] = bool.index
                 

            }
        )
        Wait(500)
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement")
    for i = 1,#result,1 do
        result[i].time = os.date("%d/%m/%Y %X",result[i].time)
    end
    TriggerClientEvent("core:returnAppartTable", -1, result)

end)

RegisterServerEvent('appart:remove')
AddEventHandler('appart:remove', function(id)
    MySQL.Async.execute(
        'DELETE FROM players_appartement WHERE id=@id',
           {
                ['@id']   = id,
            }
        )
        TriggerClientEvent("appart:RequestApparts",-1)
end)

RegisterServerEvent('appart:updateown')
AddEventHandler('appart:updateown', function(targetSrc,id)
    local ply = Player.GetPlayer(targetSrc)
    MySQL.Async.execute(
        'UPDATE players_appartement SET owner=@owner where id=@id',
        {
                ['@id']   = id,
                ['@owner'] = ply.uuid,
                ['@time'] = nil
        }
    )
    TriggerClientEvent("appart:RequestApparts",-1)
end)


RegisterServerEvent('core:AddCoOwner')
AddEventHandler('core:AddCoOwner', function(targetSrc,id,own)
    local ply = Player.GetPlayer(targetSrc)
    table.insert(own,ply.uuid)
    MySQL.Async.execute(
        'UPDATE players_appartement SET coowner=@coowner where id=@id',
        {
                ['@id']   = id,
                ['@coowner'] = json.encode(own),
                ['@time'] = nil
        }
    )
    TriggerClientEvent("appart:RequestApparts",-1)
end)

RegisterServerCallback('appart:requestData', function(source, callback)
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement")
    callback(result)
end)


function CheckAppart()
 
    local result = MySQL.Sync.fetchAll("SELECT * FROM players_appartement")
    for i = 1,#result,1 do
        now = os.time()
        if result[i].time ~= nil then
            if now > result[i].time then
                MySQL.Async.execute(
                    'UPDATE players_appartement SET owner=@label, time=@time where id=@id',
                    {
                            ['@id']   = result[i].id,
                            ['@label'] = nil,
                            ['@time'] = nil
                    }
                )
            end
        end
    end
end

MySQL.ready(function ()
    CheckAppart()
end)


