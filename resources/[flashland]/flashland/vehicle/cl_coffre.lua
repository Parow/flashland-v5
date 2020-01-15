


function IsPedNearTrunk(Player, veh)
	local vec1, vec2 = GetModelDimensions(GetEntityModel(veh))
	local behindVector = -vec3(vec1.x + vec2.x, vec2.y, 0.0)
	
	return GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetOffsetFromEntityInWorldCoords(veh, behindVector), true) < 3.5 or Player.InVehicle
end
function getVehicleHealth(veh)
    return math.floor(math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10)))
end

GetVehicleInDirection = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, 1)
    local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(playerCoords.x, playerCoords.y, playerCoords.z, inDirection.x, inDirection.y, inDirection.z, 10, playerPed, 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)

    return vehicle
end
