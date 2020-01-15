

function GetIdentifiers(source)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

RegisterServerCallback('getInventory', function(source, callback)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = identifers
    }, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_inventory WHERE uuid = @uuid', {
            ["@uuid"] = result[1].uuid
        }, function(result)
            callback(result)
        end)
    end)
end)

RegisterServerEvent("inventory:giveOtherPlayer")
AddEventHandler("inventory:giveOtherPlayer", function(item,targetSource)
    ply = Player.GetPlayer(source)
    targetPLY = Player.GetPlayer(targetSource)
    for i = 1 , #item , 1 do
        if Items[item[i].name].weight + targetPLY.Weight <= 32 then
            ply.RemoveItem(item[i].id)
            targetPLY.AddItem(item[i].name,1,item[i].data,item[i].label)
            ply.Weight = ply.Weight - Items[item[i].name].weight
            targetPLY.Weight = targetPLY.Weight + Items[item[i].name].weight
        else
            TriggerClientEvent("RageUI:Popup", source, {message="Le joueur n'a plus de place."})
            TriggerClientEvent("RageUI:Popup", targetSource, {message="Vous n'avez plus de place."})
            break
        end
    end    
end)



RegisterServerEvent("core:buymunition")
AddEventHandler("core:buymunition", function(amount,itemName)

    ply.AddItem(itemName,amount)

end)
RegisterServerEvent("inventory:AddItem")
AddEventHandler("inventory:AddItem", function(item)
    ply = Player.GetPlayer(source)
    ply.AddItem(item.name,1,item.data,item.label)
end)
RegisterServerEvent("inventory:AddItem2")
AddEventHandler("inventory:AddItem2", function(item,_source)
    ply = Player.GetPlayer(_source)
    ply.AddItem(item.name,1,item.data,item.label)
end)
RegisterServerEvent("inventory:RemoveItem")
AddEventHandler("inventory:RemoveItem", function(id,name)
    ply = Player.GetPlayer(source)
    ply.RemoveItem(id,name)
end)
RegisterServerEvent("player:RemoveItem")
AddEventHandler("player:RemoveItem", function(_source,id,name)
    ply = Player.GetPlayer(_source)
    ply.RemoveItem(id,name)
end)
RegisterServerEvent("inventory:UpdateWeight")
AddEventHandler("inventory:UpdateWeight", function(weight)
    ply = Player.GetPlayer(source)
    ply.Weight = weight
end)

RegisterServerCallback('inventory:renameItem', function(source,callback,id,label)
    local _source = source
    ply = Player.GetPlayer(source)
    ply.RenameItem(id,label)
    callback(true)
end)



RegisterServerEvent("inventory:editData")
AddEventHandler("inventory:editData", function(id,data)
    MySQL.Async.execute(
        'UPDATE players_inventory SET data= @data where id=@id',
           {
                ['@id']   =id,
                ['@data'] = json.encode(data),
            }
    )
end)
--
RegisterServerEvent("savefood")
AddEventHandler("savefood", function(eau,f)
    local _source = source
    local ply = Player.GetPlayer(source)
    MySQL.Async.execute(
        'UPDATE users SET food= @food, thirst = @eau where id=@id',
           {
                ['@eau']   =eau,
                ['@food'] = f,
                ['@uuid'] = ply.uuid
            }
    )
end)

 ------------------
------STOCKAGE------
 ------------------

--
RegisterServerEvent("stockage:RemoveItem")
AddEventHandler("stockage:RemoveItem", function(id)
    MySQL.Async.execute(
        'DELETE From storages_inventory_items WHERE id = @id',
        {
            ['@id']   = id,
        }
    )
end)
RegisterServerEvent("stockage:DepositItem")
AddEventHandler("stockage:DepositItem", function(o)
    MySQL.Async.execute(
        'INSERT INTO storages_inventory_items (plate,name,data,label,type) VALUES(@plate,@name,@data,@label,@type)',
        {
            ['@plate']   =o[4],
            ['@name'] = o[1],
            ['@data'] = json.encode(o[3]),
            ['@label'] = o[2],
            ['@type'] = o[5],

        }
    )
end)
RegisterServerEvent("stockage:AddMoneyToAccount")
AddEventHandler("stockage:AddMoneyToAccount", function(plate,money,type)
    local player = Player.GetPlayer(source)
    if type == "dirty" then
        player.removeBlackMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET dark_money = @money + money where name=@plate',
               {
                    ['@money']   = money,
                    ['@plate'] = plate,
                }
        )
    else
        player.removeMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET money= @money + money where name=@plate',
               {
                    ['@money']   =money,
                    ['@plate'] = plate,
                }
        )
    end
end)
RegisterServerEvent("stockage:RemoveFromAccount")
AddEventHandler("stockage:RemoveFromAccount", function(plate,money,type)
    local player = Player.GetPlayer(source)
    if type == "black_money" then
        player.addBlackMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET dark_money = @money - money where name=@plate',
               {
                    ['@money']   = money,
                    ['@plate'] = plate,
                }
        )
    else
        player.addMoney(money)
        MySQL.Async.execute(
            'UPDATE storages_inventory_accounts SET money= @money - money where name=@plate',
               {
                    ['@money']   =money,
                    ['@plate'] = plate,
                }
        )
    end

end)
RegisterServerCallback('stockage:GetItems', function(source,callback,plate)
    MySQL.Async.fetchAll('SELECT * FROM storages_inventory_items WHERE plate = @palte', {
        ["@palte"] = plate
    }, function(result)

        MySQL.Async.fetchAll('SELECT * FROM storages_inventory_accounts WHERE plate = @palte', {
            ["@palte"] = plate
        }, function(_result)
            if _result[1] == nil then
                MySQL.Async.execute(
                    'INSERT INTO storages_inventory_accounts (plate) VALUES(@plate)',
                    {
                        ['@plate']   =plate,

            
                    }
                )
                
            end
            _result[1] = {}
            _result[1].money = 0
            _result[1].dark_money = 0
            callback(result,_result[1])
        end)
        
    end)
end)
