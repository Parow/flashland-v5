RegisterServerCallback('garage:GetVehicle', function(_, callback,Garage)
        MySQL.Async.fetchAll('SELECT * FROM players_parking WHERE garage =@name', {
            ["@name"] = Garage,

        }, function(result)
            callback(result)
        end)
end)


RegisterServerCallback('vehicles:GetOwnedVehicles', function(_source, callback)
    local ply = Player.GetPlayer(_source)
    MySQL.Async.fetchAll('SELECT * FROM players_vehicles WHERE uuid =@name', {
        ["@name"] = ply.uuid,

    }, function(result)
        callback(result)
    end)
end)

RegisterServerEvent("Garage:StockVehicle")
AddEventHandler("Garage:StockVehicle", function(vehicleData,garage)
    MySQL.Async.execute(
        'INSERT INTO players_parking (vehicles,garage,label) VALUES(@vehicleData,@garage,@label)',
        {
            ['@vehicleData'] = json.encode(vehicleData),
            ['@garage'] = garage,
            ['@label'] = vehicleData.label

        }
    )
end)

RegisterServerEvent("Garage:UpdateLabel")
AddEventHandler("Garage:UpdateLabel", function(id,label)
    MySQL.Async.execute(
        'UPDATE players_parking SET label = @label where id = @id',
        {
            ["@id"] = id,
            ["@label"] = label
        }
    )
end)

RegisterServerEvent("vehicle:PreterCle")
AddEventHandler("vehicle:PreterCle", function(targetSource,plate,label)
    TriggerClientEvent("vehicle:AddTempClé",targetSource,plate,label)
end)
RegisterServerEvent("Garage:SortirVehicule")
AddEventHandler("Garage:SortirVehicule", function(id)
    MySQL.Async.execute(
        'DELETE FROM players_parking where id = @id',
        {
            ["@id"] = id,
            ["@label"] = label
        }
    )
end)