
Citizen.CreateThread(function ()
	local b = false
	
	local VehicleInteractions = {
		{ --[[bone = "door_dside_f",]] door = 0, seat = -1 }, -- Door left front (driver)
		{ --[[bone = "door_pside_f",]] door = 1, seat =  0 }, -- Door right front
		{ --[[bone = "door_dside_r",]] door = 2, seat = 1 }, -- Door left back
		{ --[[bone = "door_pside_r",]] door = 3, seat = 2 }, -- Door right back
	}
	ResetCurrentIntensity()
	while true do
	
		if IsControlJustPressed(0, 23, true) then
			local ped = PlayerPedId()
			if GetIsTaskActive(ped, 160) then
				local nearest
				local dist = math.huge
				local ppos = GetEntityCoords(ped)
				local vehicle = GetVehiclePedIsTryingToEnter(ped)

				if DoesEntityExist(vehicle) and GetSeatPedIsTryingToEnter(ped) == -1 then
					local bone
					local len
					local coords

					for i, v in ipairs(VehicleInteractions) do
						coords = false

						-- Use bone coords
						if v.bone then
							bone = GetEntityBoneIndexByName(vehicle, v.bone)

							if bone ~= -1 then
								coords = GetWorldPositionOfEntityBone(vehicle, bone)
							end

						-- Use entry position
						elseif v.door and DoesVehicleHaveDoor(vehicle, v.door) then
							coords = GetEntryPositionOfDoor(vehicle, v.door)
						end

						-- Is interaction is nearest
						if coords then
							len = GetDistanceBetweenCoords(vector3(ppos.x, ppos.y, ppos.z), coords)
							 -- Ignore out of interaction range
							if v.range and len > v.range then
							elseif len < dist then
								dist = len
								nearest = i
							end
						end
					end
				end

				if nearest then
					nearest = VehicleInteractions[nearest]

					if not nearest.seat then
						local door = nearest.door
						if door then -- open the door specified
							ClearPedTasks(ped)
							ClearPedTasksImmediately(ped)

							if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
								SetVehicleDoorShut(vehicle, door, false)
								PlayVehicleDoorCloseSound(vehicle, 1)
							else
								SetVehicleDoorOpen(vehicle, door, false, false)
								PlayVehicleDoorOpenSound(vehicle, 0)
							end
						end
					else
						local seat = nearest.seat
						local occupant = GetPedInVehicleSeat(vehicle, seat)

						if DoesEntityExist(occupant) then
							local rel1 = GetRelationshipBetweenPeds(ped, occupant)
							if seat ~= -1 then ClearPedTasks(ped) end
							if rel1 >= 3 and rel1 <= 5 or rel1 == 255 then
							end
						else
							ClearPedTasks(ped)
							CanShuffleSeat(vehicle, false)
							TaskEnterVehicle(ped, vehicle, -1, seat, 1.0, 1, 0)
						end
					end
				end
			end
		elseif GetIsTaskActive(PlayerPedId(), 160) and (IsControlJustPressed(1, Keys["Q"]) or IsControlJustPressed(1, Keys["S"]) or IsControlJustPressed(1, Keys["D"])) then
			ClearPedTasks(PlayerPedId())
		end

		Citizen.Wait(0)
	end
end)