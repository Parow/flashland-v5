function doAnim(animName, time, flag, ped, customPos)
    if type(animName) ~= "table" then
        animName = { animName }
    end
    ped, flag = ped or GetPlayerPed(-1), flag and tonumber(flag) or false
    if not animName or not animName[1] or string.len(animName[1]) < 1 then
        return
    end
    if IsPedRunningRagdollTask(ped) or IsEntityPlayingAnim(ped, animName[1], animName[2], 3) or IsPedActiveInScenario(ped) and (not typ or typ < 40) then
        ClearPedTasks(ped)
        return
    end
    Citizen.CreateThread(function()
        forceAnim(animName, flag, { ped = ped, time = time, pos = customPos })
    end)
end

local femaleFix = {
    ["WORLD_HUMAN_BUM_WASH"] = { "amb@world_human_bum_wash@male@high@idle_a", "idle_a" },
    ["WORLD_HUMAN_SIT_UPS"] = { "amb@world_human_sit_ups@male@idle_a", "idle_a" },
    ["WORLD_HUMAN_PUSH_UPS"] = { "amb@world_human_push_ups@male@base", "base" },
    ["WORLD_HUMAN_BUM_FREEWAY"] = { "amb@world_human_bum_freeway@male@base", "base" },
    ["WORLD_HUMAN_CLIPBOARD"] = { "amb@world_human_clipboard@male@base", "base" },
    ["WORLD_HUMAN_VEHICLE_MECHANIC"] = { "amb@world_human_vehicle_mechanic@male@base", "base" },
}
function forceAnim(animName, flag, args)
    flag, args = flag and tonumber(flag) or false, args or {}
    local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

    if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then
        return
    end

    if not clearTasks then
        ClearPedTasks(ped)
    end

    if not animName[2] and femaleFix[animName[1]] and GetEntityModel(ped) == -1667301416 then
        animName = femaleFix[animName[1]]
    end

    if animName[2] and not HasAnimDictLoaded(animName[1]) then
        if not DoesAnimDictExist(animName[1]) then
            return
        end
        RequestAnimDict(animName[1])
        while not HasAnimDictLoaded(animName[1]) do
            Citizen.Wait(10)
        end
    end

    if not animName[2] then
        ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
        TaskStartScenarioInPlace(ped, animName[1], -1, not tableHasValue(animBug, animName[1]))
    else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 0, 0, 0, 0, 0)
        else
            TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, flag or 44, animTime or -1, 0, 0)
        end
    end

    if time and type(time) == "number" then
        Citizen.Wait(time)
        ClearPedTasks(ped)
    end

    if not args.dict then
        RemoveAnimDict(animName[1])
    end
end