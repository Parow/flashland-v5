local function OpenCar()
    local vehicles = GetMyVehicles()
    local vehicle = vehicleFct.GetVehicleInDirection(5.0)
    
    if vehicle ~= 0 then
        local prop_name = 'p_car_keys_01'
        IsAnimated = true
        local playerPed = GetPlayerPed(-1)
        local x, y, z = table.unpack(GetEntityCoords(playerPed))
        propBox1 = CreateObject(GetHashKey(prop_name), x, y, z + 0.1, true, true, true)
        AttachEntityToEntity(propBox1, playerPed, GetPedBoneIndex(playerPed, 58866), 0.080, 0.012, 0.050, 0.0, 100.0, 300.0, true, false, false, true, 1, true)
        RequestAnimDict("anim@mp_player_intmenu@key_fob@")
        while not HasAnimDictLoaded("anim@mp_player_intmenu@key_fob@") do
            Citizen.Wait(0)
        end
        TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

        local plate = GetVehicleNumberPlateText(vehicle)

        for i = 1 , #vehicles.data, 1 do

            if plate == vehicles.data[i].plate then
                local locked = GetVehicleDoorLockStatus(vehicle)
                if locked == 1 or locked == 0 then
                    -- if unlocked
                    SetVehicleDoorsLocked(vehicle, 2)
                    PlayVehicleDoorCloseSound(vehicle, 1)
                    ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
                elseif locked == 2 then
                    -- if locked
                    SetVehicleDoorsLocked(vehicle, 1)
                    PlayVehicleDoorOpenSound(vehicle, 0)
                    ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
                end
                break
                return
            end
        end

        for i = 1 , #vehicles.preter , 1 do
            if plate == vehicles.preter[i].plate then
                local locked = GetVehicleDoorLockStatus(vehicle)
                if locked == 1 or locked == 0 then
                    -- if unlocked
                    SetVehicleDoorsLocked(vehicle, 2)
                    PlayVehicleDoorCloseSound(vehicle, 1)
                    ShowNotification("Vous avez ~r~fermé~s~ le véhicule.")
                elseif locked == 2 then
                    -- if locked
                    SetVehicleDoorsLocked(vehicle, 1)
                    PlayVehicleDoorOpenSound(vehicle, 0)
                    ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
                end
                break
                return
            end
        end
        Wait(1000)
        DeleteObject(propBox1)
    end

end

KeySettings:Add("keyboard","Y",OpenCar,"vehiclelock")