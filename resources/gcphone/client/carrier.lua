local carrier = {
    {pos={x=-178.716,y=-707.5283,z=150.379535},range=5200.0}, -- los santos
    {pos={x=1801.716,y=3641.5283,z=150.379535},range=1700.0}, -- sandy shore
    {pos={x=2069.82,y=4983.5283,z=150.379535},range=1200.0}, -- sandy shore
    {pos={x=-137.741,y=6298.5283,z=150.379535},range=1200.0}, -- paleto
    {pos={x=-2491.741,y=3611.5283,z=150.379535},range=800.0},
    {pos={x=464.741,y=5567.5283,z=150.379535},range=1800.0}, -- MONT CHILLIAD
    {pos={x=-3079.741,y=981.5283,z=150.379535},range=2300.0},
    {pos={x=-2048.741,y=3127.5283,z=150.379535},range=800.0},
    {pos={x=1370.741,y=2692.5283,z=150.379535},range=1500.0},
}
function GetDistanceBetween3DCoords(x1, y1, z1, x2, y2, z2)
    if x1 ~= nil and y1 ~= nil and z1 ~= nil and x2 ~= nil and y2 ~= nil and z2 ~= nil then
        return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
    end
    return -1
end
inCarrier = true
Citizen.CreateThread(function()
    Wait(400)
    ChangeStatus(yes)
    while true do    
        Wait(1000)
        local yes = false
        for i = 1 , #carrier, 1 do
            local x,y,z      = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

            if(GetDistanceBetween3DCoords(x,y,z,carrier[i].pos.x, carrier[i].pos.y,carrier[i].pos.z) < carrier[i].range-(0.3 *carrier[i].range) ) then
                yes = true
            end
        --    DrawMarker(1,  carrier[i].pos.x, carrier[i].pos.y, carrier[i].pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, carrier[i].range, carrier[i].range, carrier[i].range, 255,0,0, 100, false, true, 2, false, false, false, false)
          
        end

            ChangeStatus(yes)


    end

end)

function ChangeStatus(bool)
    if bool ~= inCarrier then
        TriggerServerEvent('gcPhone:allUpdate')
    end
    local m 
    if bool then
        m = "back"
    else
        m = "No services"
    end
    SendNUIMessage({event = 'changeCarrier', carrier = m})
    inCarrier = bool
end

