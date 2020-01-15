local VehShop = setmetatable({
    -- veh
    {
        Pos = { x = -44.08, y = -1097.99, z = 25.42, a = 67.85 },
        SpawnPos = {x=-16.38,y=-1083.92,z=26.88,h=76.68},
        Blips = {
            sprite = 523,
            color = 84,
            name = "Concessionnaire voiture",
        },
        Menus = {
            Sprite = "shopui_title_ie_modgarage",
            Enabled = true
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

		Vehicles = {
			["Compacts"] = {
                {name="blista",price=9000},
                {name="brioso",price=3000},
                {name="dilettante",price=4000},
                {name="issi",price=4000},
                {name="panto",price=1750},
                {name="prairie",price=4700},
                {name="rhapsody",price=2500},
                {name="issi2",price=6500},
                {name="kalahari",price=4250},
                {name="bifta",price=4150},
			},
			["Coupés"] = {
                {name="cogcabrio",price=79700},
                {name="f620",price=70000},
                {name="faction",price=31500},
                {name="felon",price=39000},
                {name="felon2",price=47500},
                {name="jackal",price=55600},
                {name="sentinel",price=36000},
                {name="sentinel2",price=44500},
                {name="windsor",price=102000},
                {name="zion",price=31700},
                {name="zion2",price=38300},
                {name="windsor2",price=13300},
            },
            ["Sport"] = {

                {name="alpha",price=79500},
                {name="banshee",price=86900},
                {name="bestiagts",price=170000},
                {name="buffalo",price=85000},
                {name="buffalo2",price=99900},
                {name="carbonizzare",price=165000},
                -- {name="comet",price=92100},
                {name="fusilade",price=51000},
                {name="futo",price=32500},
               -- {name="gb200",price=1},
                {name="italigto",price=184700},
                {name="jester",price=110000},
                {name="khamelion",price=178500},
                {name="kuruma",price=75000},
				{name="lynx",price=126500},
				{name="exemplar",price=77850},				
                {name="mamba",price=105000},
                {name="massacro",price=115000},
                {name="neon",price=205000},
                {name="omnis",price=120000},
                {name="pariah",price=355000},
                {name="penumbra",price=77500},
                {name="raiden",price=140000},
                {name="rapidgt",price=120000},
                {name="revolter",price=63800},
                {name="schwarzer",price=66000},
                {name="seven70",price=238600},
                {name="specter",price=235000},
                {name="surano",price=96000},
                {name="verlierer",price=256000},
            },
			["Supersportive"] = {
                {name="adder",price=685000},
                {name="t20",price=800000},
                -- {name="811",price=545000},
                {name="autarch",price=1200000},
                {name="bullet",price=319000},
                {name="cheetah",price=526000},
                {name="cyclone",price=688500},
                {name="sheava",price=1000000},
                {name="fmj",price=1500000},
                {name="gp1",price=745000},
                {name="infernus",price=340000},
                {name="italigtb",price=823000},
                {name="nero",price=965000},
                {name="nero2",price=1550000},
                {name="osiris",price=735000},
                {name="penetrator",price=640000},
                {name="reaper",price=930000},
                {name="tempesta",price=660000},
                {name="turismo2",price=850000},
                {name="tyrant",price=735000},
                {name="tyrus",price=685000},
                {name="vacca",price=556000},
                {name="vagner",price=956000},
                {name="zentorno",price=715000},
            },
			["Muscle"] = {
                {name="blade",price=26800},
                {name="buccaneer",price=24000},
                {name="buccaneer2",price=31000},
                {name="chino",price=22000},
                {name="chino2",price=28000},
                {name="clique",price=47300},
                {name="dominator",price=62800},
                {name="dukes",price=21500},
                {name="ellie",price=41250},
                {name="gauntlet",price=37450},
                {name="hotknife",price=38000},
                {name="impaler",price=32400},
                {name="minivan",price=27500},
                {name="nightshade",price=41250},
                {name="phoenix",price=36800},
                {name="picador",price=38450},
                {name="ruiner",price=25000},
                {name="sabregt",price=43500},
                {name="slamvan",price=48500},
                {name="stallion",price=36000},
                {name="tampa",price=39000},
                {name="tulip",price=3800},
                {name="vamos",price=41500},
                {name="vigero",price=25600},
                {name="virgo",price=23700},
                {name="voodoo",price=16500},
			},
			["Suvs"] = {
                {name="baller",price=45500},
                {name="baller3",price=61500},
                {name="baller4",price=69500},
                {name="baller5",price=75500},
                {name="baller6",price=78500},
                {name="cavalcade2",price=28500},
                {name="dubsta",price=40000},
                {name="dubsta2",price=58000},
                {name="dubsta3",price=67000},
                {name="fq2",price=55000},
                {name="granger",price=74000},
                {name="gresley",price=40000},
                {name="habanero",price=28500},
                {name="huntley s",price=55000},
                {name="landstalker",price=36500},
                {name="mesa",price=30500},
                {name="mesa2",price=48500},
                {name="mesa3",price=35018},
                {name="radius",price=27500},
                {name="rocoto",price=42500},
                {name="seminole",price=36500},
                {name="serrano",price=29000},
                {name="toros",price=135000},
                {name="xls",price=75000},
            },
			["Sedans"] = {
                {name="asea",price=5000},
                {name="asea2",price=7500},
                {name="asterope",price=6000},
                {name="cheburek",price=11000},
                {name="cognoscenti",price=55000},
                {name="cognoscenti2",price=70000},
                {name="emperor",price=16000},
                {name="emperor2",price=19000},
                {name="emperor3",price=22700},
                {name="glendale",price=26750},
                {name="ingot",price=11350},
                {name="intruder",price=24500},
                {name="oracle",price=36500},
                {name="oracle2",price=39000},
                {name="premier",price=19000},
                {name="primo",price=23000},
                {name="primo2",price=30500},
                {name="regina",price=6500},
                {name="sultan",price=27850},
                {name="schafter",price=48000},
                {name="schafter2",price=92500},
                {name="schafter3",price=73900},
                {name="stafford",price=112500},
                {name="stanier",price=24900},
                {name="stratum",price=13000},
                {name="strech",price=145000},
                {name="superd",price=125000},
                {name="surge",price=10200},
                {name="tailgater",price=42500},
                {name="warrener",price=28500},
                {name="washington",price=31600},
            },
			["Classique"] = {
                {name="z190",price=67500},
             --   {name="ardent",price=1},
                {name="casco",price=60000},
                {name="cheetah2",price=352100},
                {name="coquette2",price=132000},
                {name="coquette3",price=96400},
                {name="gt500",price=86000},
                {name="hermes",price=145000},
                {name="hustler",price=62500},
                {name="infernus2",price=280000},
                {name="manana",price=20000},
                {name="michelli",price=65000},
                {name="monroe",price=190000},
                {name="peyote",price=30000},
                {name="pigalle",price=17000},
                {name="rapidgt3",price=110000},
                {name="retinue",price=78500},
                {name="roosevelt",price=165000},
                {name="vestra",price=40750},
                {name="sentinel3",price=86000},
                {name="stinger",price=125000},
                {name="stingergt",price=150000},
                {name="swinger",price=17400},
                {name="torero",price=158500},
                {name="turismor",price=207000},
                {name="ztype",price=270000},
			},
			["4x4"] = {
                {name="bison",price=55500},
                {name="bobcatxl",price=52900},
                {name="contender",price=87500},
                {name="sadler",price=49350},
            },
			["Motos"] = {
                {name="akuma",price=50800},
                {name="avarus",price=36000},
                {name="bagger",price=14500},
                {name="bati",price=75000},
                {name="bati2",price=79000},
                {name="bf400",price=62900},
                {name="carbonrs",price=97600},
                {name="chimera",price=57000},
                {name="cliffhanger",price=35000},
                {name="daemon",price=26000},
                {name="defiler",price= 96000},
                {name="diabolus",price=56000},
                {name="diabolus2",price=93000},
                {name="double",price=68000},
                {name="enduro",price=24500},
                {name="esskey",price=36000},
                {name="faggio",price=1600},
                {name="faggio2",price=3200},
                {name="gargoyle",price=61500},
                {name="hakuchou",price=78500},
                {name="hakuchou2",price=96000},
                {name="hexer",price=43900},
                {name="innovation",price=48450},
                {name="ratbike",price=27800},
                {name="ruffian",price=46000},
                {name="sanchez",price=34100},
                {name="sanchez2",price=47000},
                {name="sovereign",price=55000},
                {name="thrust",price=70000},
                {name="vader",price=42500},
                {name="vortex",price=63000},
                {name="wolsbane",price=41000},
                {name="zombiea",price=36750},
                {name="zombieb",price=45000},
            },
            	
        }
    },
},VehShop)

function VehShop:CreateShops()
    for i = 1 , #self , 1 do
        v = self[i]
        local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite (blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip,  v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Blips.name)
        EndTextCommandSetBlipName(blip)
        Blips:AddBlip(blip,"Concessionnaire",v.Blips)
        Zone:Add(v.Pos,self.EnterZone,self.ExitZone,i,2.5)
        RMenu.Add('VehShop', i, RageUI.CreateMenu(nil, "Catégories disponibles",10,20,v.Menus.Sprite,v.Menus.Sprite))
        Marker:Add(v.Pos,v.Marker)

        for k,v in pairs(v.Vehicles) do
            RMenu.Add('VehShop_sub', k, RageUI.CreateSubMenu(RMenu:Get('VehShop', i),nil, k))
            RMenu.Add('VehShop_sub', "playerList", RageUI.CreateSubMenu(RMenu:Get('VehShop', i),nil, "Listes des joueurs"))
        end
    end
end

local CurrentZone = nil

function VehShop.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",VehShop.Open,"VehShop")
    KeySettings:Add("controller",46,VehShop.Open,"VehShop")
    CurrentZone = zone
end


function VehShop.ExitZone(zone)
    if CurrentZone ~= nil then
    Hint:RemoveAll()
    KeySettings:Clear("keyboard","E","VehShop")
    KeySettings:Clear("controller","E","VehShop")
    Marker:Visible(VehShop[CurrentZone].Pos,true)
    VehShop.Close()
    CurrentZone  = nil
    end
end

function VehShop.Open()
    RageUI.Visible(RMenu:Get('VehShop', CurrentZone),true)
    Marker:Visible(VehShop[CurrentZone].Pos,false)
end

function VehShop.Close()
    if RageUI.Visible(RMenu:Get('VehShop', CurrentZone)) then
    RageUI.Visible(RMenu:Get('VehShop', CurrentZone),false)
    end
end
VehShop:CreateShops()
local currentHeader = true
local currentveh = 0
local function DrawVehicle(vehicleName)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    if veh ~= nil then
        DeleteEntity(veh)
    end
    vehicleFct.SpawnLocalVehicle(vehicleName, VehShop[CurrentZone].Pos, VehShop[CurrentZone].Pos.h, function(veh)						
        SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
        FreezeEntityPosition(veh,true)
        SetVehicleDoorsLocked(veh,4)
        currentveh = veh
    end)
    SetEntityVisible(GetPlayerPed(-1), false)
    t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos,8.0)

    for i = 1,#t,1 do
        DeleteEntity(t[i])
    end
    RMenu:Get('VehShop',CurrentZone).Closed = function()
        SetEntityVisible(GetPlayerPed(-1), true)
        local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
        if veh ~= nil then
            DeleteEntity(veh)
        end
        t = vehicleFct.GetVehiclesInArea(VehShop[CurrentZone].Pos,8.0)
        Marker:Visible(VehShop[CurrentZone].Pos,true)
        for i = 1,#t,1 do
            DeleteEntity(t[i])
        end
    end
end
local CurrentVehicle = nil
local menu = nil
local currentInd = {}
Citizen.CreateThread(function()
    while true do 
        Wait(1)
        if CurrentZone ~= nil then
            if RageUI.Visible(RMenu:Get('VehShop',CurrentZone)) then
                RageUI.DrawContent({ header = true, glare = false}, function()
                    for k,v in pairs(VehShop[CurrentZone].Vehicles) do
                        RageUI.Button(k,nil,{},true,function(_,_,Selected)
                            if Selected then
                                CurrentVehicle = v[1].name
                                DrawVehicle(v[1].name)
                            end
                        end,RMenu:Get('VehShop_sub',k))
                    end
                end, function()
                end)
            else
                if RageUI.Visible(RMenu:Get('VehShop_sub',"playerList")) then
                    RageUI.DrawContent({ header = true, glare = false}, function()
                        for k ,v in pairs(LocalPlayer().ActivePlayer) do
                            local i = v
                            RageUI.Button(GetPlayerName(i),nil,{},true,function(_,Active,Selected)
                                if Selected then
                                    
                                    local veh = vehicleFct.GetVehicleProperties(currentveh)
                                    TriggerServerCallback('vehicleshop:BuyVehicle', function(bool)
                                        if bool then
                                            vehicleFct.SpawnVehicle(veh.model, VehShop[CurrentZone].SpawnPos, VehShop[CurrentZone].SpawnPos.h, function(_veh)						
                                                --SetPedIntoVehicle(GetPlayerPed(-1),veh,-1)
                                                --FreezeEntityPosition(veh,true)
                                                --SetVehicleDoorsLocked(veh,4)
                                                vehicleFct.SetVehicleProperties(_veh,veh)
                                                currentveh = veh
                                            end)
                                        end
                                    end,currentInd.price,GetPlayerServerId(i),veh)
                                end
                            end)
                        end
                        
                    end, function()
                    end)
                end
                for k,v in pairs(VehShop[CurrentZone].Vehicles) do
                    if RageUI.Visible(RMenu:Get('VehShop_sub',k)) then
                        RageUI.DrawContent({ header = true, glare = false}, function()
                            for i = 1 , #v,1 do
                                RageUI.Button(GetLabelText(GetDisplayNameFromVehicleModel(v[i].name)),nil,{RightLabel=v[i].price .. "$"},true,function(_,Active,Selected)

                                    if isAnyJob("police") then
                                        menu = RMenu:Get('VehShop_sub',"playerList")
                                    else
                                        menu = nil
                                    end
                                    if Active then
                                        if CurrentVehicle ~= v[i].name then
                                            RequestModel(v[i].name)

                                            while not HasModelLoaded(v[i].name) do
                                                Citizen.Wait(0)
                                            end
                                            CurrentVehicle = v[i].name
                                            DrawVehicle(CurrentVehicle)
                                        end
                                    end

                                    if Selected then
                                        if isAnyJob("police") then
                                            menu = RMenu:Get('VehShop_sub',"playerList")
                                            currentInd = v[i]
                                        else
                                            menu = nil
                                            RageUI.Popup({message="Contactez un ~b~concessionnaire"})
                                        end
                                    end
                                end,menu)
                            end
                        end, function()
                        end)
                    end
                end
            end
        end
    end
end)