Ped = setmetatable({}, Ped)
local registeredPeds = {}
local spawnedPeds = {}

function Ped:Add(Name, Model, Pos, Anim,cb)
    local name, has, pos, bl, anim, mode, dist = Name, Model, Pos, nil, Anim, nil, 4.5
    RegisterLocalPed({ Model = has, Name = name, Pos = pos, data3D = { name, dist }, Anim = anim },cb)
end

function RegisterLocalPed(a, cb)
    a.cb = cb
    registeredPeds[#registeredPeds + 1] = a
end
function CreatePersistentPed(modelHash, pos, anim, data3D, script, notSend, cb, addData)
    RegisterLocalPed({ Model = modelHash, Pos = pos, data3D = data3D, Anim = anim, stuff = addData }, cb)

    if not notSend then
    end
end
function HoverPlayer()
    local playerId = GetPlayerServerIdInDirection(8.0)
    if playerId ~= false then
        local player = GetPlayerFromServerId(playerId)
        player = GetPlayerPed(player)
        local coords = GetEntityCoords(player)
        local x,y,z = table.unpack(coords)
        DrawMarker(2, x, y, z+1.0, 0, 0, 0, 180.0,nil,nil, 0.1, 0.1, 0.1, 0, 60, 255, 255, false, true, p19, true)
    end    
    
end
local DText = {}
function set3DText(ent, name, dist)
    table.insert(DText, { ent, name, dist })
end
function DrawText3D(x, y, z, name, dist, alpha2)
    local max = dist or 7
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local Player = LocalPlayer()
    local coords = Player.Position
    local dist, dist2 = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1), GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, x, y, z, true) - 1.65
    local scale, alpha = ((1 / dist) * (max * .7)) * (1 / GetGameplayCamFov()) * 100, 255
    if dist2 < max then
        alpha = math.floor(255 * ((max - dist2) / max))
    elseif dist2 >= max then
        alpha = 0
    end
    alpha = alpha2 or alpha
    SetTextFont(0)
    SetTextScale(.0 * scale, .1 * scale)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, alpha)))
    SetTextCentre(1)
    SetDrawOrigin(x, y, z, 0)
    SetTextEntry("STRING")
    AddTextComponentString(name)
    DrawText(0.0, 0.0)

    ClearDrawOrigin()
end
textToDraw = {}
Citizen.CreateThread(function()
    local getDistanceBetweenCoords, getEntityCoords = GetDistanceBetweenCoords, GetEntityCoords
    while true do
        Citizen.Wait(500)

        local Player = LocalPlayer()

        local ped, plyPos = Player.Ped, Player.Position
        for k, v in pairs(DText) do
            local pos = type(v[1]) == "table" and v[1] or getEntityCoords(v[1])

            if GetDistanceBetween3DCoords(plyPos.x, plyPos.y, plyPos.z, pos.x, pos.y, pos.z, true) <= (v[3] or 8) and (type(v[1]) == "table" or HasEntityClearLosToEntityInFront(ped, v[1])) then
                textToDraw[k] = true
            elseif textToDraw[k] then
                textToDraw[k] = nil
            end
        end

    end
end)

Citizen.CreateThread(function()
    local isControlJustPressed, getEntityCoords, drawText3D = IsControlJustPressed, GetEntityCoords, DrawText3D
    local isInputDisabled = IsInputDisabled
    while true do
        Citizen.Wait(0)
        local Player = LocalPlayer()
        local ped, vehicle = Player.Ped, Player:GetVehicle()
        for k, v in pairs(DText) do
            if textToDraw[k] then
                local pos = type(v[1]) == "table" and v[1] or getEntityCoords(v[1])
                drawText3D(pos.x, pos.y, pos.z + (type(v[1]) == "table" and 2 or 1), v[2], v[3])
            end
        end
    end
end)
local function CreateLocalPed(a)
    RequestAndWaitModel(a.Model)
    local ped = CreatePed(4, a.Model, a.Pos.x, a.Pos.y, a.Pos.z, a.Pos.a or 0.0, false, false)
    FreezeEntityPosition(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedRandomComponentVariation(ped, true)
    if a.Struct then
        setPlayerSkin(a.Struct, { ped = ped })
    else
        SetPedRandomProps(ped)
        SetPedRandomComponentVariation(ped, true)
    end
    SetPedFleeAttributes(ped, 0, 0)
    SetPedKeepTask(ped, true)

    if a.data3D and a.data3D[1] then
        set3DText(ped, a.data3D[1], a.data3D[2])
    end
    if a.Anim then
        forceAnim(a.Anim, 1, { ped = ped })
    end
    if a.cb then
        a.cb(ped, a.stuff)
    end
    return ped
end
function setupPed(name, has, pos, bl, anim, mode, dist)
    RegisterLocalPed({ Model = has, Name = name, Pos = pos, data3D = { name, dist }, Anim = anim })
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local Player = LocalPlayer()
        local coords = Player.Position
        for k, v in pairs(registeredPeds) do
            local playerClose = GetDistanceBetween3DCoords(coords.x, coords.y, coords.z, v.Pos.x, v.Pos.y, v.Pos.z, true) < 30
            if not spawnedPeds[k] and playerClose then
                spawnedPeds[k] = CreateLocalPed(v)
            elseif spawnedPeds[k] and not playerClose then
                DeleteEntity(spawnedPeds[k])
                spawnedPeds[k] = nil
            end
        end
    end
end)








