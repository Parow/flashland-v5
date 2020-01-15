
local Computer = {
	["prop_cs_keyboard_01"] = { },
	["prop_keyboard_01a"] = { },
	["prop_keyboard_01b"] = { },
    ["ex_prop_ex_laptop_01a"] = {},
    ["gr_prop_gr_laptop_01b"] = {},
    ["gr_prop_gr_laptop_01c"] = {},
    ["p_cs_laptop_02"] = {},
    ["p_laptop_02_s"] = {},
    ["prop_laptop_01a"] = {},
}
local Cameras = {
    LSPD01 = {
        {x = 444.45, y = -975.11, z = 33.10,x1=-200.0,y1=-180.0,z1=29.39},
        {x = 449.45, y = -988.85, z = 33.10,x1=-200.0,y1=-180.0,z1=140.39},
        {x = 460.3, y = -986.73, z = 32.80,x1=-200.0,y1=-180.0,z1=100.39},
    }
}
local SpecialComputersList = {
    lspd01 = {
        Pos = {x=441.9772,z=-979.3787,y=30.42537},
        LinkedCameras = Cameras.LSPD01,
        boss = "police",
        Buttons = {
            {label="Casier judiciaire",submenu="criminal_records",fct=function()
                if isPermTo("casier") then
                    TriggerServerCallback('criminalrecords:GetAll', function(data)
                        CurrentSession.casier = data
                    end)
                else
                    Wait(100)
                    RageUI.GoBack()
                    RageUI.Popup({message="~r~Vous n'avez pas la permission d'acceder à ceci\n~s~Adressez vous au ~b~patron"})
                end
            end},
            {label="Gestion caméras",submenu="gestion_cam",fct=function()
                if isPermTo("gestion_cam_LSPD01") then
                    CurrentSession.cameras = Cameras.LSPD01
                else
                    Wait(100)
                    RageUI.GoBack()
                    RageUI.Popup({message="~r~Vous n'avez pas la permission d'acceder à ceci\n~s~Adressez vous au ~b~patron"})
                end
            end}

        }
    },
    lspd02 = {
        Pos = {x=440.1752,z=-979.3462,y=30.42502},
        LinkedCameras = Cameras.LSPD01,
        boss = "police",
        Buttons = {
            {label="Casier judiciaire",submenu="criminal_records",fct=function()
                if isPermTo("casier") then
                    TriggerServerCallback('criminalrecords:GetAll', function(data)
                        CurrentSession.casier = data
                    end)
                else
                    Wait(100)
                    RageUI.GoBack()
                    RageUI.Popup({message="~r~Vous n'avez pas la permission d'acceder à ceci\n~s~Adressez vous au ~b~patron"})
                end
            end},
            {label="Gestion caméras",submenu="gestion_cam",fct=function()
                if isPermTo("gestion_cam_LSPD01") then
                    CurrentSession.cameras = Cameras.LSPD01
                else
                    Wait(100)
                    RageUI.GoBack()
                    RageUI.Popup({message="~r~Vous n'avez pas la permission d'acceder à ceci\n~s~Adressez vous au ~b~patron"})
                end
            end}
        }
    },
}
local CurrentComputer = nil
local SpecialComputer = nil

function isPermTo(perm)
    if CurrentSession.perms ~= nil then
        for i = 1 , #CurrentSession.perms,1 do
            if CurrentSession.perms[i] == perm then
                return true
            end
        end
    end
    return false
end
function isNearComputer()
    local found = false
    local m = nil
    local plyPos = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Computer) do
        local obj = GetClosestObjectOfType(plyPos, 3.0, GetHashKey(k), false, true, true)
        if obj and DoesEntityExist(obj) and GetDistanceBetweenCoords(plyPos, GetEntityCoords(obj), true) < 1.2 then

            if CurrentComputer == obj then
                m = true
            else
                m = false
                CurrentComputer = obj
            end
            local x,y,z = table.unpack(GetEntityCoords(obj))
            ObjCoords = {x=x,y=y,z=z}
            for k , v in pairs(SpecialComputersList) do
                if v.Pos.x-ObjCoords.x <=0.1 and v.Pos.z-ObjCoords.z <= 0.1   then
                    SpecialComputer = k
                    break
                end
            end

            found = true
            break
        end
    end

    return found, m

end

function OpenComputer()
    local bool,m = isNearComputer()
    SpecialComputer = SpecialComputersList[SpecialComputer]

    if bool then
        ToggelComputerMenu(m,SpecialComputer)
    end
end
KeySettings:Add("keyboard","E",OpenComputer,"Computer")


local Bin = {
	["prop_dumpster_01a"] = { },

} 

function isNearBin()
    local found = false
    local _obj = false
    local plyPos = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(Bin) do
        local obj = GetClosestObjectOfType(plyPos, 3.0, GetHashKey(k), false, true, true)
        if obj and DoesEntityExist(obj) and GetDistanceBetweenCoords(plyPos, GetEntityCoords(obj), true) < 2.8 then
            found = true
            _obj = obj
            break
        end
    end

    return found, _obj

end

local _Items = Items
local propsFouilled =  {}
local Items = {
    {item="bread",chance=50},
    {item="water",chance=50},
    {item="hammer",data=json.encode({serial=math.random(111111111,999999999)}),chance=4},
    {item="knuckle",data=json.encode({serial=math.random(111111111,999999999)}),chance=4},
    {item="bottle",data=json.encode({serial=math.random(111111111,999999999)}),chance=8},
    {item="crowbar",data=json.encode({serial=math.random(111111111,999999999)}),chance=4},
    {item="snspistol",data=json.encode({serial=math.random(111111111,999999999)}),chance=11},
    {item="cana",chance=10},
    {item="menottes",chance=10},
}

local function CheckBin()
    local found,prop = isNearBin()
    if #propsFouilled == 10 then
        return RageUI.Popup({message="Vous avez ~r~déjà ~s~fouillé trop de poubelle pour aujourd'hui"})
    end
    for i = 1 , #propsFouilled ,1 do
        if prop == propsFouilled[i] then
            RageUI.Popup({message="Vous avez ~r~déjà ~s~fouillé cette poubelle"})
            return
        end
    end
    if found then
        table.insert(propsFouilled,prop)
        exports['mythic_progbar']:Progress({
            name = "unique_action_name",
            duration = 4500,
            label = 'Fouille en cours...',
            useWhileDead = true,
            canCancel = false,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = "anim@gangops@morgue@table@",
                anim = "player_search",
                flags = 1,
            },
        }, function(cancelled)
            if not cancelled then
                ClearPedTasksImmediately(GetPlayerPed(-1))
                local random = math.random(1,100)
                local found = false
                local random2 = math.random(1,10)
                if random2 > 4 then
                        for i = 1 , #Items , 1 do
                            if random ==  Items[i].chance then
                                found = true
                                if Inventory.CanReceive(Items[i].item,1) then
                                    RageUI.Popup({message="Vous avez trouvé 1 ~b~" .. string.lower(_Items[Items[i].item].label) .."~s~ dans la poubelle"})
                                    local items = {name=Items[i].item,data=Items[i].data}
                                    TriggerServerEvent("inventory:AddItem", items)
                                end
                                break
                            end
                        end
                        if not found then
                            for i = 1 , #Items , 1 do
                                if 50 <=  Items[i].chance then
                                    found = true
                                    if Inventory.CanReceive(Items[i].item,1) then
                                        RageUI.Popup({message="Vous avez trouvé 1 ~b~" .. string.lower(_Items[Items[i].item].label) .."~s~ dans la poubelle"})
                                        local items = {name=Items[i].item,data=Items[i].data}
                                        TriggerServerEvent("inventory:AddItem", items)
                                        
                                    end
                                    break
                                end
                            end
                        end

                else
                    RageUI.Popup({message="Vous n'avez ~r~rien~s~ trouvé"})
                end
            else
                -- Do Something If Action Was Cancelled
            end
        end)
    end
end
KeySettings:Add("keyboard","E",CheckBin,"BIN")


local distributor = {
	["prop_vend_coffe_01"] = { it = "cafe", max = 2 },
	["prop_vend_soda_02"] = { it = "cola", max = 1 },
	["prop_watercooler"] = { it = "water", max = 1 },
	["prop_watercooler_dark"] = { it = "water", max = 1 },
}

function isNearDistributor()
    local found = false
    local _obj = false
    local plyPos = GetEntityCoords(GetPlayerPed(-1))
    for k,v in pairs(distributor) do
        local obj = GetClosestObjectOfType(plyPos, 3.0, GetHashKey(k), false, true, true)
        if obj and DoesEntityExist(obj) and GetDistanceBetweenCoords(plyPos, GetEntityCoords(obj), true) < 1.6 then
            found = true
            _obj = v
            break
        end
    end
    return found, _obj
end
local function BuyCan()
    local found,v = isNearDistributor()
    if found then
        if Inventory.CanReceive(v.it,1) then
            local canBuy = Money:CanBuy(5)
            if canBuy then
                local items = {name=v.it}
                TriggerServerEvent("inventory:AddItem", items)
                TriggerServerEvent("money:Pay", 5 )
            end
        end
    end
end

KeySettings:Add("keyboard","E",BuyCan,"DIstri")
