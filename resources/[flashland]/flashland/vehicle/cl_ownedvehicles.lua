local MyVehicles = {
    data = {
        {
            label = "Vide",
            plate = "" 
        }
    },
    preter = {

    }
}



function MyVehicles.RefreshVehicles()
    TriggerServerCallback('vehicles:GetOwnedVehicles', function(Data)
        MyVehicles.data = Data
    end)
end

function GetMyVehicles()
    return MyVehicles
end

function SaveMyVehicles(table)
    MyVehicles = table
end