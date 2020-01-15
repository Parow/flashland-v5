RegisterServerEvent("vehicle:UnTowVehicle")
AddEventHandler("vehicle:UnTowVehicle", function(id)
    MySQL.Async.execute(
        'UPDATE players_vehicles SET pound = 0 where id = @id',
        {
            ["@id"] = id,
        }
    )
end)