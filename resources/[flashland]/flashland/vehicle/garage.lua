Garage = setmetatable({}, Garage)
Garage.__index = Garage
Garage.__call = function() return "Garage" end
local currentSelf = {}
local MYVEHJOB = nil
DecorRegister('isJob', 3)
function Garage.New(name,pos,properties,blipdata)
    local GarageProperties = {
        name = name,
        pos = pos,
        properties = properties,
        blipdata = blipdata
    }
    return setmetatable(GarageProperties, Garage)
end

local function Open()
    currentSelf:Refresh()
end

function Garage:Refresh()
    local m = {}
    if self.properties.type == 1 then
        for i = 1 , #self.properties.vehicles, 1 do
            if self.properties.vehicles[i] ~= nil then
                if self.properties.vehicles[i].job then
                    table.insert(m,self.properties.vehicles[i])
                end
            end
        end
        self.properties.vehicles = m
    else
        self.properties.vehicles = {}
    end
    TriggerServerCallback('garage:GetVehicle', function(data)
        for i = 1 , #data, 1 do
            table.insert(self.properties.vehicles,data[i])
        end
        
        RMenu:Get('garage', self.name):SetPageCounter(#self.properties.vehicles .. "/" .. self.properties.Limit.. " véhicules dans le garage")
        RageUI.Visible(RMenu:Get('garage', self.name),true)
    end,self.name)

end

function Garage:Setup()
    Zone:Add(self.pos,function()
        currentSelf = self
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage")
        KeySettings:Add("keyboard","E",Open,self.name)
        KeySettings:Add("controller",46,Open,self.name)
       
    end,function()
        Hint:RemoveAll()
        KeySettings:Clear("keyboard","E",self.name)
        KeySettings:Clear("controller","E",self.name)
        RageUI.Visible(RMenu:Get('garage',self.name),false)
        RageUI.Visible(RMenu:Get('garage',self.name.."_manage"),false)
        currentSelf = {}
    end,k,2.5)
    RMenu.Add('garage',self.name, RageUI.CreateMenu(nil, "Véhicules disponibles",10,100))
    RMenu.Add('garage', self.name.."_manage", RageUI.CreateSubMenu(RMenu:Get('garage', self.name),nil, "Actions disponibles",10,100))
    local blip = AddBlipForCoord(self.pos.x, self.pos.y, self.pos.z)
    if self.blipdata.BlipId == nil then
        self.blipdata.BlipId = 357
    end
    SetBlipSprite (blip, self.blipdata.BlipId )
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip,  self.blipdata.Blipcolor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(self.blipdata.Blipname)
    EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
    while true do 
        Wait(1)
        if currentSelf.name ~= nil then
            if RageUI.Visible(RMenu:Get('garage', currentSelf.name)) then
                RageUI.DrawContent({ header = false, glare = false }, function()

                    RageUI.Button("Rentrer le véhicule", nil, {  }, true, function(_, Active, Selected)
                        if Selected then
                            currentSelf:PutInVeh()
                            Wait(200)
                            currentSelf:Refresh()
                        end
                    end)
                    if currentSelf.properties.type == 1 then
                        currentSelf:Selfservice()
                    end

                    if currentSelf.properties.type == 0 then
                        currentSelf:RealGarage()
                    end
                end, function()

                end)
            end

            if RageUI.Visible(RMenu:Get('garage', currentSelf.name.."_manage")) then
                local i = currentSelf.CurrentIndex
                RageUI.DrawContent({ header = false, glare = false }, function()
                    RageUI.Button("Sortir le véhicule", nil, {  }, true, function(_, Active, Selected)
                        if Selected then
                            local veh = json.decode(currentSelf.properties.vehicles[i].vehicles)
                            local t = vehicleFct.GetVehiclesInArea(currentSelf.properties.spawnpos,5.0)
                            if #t > 0 then
                                RageUI.Popup({message="La zone est ~r~occupée"})
                            else
                                vehicleFct.SpawnVehicle(veh.model,currentSelf.properties.spawnpos , currentSelf.properties.spawnpos.h, function(vehicle)
                                    vehicleFct.SetVehicleProperties(vehicle, veh)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                                    RageUI.Visible(RMenu:Get('garage', currentSelf.name.."_manage"),false) 
                                end)
                                TriggerServerEvent("Garage:SortirVehicule",currentSelf.properties.vehicles[i].id)
                                
                                RageUI.GoBack()
                                Wait(200)
                                currentSelf:Refresh()
                            end
                        end
                    end)

                    RageUI.Button("Renommer le véhicule", nil, {  }, true, function(_, Active, Selected)
                        if Selected then
                            currentSelf.properties.vehicles[i].label= KeyboardInput("Entrez votre mot de passe",currentSelf.properties.vehicles[i].label,30)

                            TriggerServerEvent("Garage:UpdateLabel",currentSelf.properties.vehicles[i].id,currentSelf.properties.vehicles[i].label)
                            RageUI.GoBack()
                        end
                    end)
                end, function()
                end)
            end
        end
    end
end)


function Garage:Selfservice()
    for i = 1 , #self.properties.vehicles, 1 do
        if self.properties.vehicles[i] ~= nil then
            RageUI.Button(self.properties.vehicles[i].label, nil, {  }, true, function(_, Active, Selected)
                if Selected then
                    local t = vehicleFct.GetVehiclesInArea(self.properties.spawnpos,5.0)
                    if #t > 0 then
                        RageUI.Popup({message="La zone est ~r~occupée"})
                    else

                        if self.properties.vehicles[i].job then
                            if MYVEHJOB == nil then
                                vehicleFct.SpawnVehicle(self.properties.vehicles[i].name,self.properties.spawnpos , self.properties.spawnpos.h, function(veh)
                                    --vehicleFct.SetVehicleProperties(veh, currentSelf.properties.vehicles[i].tuning)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                    MYVEHJOB = veh
                                    DecorSetInt(veh, "isJob", 1)
                                    RageUI.Visible(RMenu:Get('garage', self.name),false) 
                                end)
                            else
                                ShowNotification("~r~Vous avez déjà sorti un véhicule")
                            end
                        else
                            local veh = json.decode(self.properties.vehicles[i].vehicles)
                            
                            local t = vehicleFct.GetVehiclesInArea(self.properties.spawnpos,5.0)
                            if #t > 0 then
                                RageUI.Popup({message="La zone est ~r~occupée"})
                            else
                                vehicleFct.SpawnVehicle(veh.model,self.properties.spawnpos , self.properties.spawnpos.h, function(vehicle)
                                    vehicleFct.SetVehicleProperties(vehicle, veh)
                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                                    RageUI.Visible(RMenu:Get('garage', self.name.."_manage"),false) 
                                end)
                                TriggerServerEvent("Garage:SortirVehicule",self.properties.vehicles[i].id)
                                
                                RageUI.GoBack()
                                Wait(200)
                                self:Refresh()
                            end
                        end
                    end
                end
            end)
        end
    end
end

function Garage:RealGarage()
    if self.properties.vehicles[1] == nil then
        RageUI.Button("Vide", nil, {  }, true, function(_, Active, Selected)
        end)
    end
    for i = 1,#self.properties.vehicles , 1 do
        local veh = json.decode(self.properties.vehicles[i].vehicles)
        
        RageUI.Button(self.properties.vehicles[i].label, nil, {  }, true, function(_, Active, Selected)
            if Selected then
                self.CurrentIndex = i
            end
        end,RMenu:Get('garage', self.name.."_manage"))
    end
end

function Garage:PutInVeh()
    local ped = LocalPlayer().Ped
    local veh = GetVehiclePedIsUsing(ped)
    if veh ~= 0 then
        if #self.properties.vehicles + 1 <= self.properties.Limit then

            if DecorGetInt (veh, "isJob") == 0 then
                TriggerServerEvent("Garage:StockVehicle",vehicleFct.GetVehicleProperties(veh),self.name)
            else
                MYVEHJOB = nil
            end
            DeleteEntity(veh)
        else
            RageUI.Popup({message="~r~Il n'y a plus de place dans le garage"})
        end
    end
end
---- public garage
local PublicGarage = {
    {
        Pos = {x=275.39,y=-326.43,z=43.92},
        Properties = {
            type = 0,
            spawnpos = {x=275.39,y=-326.43,z=43.92,h=159.63}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=275.39,y=-326.43,z=43.92}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_1"
    },
    {
        Pos = {x=40.72,y=-859.11,z=29.62,h=336.63}, 
        Properties = {
            type = 0,
            spawnpos = {x=40.72,y=-859.11,z=29.62,h=336.63}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=40.72,y=-859.11,z=29.62,h=336.63}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_2"
    },
    {
        Pos = {x=-1176.43,y=-740.26,z=18.96,h=336.63}, 
        Properties = {
            type = 0,
            spawnpos = {x=40.72,y=-859.11,z=29.62,h=336.63}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=40.72,y=-859.11,z=29.62,h=336.63}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_3"
    },
    {
        Pos = {x=1465.34,y=3739.25,z=32.54,h=214.3}, 
        Properties = {
            type = 0,
            spawnpos = {x=1465.34,y=3739.25,z=32.54,h=214.3}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1465.34,y=3739.25,z=32.54,h=214.3}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_4"
    },
    {
        Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
        Properties = {
            type = 0,
            spawnpos ={x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_5"
    },
    {
        Pos = {x=-232.06,y=6257.43,z=30.49,h=176.8}, 
        Properties = {
            type = 0,
            spawnpos ={x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_6"
    },
    {
        Pos = {x=-2199.06,y=4254.68,z=46.78,h=99.8}, 
        Properties = {
            type = 0,
            spawnpos ={x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_7"
    },
    {
        Pos = {x=-3145.09,y=1098.0,z=19.7,h=308.8}, 
        Properties = {
            type = 0,
            spawnpos ={x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_8"
    },
    {
        Pos = {x=-969.17,y=-2702.08,z=12.85,h=91.7}, 
        Properties = {
            type = 0,
            spawnpos ={x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1704.06,y=4802.86,z=40.78,h=112.8}, 
            Blipcolor  =84,
            Blipname = "Garage"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_9"
    },
    {
        Pos = {x=-968.96,y=-3003.58,z=13.95,h=59.47}, 
        Properties = {
            type = 0,
            spawnpos ={x=-968.96,y=-3003.58,z=13.95,h=59.47}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=-968.96,y=-3003.58,z=13.95,h=59.47}, 
            Blipcolor  =84,
            BlipId = 359,
            Blipname = "Garage avion"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_10"
    },
    {
        Pos = {x=1791.96,y=3268.12,z=41.23,h=59.47}, 
        Properties = {
            type = 0,
            spawnpos ={x=1791.96,y=3268.12,z=41.23,h=59.47}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=1791.96,y=3268.12,z=41.23,h=59.47}, 
            Blipcolor  =84,
            BlipId = 359,
            Blipname = "Garage avion"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_11"
    },
    {
        Pos = {x=2128.71,y=4806.65,z=40.23,h=114.91}, 
        Properties = {
            type = 0,
            spawnpos ={x=2128.71,y=4806.65,z=40.23,h=114.91}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=2128.71,y=4806.65,z=40.23,h=114.91}, 
            Blipcolor  =84,
            BlipId = 359,
            Blipname = "Garage avion"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_12"
    },
    {
        Pos = {x=3856.16,y=4454.6,z=-0.1,h=259.18}, 
        Properties = {
            type = 0,
            spawnpos ={x=3856.16,y=4454.6,z=-0.1,h=259.18}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=3856.16,y=4454.6,z=-0.1,h=259.18}, 
            Blipcolor  =84,
            BlipId = 356,
            Blipname = "Garage bateau"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_13"
    },
    {
        Pos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63}, 
        Properties = {
            type = 0,
            spawnpos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63}, 
            Blipcolor  =84,
            BlipId = 356,
            Blipname = "Garage bateau"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_14"
    },
    {
        Pos = {x=1324.22,y=4220.79,z=29.54,h=242.63}, 
        Properties = {
            type = 0,
            spawnpos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63}, 
            Limit = 10,
        },
        Blipdata = {
            Pos = {x=-854.21,y=-1336.57,z=-0.1,h=108.63}, 
            Blipcolor  =84,
            BlipId = 356,
            Blipname = "Garage bateau"
        },
        Marker = {
            type = 1,
            scale = {x=2.5,y=2.5,z=0.2},
            color = {r=255,g=255,b=255,a=120},
            Up = false,
            Cam = false,
            Rotate = false,
            visible = true
        },
        Name = "garage_15"
    }

}
Citizen.CreateThread(function()
    for _,v in pairs(PublicGarage) do
        Marker:Add(v.Pos,v.Marker)
        local garage = Garage.New(v.Name,v.Pos,v.Properties,v.Blipdata)
        garage:Setup()
    end
end)
