Storage = setmetatable({}, Storage)
Storage.__index = Storage
Storage.__call = function()
    return "Storage"
end
local storage = {}

local currentStorage = {}
function Storage.New(name, maxWeight)
    local newStorage = {}
    TriggerServerCallback('rage-reborn:GetStorageItems', function(Items, Accounts)
        newStorage = {
            name = name,
            maxWeight = maxWeight,
            items = FormatStorage(Items),
            money = Accounts,
            Weight = 0
        }
    end, name)
    while newStorage.name == nil do
        print("waiting for store")
        Wait(50)
    end
    return setmetatable(newStorage, Storage)
end


function Storage:LinkToPos(Pos)

    Marker:Add(Pos,{
        type = 23,
        scale = {x=1.5,y=1.5,z=0.2},
        color = {r=255,g=255,b=255,a=120},
        Up = false,
        Cam = false,
        Rotate = false,
        visible = true
    })
    Zone:Add(Pos,
    function(storage)
        Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
        KeySettings:Add("keyboard","E",
        function() 
            currentStorage = storage
            storage:RefreshDB() -- refresh data with bdd
            storage:RefreshWeight()
            storage:Visible(true)
        end,self.name)
        KeySettings:Add("controller",46,
        function() 
            currentStorage = storage
            storage:RefreshDB() -- refresh data with bdd
            storage:RefreshWeight()
            storage:Visible(true)
        end,self.name)
    end,
    function()  
        KeySettings:Clear("keyboard","E",self.name)
        KeySettings:Clear("controller","E",self.name)
        Hint:RemoveAll()
    end,self,1.5)
end
function Storage:Visible(bool)
    currentStorage = self
    RageUI.Visible(RMenu:Get('storage', 'main'), bool)
    RMenu:Get('storage', 'main').Index = 1
end
function FormatStorage(items)
    local _Items = {}
    for i = 1, #items, 1 do
        local p = items[i]
        if _Items[p.itemName] == nil then
            _Items[p.itemName] = {}
        end
        local data = p.metadata ~= nil and json.decode(p.metadata) or nil
        local label = data ~= nil and data.label or nil
        table.insert(_Items[p.itemName], { name = p.itemName, data = data, label = label, id = p.id })
    end
    return _Items
end
function Storage:AddItem(item)
    if self.items[item.name] == nil then
        self.items[item.name] = {}
    end
    local label = item.metadata ~= nil and item.metadata.label or nil
    table.insert(self.items[item.name], { name = item.name, data = item.metadata, label = label })
end
function Storage:RefreshWeight()
    local Weight = 0
    for k, v in pairs(self.items) do
        if v[1] ~= nil then
            p = self.items[k]
            Weight = Weight + (Items[v[1].name].weight * #v)
        end
    end
    self.Weight = Weight
    RMenu:Get('storage', 'main'):SetPageCounter(round(self.Weight, 2) .. "/" .. self.maxWeight .. "KG")
end

function Storage:RefreshDB()
    TriggerServerCallback('rage-reborn:GetStorageItems', function(Items, Accounts)
        self.items = FormatStorage(Items)
        self.money = Accounts
    end, self.name)
end
function Storage:RemoveItem(name, id)
    RMenu:Get('storage', 'main').Index = RMenu:Get('storage', 'main').Index - 1
    self:RefreshWeight()
    for k, v in pairs(self.items) do
        if k == name then
            for i = 1, #v, 1 do
                if v[i].id == id then
                    table.remove(self.items[name], i)
                    TriggerServerEvent("rage-reborn:RemoveItemFromStorage", id)
                    break
                end
            end
        end
    end
end

function Storage:CanAcceptItem(item, count)
    local tempWeight = self.Weight
    tempWeight = tempWeight + (Items[item].weight * count)
    return tempWeight <= 32
end


-------------
-- coffre --
-------------

local vehCoffres = {
    ["barracks"] = 215,
    -- helico
    ["frogger"] = 85,
    ["buzzard2"] = 70,
    ["maverick"] = 70,
    ["maverick2"] = 70,
    ["cargobob"] = 100,
    ["svolito"] = 65,
    ["svolito2"] = 65,
    ["swift"] = 65,
    ["swift2"] = 65,
    ["volatus"] = 65,
    -- vélo
    ["bmx"] = 5,
    ["cruiser"] = 5,
    ["tribike2"] = 5,
    ["scorcher"] = 5,
    ["fixter"] = 5,
    ["tribike3"] = 5,
    ["tribike"] = 5,
    -- plane
    ["luxor"] = 325,
    ["luxor2"] = 325,
    ["nimbus"] = 325,
    ["vestra"] = 275,
    ["mammatus"] = 200,
    ["velum"] = 175,
    ["dodo"] = 145,
    ["cuban800"] = 145,
    ["duster"] = 145,
    -- bateau
    ["marquis"] = 175,
    ["toro"] = 155,
    ["speeder"] = 120,
    ["toro2"] = 110,
    ["jetmax"] = 110,
    ["squalo"] = 100,
    ["suntrap"] = 100,
    ["tropic"] = 100,
    ["seashark"] = 40,
    ["dinghy"] = 80,
    -- motos : tout terrain
    ["enduro"] = 12,
    ["manchez"] = 12,
    ["sanchez01"] = 12,
    ["esskey"] = 12,
    ["ruffian"] = 12,
    ["cliffhanger"] = 12,
    -- sportives
    ["akuma"] = 12,
    ["double"] = 12,
    ["bf400"] = 12,
    ["carbon"] = 12,
    ["bati"] = 12,
    ["faggion"] = 12,
    ["faggio"] = 12,
    ["faggio2"] = 12,
    ["faggio3"] = 12,
    ["vortex"] = 12,
    ["lectro"] = 12,
    ["nemesis"] = 12,
    ["defiler"] = 12,
    ["hakuchou"] = 12,
    ["hakuchou2"] = 12,
    ["pcj"] = 12,
    ["vader"] = 12,
    -- cruisers
    ["vindicator"] = 12,
    ["avarus"] = 12,
    ["hexer"] = 12,
    ["innovation"] = 12,
    ["sanctus"] = 12,
    ["chimera"] = 12,
    ["bagger"] = 12,
    ["daemon2"] = 12,
    ["gargoyle"] = 12,
    ["nightblade"] = 12,
    ["ratbike"] = 12,
    ["sanchez2"] = 12,
    ["sovereign"] = 12,
    ["wolfsbane"] = 12,
    ["thrust"] = 12,
    ["zombiea"] = 12,
    ["zombieb"] = 12,
    ["oppressor"] = 12,
    ["diablous"] = 12,
    ["diablous2"] = 12,
    ["daemon"] = 12,
    -- voiture/compacts
    ["brioso"] = 35,
    ["dilettan"] = 40,
    ["issi2"] = 35,
    ["panto"] = 35,
    ["prairie"] = 35,
    ["rhapsody"] = 35,
    ["emperor"] = 60,
    ["emperor2"] = 60,
    ["manana"] = 60,
    ["peyote"] = 60,
    ["phoenix"] = 55,
    ["tornado"] = 60,
    ["tornado2"] = 60,
    ["tornado3"] = 60,
    ["tornado4"] = 60,
    ["tornado5"] = 60,
    ["voodoo2"] = 60,
    ["virgo3"] = 55,
    -- coupes
    ["cogcabri"] = 65,
    ["exemplar"] = 55,
    ["f620"] = 55,
    ["felon"] = 65,
    ["felon2"] = 65,
    ["jackal"] = 55,
    ["oracle"] = 60,
    ["oracle2"] = 60,
    ["sentinel"] = 55,
    ["sentinel2"] = 55,
    ["windsor"] = 60,
    ["windsor2"] = 60,
    ["zion"] = 60,
    ["zion2"] = 60,
    ["dubsta"] = 75,
    ["dubsta2"] = 75,
    ["fq2"] = 65,
    ["khamel"] = 60,
    ["taxi"] = 55,
    ["schafter"] = 60,
    ["schafter2"] = 60,
    ["schwarze"] = 60,
    -- sports
    ["ninef"] = 50,
    ["ninef2"] = 50,
    ["alpha"] = 60,
    ["banshee"] = 55,
    ["bestiagts"] = 65,
    ["blista"] = 35,
    ["buffalo"] = 60,
    ["buffalo02"] = 60,
    ["carboniz"] = 55,
    ["comet2"] = 55,
    ["coquette"] = 55,
    ["tampa"] = 55,
    ["tampa2"] = 55,
    ["feltzer"] = 55,
    ["furore"] = 55,
    ["fusilade"] = 45,
    ["jester"] = 55,
    ["jester2"] = 55,
    ["kuruma"] = 60,
    ["kuruma2"] = 60,
    ["lynx"] = 55,
    ["massacro"] = 55,
    ["massacro2"] = 55,
    ["omnis"] = 50,
    ["penumbra"] = 50,
    ["rapidgt"] = 55,
    ["rapidgt2"] = 55,
    ["rapidgt3"] = 55,
    ["schafter3"] = 60,
    ["sultan"] = 55,
    ["surano"] = 60,
    ["tropos"] = 50,
    ["verlier"] = 55,
    ["elegy2"] = 60,
    ["futo"] = 55,
    ["ruiner"] = 55,
    ["blista2"] = 55,
    ["seven70"] = 55,
    ["pfister811"] = 55,
    -- lowriders
    ["faction2"] = 60,
    ["faction3"] = 60,
    ["moonbeam2"] = 80,
    ["moonbeam"] = 80,
    ["primo2"] = 60,
    ["chino2"] = 60,
    ["buccaneer2"] = 60,
    ["voodoo"] = 60,
    ["minivan2"] = 70,
    ["sabregt2"] = 60,
    ["slamvan3"] = 80,
    ["tornado5"] = 60,
    ["virgo2"] = 60,
    -- sports classics
    ["casco"] = 60,
    ["coquette2"] = 55,
    ["jb700"] = 55,
    ["pigalle"] = 60,
    ["stinger"] = 55,
    ["stingerg"] = 60,
    ["feltzer3"] = 55,
    ["ztype"] = 55,
    ["monroe"] = 55,
    ["roosevelt"] = 55,
    ["btype"] = 55,
    ["mamba"] = 55,
    -- super
    ["adder"] = 55,
    ["banshee2"] = 55,
    ["bullet"] = 45,
    ["cheetah"] = 45,
    ["entityxf"] = 45,
    ["sheava"] = 45,
    ["fmj"] = 45,
    ["infernus"] = 45,
    ["osiris"] = 45,
    ["le7b"] = 40,
    ["reaper"] = 50,
    ["sultanrs"] = 50,
    ["t20"] = 45,
    ["turismor"] = 45,
    ["tyrus"] = 40,
    ["vacca"] = 45,
    ["voltic"] = 45,
    ["prototipo"] = 40,
    ["zentorno"] = 45,
    -- muscle
    ["blade"] = 60,
    ["buccanee"] = 60,
    ["buccanee2"] = 60,
    ["chino"] = 60,
    ["coquette3"] = 55,
    ["dominato"] = 60,
    ["dukes"] = 60,
    ["gauntlet"] = 60,
    ["hotknife"] = 45,
    ["faction"] = 60,
    ["niteshad"] = 55,
    ["picador"] = 70,
    ["sabregt"] = 60,
    ["tampa"] = 55,
    ["virgo"] = 60,
    ["vigero"] = 60,
    ["stalion"] = 50,
    -- off-road
    ["bifta"] = 45,
    ["blazer"] = 30,
    ["blazer2"] = 30,
    ["blazer3"] = 30,
    ["blazer4"] = 30,
    ["brawler"] = 45,
    ["dubsta3"] = 90,
    ["dune"] = 30,
    ["rebel01"] = 85,
    ["rebel02"] = 85,
    ["rebel"] = 85,
    ["rebel2"] = 85,
    ["sandking"] = 85,
    ["monster"] = 75,
    ["trophy"] = 45,
    ["bfinject"] = 45,
    ["rancherx"] = 80,
    ["kalahari"] = 65,
    ["rloader2"] = 70,
    -- suvs
    ["baller"] = 60,
    ["baller2"] = 60,
    ["cavcade"] = 80,
    ["cavalcade2"] = 70,
    ["granger"] = 95,
    ["huntley"] = 75,
    ["landstal"] = 80,
    ["radi"] = 70,
    ["rocoto"] = 75,
    ["seminole"] = 80,
    ["xls"] = 80,
    ["bjxl"] = 75,
    ["gresley"] = 80,
    ["habanero"] = 70,
    ["mesa"] = 75,
    ["patriot"] = 70,
    ["sadler"] = 85,
    ["serrano"] = 70,
    ["contender"] = 95,
    -- vans
    ["bison"] = 90,
    ["bison2"] = 90,
    ["bison3"] = 90,
    ["bobcatxl"] = 90,
    ["gburrito"] = 95,
    ["gburrito2"] = 95,
    ["minivan"] = 70,
    ["paradise"] = 95,
    --["rumpo"] = 13000,
    ["surfer"] = 95,
    ["youga"] = 95,
    ["youga2"] = 95,
    ["slamvan"] = 80,
    ["slamvan2"] = 80,
    -- sedans
    ["asea"] = 55,
    ["astrope"] = 55,
    ["fugitive"] = 60,
    ["glendale"] = 55,
    ["ingot"] = 65,
    ["intruder"] = 60,
    ["premier"] = 55,
    ["primo"] = 60,
    ["regina"] = 65,
    ["stanier"] = 60,
    ["stratum"] = 65,
    ["stretch"] = 60,
    ["superd"] = 60,
    ["surge"] = 55,
    ["tailgate"] = 60,
    ["warrener"] = 55,
    ["washingt"] = 60,
    -- job
    ["rubble"] = 85,
    ["tug"] = 200,
    ["mule"] = 75,
    ["boxville5"] = 65,
    ["boxville4"] = 65,
    ["boxville3"] = 65,
    ["boxville2"] = 65,
    ["boxville"] = 65,
    ["stockade"] = 95,
    ["pbus"] = 65,
    ["tractor2"] = 35,
    ["graintraile"] = 80,
    ["hauler"] = 35,
    ["trailer"] = 100,
    ["trailers2"] = 100,
    ["trailers3"] = 100,
    ["towtruck"] = 40,
    ["flatbed"] = 45,
    ["flatbed2"] = 45,
    ["flatbed3"] = 45,
    ["trailerlogs"] = 100,
    ["ambulance"] = 80,
    ["polmav"] = 70,
    ["trash"] = 75,
    ["fbi"] = 50,
    ["fbi2"] = 85,
    ["im1"] = 70,
    ["im2"] = 70,
    ["im3"] = 70,
    ["im4"] = 70,
    ["im5"] = 70,
    ["baller3"] = 60,
    ["baller4"] = 60,
    ["baller5"] = 60,
    ["baller6"] = 60,
    ["limo"] = 80,
    ["limo2"] = 65,
    ["schafter5"] = 55,
    ["schafter6"] = 60,
    ["frogger2"] = 65,
    ["rumpo"] = 80,
    ["rumpo2"] = 80,
    ["rumpo3"] = 80,
    ["speedo"] = 75,
    ["speedo2"] = 75,
    ["speedo3"] = 75,
    ["police"] = 55,
    ["police2"] = 55,
    ["police3"] = 70,
    ["policeold1"] = 70,
    ["police4"] = 55,
    ["policeb"] = 20,
    ["policet"] = 125,
    ["riot"] = 96,
    ["sheriff"] = 60,
    ["sheriff2"] = 90,
    ["predator"] = 80,
    ["annihilator"] = 75,
    ["cog55"] = 55,
    ["cog552"] = 50,
    ["cognoscenti"] = 62,
    ["xls2"] = 80,
    ["cognoscenti2"] = 57,
    -- trucks
    ["camper"] = 100,
    ["benson"] = 110,
    ["mule2"] = 110,
    ["pounder"] = 120,
    ["brickade"] = 95,
    ["journey"] = 100,
    --new
    ["elegy"] = 60,
    ["tempesta"] = 45,
    ["tempesta2"] = 45,
    ["italigtb"] = 45,
    ["italigtb2"] = 45,
    ["nero"] = 45,
    ["nero2"] = 45,
    ["specter"] = 55,
    ["dune2"] = 30,
    ["dune3"] = 30,
    ["dune4"] = 30,
    ["dune5"] = 30,
    ["phantom"] = 25,
    ["phantom2"] = 25,
    ["voltic2"] = 45,
    ["penetrator"] = 45,
    ["boxville5"] = 80,
    ["technical"] = 60,
    ["technical2"] = 60,
    ["technical3"] = 60,
    ["fcr"] = 25,
    ["fcr2"] = 25,
    ["comet3"] = 45,
    ["ruiner3"] = 50,
    ["gp1"] = 45,
    ["ruston"] = 45,
    ["turismo2"] = 45,
    ["ninef"] = 55,
    ["ninef2"] = 55,
    ["xa21"] = 45,
    ["caddy3"] = 35,
    ["vagner"] = 45,
    ["phantom3"] = 25,
    ["cheetah2"] = 45,
    ["torero"] = 45,
    ["insurgent"] = 65,
    ["insurgent2"] = 65,
    ["insurgent3"] = 65,
    ["apc"] = 80,
    ["tampa3"] = 45,
    ["halftrack"] = 65,
    ["ardent"] = 55,
    ["trailers4"] = 90,
    ["trailerlarge"] = 95,
    ["trailersmall2"] = 75,
    ["romero"] = 90,
    ["taco"] = 75,
    ["pony"] = 75,
    ["pony2"] = 75,
    ["pony3"] = 75,
    -- smuggler
    ["alphaz1"] = 130,
    ["seabreeze"] = 150,
    ["microlight"] = 20,
    ["rogue"] = 40,
    ["howard"] = 30,
    ["retinue"] = 45,
    ["cyclone"] = 40,
    ["visione"] = 40,
    ["z190"] = 55,
    ["viseris"] = 60,
    ["comet5"] = 50,
    ["raiden"] = 50,
    ["riata"] = 80,
    ["sc1"] = 45,
    ["autarch"] = 45,
    ["savestra"] = 50,
    ["gt500"] = 55,
    ["comet4"] = 45,
    ["neon"] = 45,
    ["sentinel3"] = 50,
    ["riot2"] = 100,
    ["yosemite"] = 85,
    ["hustler"] = 60,
    ["streiter"] = 70,
    ["revolter"] = 65,
    ["pariah"] = 40,
    ["kamacho"] = 80,
    ["hermes"] = 50,
    ["titan"] = 200,
    ["bodhi2"] = 68,
    ["armytrailer"] = 100,
    ["docktrailer"] = 100,
    -- forget
    ["packer"] = 35,
    ["tractor2"] = 25,
    ["tractor"] = 15,
    ["towtruck"] = 35,
    ["towtruck2"] = 35,
    ["utillitruck"] = 68,
    ["utillitruck2"] = 68,
    ["utillitruck3"] = 68,
    ["utillitruck3"] = 68,
    ["utiltruc"] = 65,
    ["tiptruck"] = 55,
    ["tiptruck2"] = 55,
    ["biff"] = 60,
    ["mixer"] = 60,
    ["mixer2"] = 60,
    ["scrap"] = 55,
    -- bsco
    ["dps1"] = 60,
    ["dps3"] = 60,
    ["ambulan"] = 60,
    ["caddy"] = 35,
    ["caddy2"] = 35,
    ["stalion2"] = 50,
    ["ratloader"] = 65,
    ["rloader"] = 65,
    ["gmcs"] = 65,
    -- new
    ["dloader"] = 60,
    ["issi3"] = 40,
    ["sierra 1500"] = 60,
    ["taipan"] = 40,
    ["gb200"] = 45,
    ["tezeract"] = 40,
    ["tyrant"] = 40,
    ["dominato2"] = 50,
    ["dominator2"] = 50,
    ["dominator3"] = 50,
    ["flashgt"] = 40,
    ["jester3"] = 55,
    ["fagaloa"] = 55,
    ["ellie"] = 55,
    ["michelli"] = 45,
    ["hotring"] = 45,
    ["cheburek"] = 55,
    ["entity2"] = 40,
    ["cognosc"] = 40,
    ["blista3"] = 50,

    ["policebc1"] = 15,
    ["policebc2"] = 70,
    ["policebc3"] = 60,
    ["policebc5"] = 55,
    ["policels1"] = 55,
    ["policels2"] = 55,
    ["policels3"] = 55,
    ["policek9"] = 60,

    ["emscharg"] = 60,
    ["suvems"] = 50,

    ["unmarkbuff"] = 55,
    ["unmarkora"] = 55,
    ["unmarksult"] = 55,
    ["mower"] = 15,
    ["guardian"] = 80,
    ["pranger"] = 65,
    -- afterhour
    ["stafford"] = 60,
    ["scramjet"] = 60,
    ["strikeforce"] = 60,
    ["terbyte"] = 60,
    ["pbus2"] = 60,
    ["oppressor2"] = 15,
    ["pounder2"] = 80,
    ["speedo4"] = 60,
    ["freecrawler"] = 60,
    ["mule4"] = 70,
    ["menacer"] = 60,
    ["blimp3"] = 40,
    ["swinger"] = 50,
    ["patriot2"] = 70,

    ["lguard"] = 70,
    ["trophytruck2"] = 45,
    ["toros"] = 80,
    ["schlagen"] = 60,
    ["italigto"] = 45,
    ["schafter4"] = 60,
    ["tulip"] = 60,
    ["vamos"] = 60,
    ["deviant"] = 60,
    ["deveste"] = 30,
    ["deluxo"] = 20,
    ["infernus2"] = 40,
    ["clique"] = 60,
    ["speedo2"] = 75,
    ["sanchez2"] = 12,
    ["dinghy2"] = 80,
    ["velum2"] = 175,
    ["stunt"] = 80,
    ["shamal"] = 300,
    ["btype2"] = 55,
    ["btype3"] = 55,
    ["sanchezbcso"] = 12,
    ["speedobcso"] = 75,
    ["specter2"] = 55,
    ["gauntlet2"] = 60,

    ["burrito"] = 80,
    ["surfer2"] = 80,
    ["deathbike"] = 12,
    ["imperator"] = 60,
    ["cavalcade"] = 80,
    ["romero"] = 70,
    --
    ["issi4"] = 40,
    ["issi5"] = 40,
    ["brutus"] = 80,
    ["stromberg"] = 35,
    ["sandking2"] = 85,
}

local inCoffre = nil
local function OpenCoffre()

    local Player = {}
    Player.Ped = GetPlayerPed(-1)
    local veh = GetVehicleInDirection(8.0)
   
    if veh == 0 or DoesEntityExist(veh) == 0 then
        return
    end
    if VehToNet(veh) ~= 0 and getVehicleHealth(veh) > 10 then
        
        if IsPedNearTrunk(Player, veh) then
            print("near trunk")
            local model = GetEntityModel(veh)
            if IsVehicleDoorDamaged(veh, 5) or GetVehicleDoorAngleRatio(veh, 5) < 0.1 or IsThisModelAPlane(model) then
                print("veh ok")
                local result = string.lower(GetDisplayNameFromVehicleModel(model))
                currentStorage = Storage.New(model .. "|" .. GetVehicleNumberPlateText(veh), math.floor(vehCoffres[result])) -- storageName is the bdd name

                while currentStorage == nil do
                    Wait(1)
                    print("waiting for storage")
                end
                if vehCoffres[result] == nil then
                    ShowAboveRadarMessage("Le coffre n'est pas enregistré\nMP un développeur avec le model du véhicule")
                else
                    print("veh visible")
                    currentStorage:Visible(true)
                    currentStorage:RefreshDB() -- refresh data with bdd
                    currentStorage:RefreshWeight()
                    SetVehicleDoorOpen(veh, 5)
                    inCoffre = veh
                end
            else
                if currentStorage.name ~= nil then
                    currentStorage:Visible(false)
                    currentStorage = {}
                end
                inCoffre = nil
                SetVehicleDoorShut(veh, 5)
            end
        else
            ShowAboveRadarMessage("~r~Vous devez regarder le coffre de votre véhicule.")
        end
    end
end
function PrintTable(t, indent, done)
    -- done = done or {}
    -- indent = indent or 0
    -- local keys = table.GetKeys(t)
    -- table.sort(keys, function(a, b)
    --     if (type(a) == "number" and type(b) == "number") then
    --         return a < b
    --     end
    --     return tostring(a) < tostring(b)
    -- end)
    -- done[t] = true
    -- for i = 1, #keys do
    --     local key = keys[i]
    --     local value = t[key]
    --     Citizen.Trace("^4" .. string.rep("\t", indent) .. "^0")
    --     if (type(value) == "table" and not done[value]) then
    --         done[value] = true
    --         Citizen.Trace(tostring(key) .. ":" .. "\n")
    --         PrintTable(value, indent + 2, done)
    --         done[value] = nil
    --     else
    --         Citizen.Trace("^4" .. tostring(key) .. "\t=\t" .. tostring(value) .. "\n^0")
    --     end
    -- end
end

function table.hasValue(tbl, value, k)
    if not tbl or not value or type(tbl) ~= "table" then
        return
    end
    for _, v in pairs(tbl) do
        if k and v[k] == value or v == value then
            return true, _
        end
    end
end

function table.removeByValue(tbl, val, i)
    local ntbl = {}
    for k, v in pairs(tbl) do
        if v ~= val and (not i or v[i] ~= val) then
            table.insert(ntbl, v)
        end
    end
    return ntbl
end

function table.count(table, checkCount)
    if not table or type(table) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(table) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if inCoffre ~= nil then
            local Ply = SelfPlayer
            local Pos = GetEntityCoords(GetPlayerPed(-1))
            local vehPos = GetEntityCoords(inCoffre)
            local x, y, z = table.unpack(vehPos)
            local x1,y1,z1 = table.unpack(Pos)
            if GetDistanceBetween3DCoords(x1,y1,z1, x, y, z) > 5 then
                inCoffre = nil
                currentStorage:Visible(false)
                currentStorage = {}
            end
        end
    end
end)

KeySettings:Add("keyboard", "G", OpenCoffre, "coffre_veh")


RMenu.Add('storage', 'main', RageUI.CreateMenu("Coffre", "~b~Objets disponibles"))

RMenu.Add('storage', 'my_inv', RageUI.CreateSubMenu(RMenu:Get('storage', 'main'), "Inventaire", "~b~Objets disponibles"))
RMenu.Add('storage', 'my_inv', RageUI.CreateSubMenu(RMenu:Get('storage', 'main'), "Inventaire", "~b~Objets disponibles"))
RMenu.Add('storage', 'multi_inventory', RageUI.CreateSubMenu(RMenu:Get('storage', 'main'), "Inventaire", "~b~Actions disponibles"))
RMenu.Add('storage', 'dep_retirer', RageUI.CreateSubMenu(RMenu:Get('storage', 'main'), "Argent", "~b~Actions disponibles"))
RMenu:Get('storage', 'my_inv').Closed = function()
    RMenu:Get('storage', 'main').Index = 1
end
RMenu:Get('storage', 'multi_inventory').Closed = function()
    RMenu:Get('storage', 'main').Index = 1
end

currentStorage = {}
function ShowAboveRadarMessage(message, back)
    if back then
        SetNotificationBackgroundColor(back)
    end
    SetNotificationTextEntry("jamyfafi")
    AddTextComponentString(message)
    if string.len(message) > 99 and AddLongString then
        AddLongString(message)
    end
    return DrawNotification(0, 1)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if currentStorage ~= nil then
            local self = currentStorage
            if RageUI.Visible(RMenu:Get('storage', 'dep_retirer')) then
                RageUI.DrawContent({ header = true, glare = false }, function()

                    RageUI.Button("Déposer", nil, {}, true, function(_, _, S)
                        if S then
                            count = KeyboardInput("~b~Combien ?", nil, 25)
                            count = tonumber(count)
                            canBuy = Money:CanBuy(count)
                            if self.money[self.money.index]  + count <= 25000 then
                                if canBuy then
                                    
                                    TriggerServerEvent("stockage:AddMoneyToAccount",self.name,count,self.money.index)
                                    self.money[self.money.index] = self.money[self.money.index]  + count
                                else
                                    RageUI.Popup({message="~r~Vous n'avez pas assez d'argent sur vous"})
                                    
                                end
                            else
                                ShowNotification("~r~Plus assez de place pour de l'argent")
                            end
                        end
                    end,RMenu:Get('stockage', 'main'))
                    RageUI.Button("Retirer", nil, {}, true, function(_, _, S)
                        if S then
                            count = KeyboardInput("~b~Combien ?", nil, 25)
                            count = tonumber(count)
                            if count ~= nil and count <= self.money[self.money.index] then
                                if self.money.index == "money" then
                                    TriggerServerEvent("money:Add",count)
                                else
                                    TriggerServerEvent("black_money:Add",count)
                                end
                                
                                TriggerServerEvent("stockage:RemoveFromAccount",self.stockagename,count,self.money.index)
                                self.money[self.money.index] = self.money[self.money.index] - count
                            else
                                RageUI.Popup({message="~r~Pas assez d'argent dans le coffre"})
                            end
                        end
                    end,RMenu:Get('stockage', 'main'))
    
                end, function()
                
                end)

            end
            if RageUI.Visible(RMenu:Get('storage', 'main')) then

                RageUI.DrawContent({ header = true, glare = true }, function()
                    RageUI.Button("Déposer un objet", nil, {}, true, function(_, _, Select)
                    end, RMenu:Get('storage', 'my_inv'))
                    RageUI.CenterButton("~b~↓↓↓ ~s~Argent ~b~↓↓↓", nil, {}, true, function(_, _, _)
                    end)
                    RageUI.Button("Argent", nil, { RightLabel = self.money.money .. "$" }, true, function(_, _, S)
                        if S then
                            self.money.index = "money"
                        end
                    end, RMenu:Get('storage', 'dep_retirer'))
                    RageUI.Button("Argent ~r~sale", nil, { RightLabel = self.money.dark_money .. "$" }, true, function(_, _, S)
                        if S then
                            self.money.index = "dark_money"
                        end
                    end, RMenu:Get('storage', 'dep_retirer'))
                    RageUI.CenterButton("~b~↓↓↓ ~s~Objets ~b~↓↓↓", nil, {}, true, function(_, _, _)
                    end)

                    if table.count(self.items) == 0 then
                        RageUI.Button("Vide", nil, {}, true, function(_, _, _)

                        end)
                    end

                    for k, v in pairs(self.items) do

                        if #v == 1 then
                            RageUI.Button(v[1].label ~= nil and Items[k].label .. " '" .. v[#v].label .. "'" or Items[k].label, nil, { RightLabel = 1 }, true, function(_, Active, Selected)
                                if Selected then
                                    if Inventory.canReceive(k, 1) then
                                        Inventory.SelectedItem = {name=k,label=v[#v].label,data=v[#v].data,id=v[#v].id}

                                        TriggerServerEvent("inventory:AddItem", Inventory.SelectedItem)
                                        self:RemoveItem(k, v[1].id, v[#v].data)
                                    end
                                end
                            end)
                        elseif #v > 0 then
                            RageUI.Button(Items[k].label, nil, { RightLabel = #v .. "→" }, true, function(_, _, Selected)
                                if Selected then
                                    self.Selected = v
                                end
                            end, RMenu:Get('storage', 'multi_inventory'))
                        end
                    end
                end, function()
                end)

            end

            if RageUI.Visible(RMenu:Get('storage', 'multi_inventory')) then
                RageUI.DrawContent({ header = true, glare = false }, function()
                    for i = 1, #self.Selected, 1 do
                        if self.Selected[i] ~= nil then
                            RageUI.Button(self.Selected[i].label ~= nil and Items[self.Selected[i].name].label .. " '" .. self.Selected[i].label .. "'" or Items[self.Selected[i].name].label, nil, { RightLabel = 1 }, true, function(_, _, Selected)
                                if Selected then
                                    count = KeyboardInput("~b~Combien ?", nil, 25)
                                    count = tonumber(count)
                                    local v = self.Selected
                                    if count ~= nil and count <= #self.Selected and Inventory.canReceive(v[i].name, count) then
                                        if count == #v then
                                            RageUI.GoBack()

                                        end
                                        if count == 1 then
                                            self:RemoveItem(v[1].name, v[1].id, v[1].data)
                                            local itemTable = { name = v[1].name, id = v[1].id, data = v[1].data }

                                            TriggerServerEvent("inventory:AddItem", itemTable)
                                        else
                                            for i = 1, count, 1 do
                                                local v = self.Selected
                                                local tableCount = #v
                                                local itemTable = { name = v[tableCount].name, id = v[tableCount].id, data = v[tableCount].data }
                                                TriggerServerEvent("inventory:AddItem", itemTable)
                                                self:RemoveItem(v[tableCount].name, v[tableCount].id, v[tableCount].data)
                                            end
                                        end
                                    end
                                end
                            end, RMenu:Get('storage', 'main'))
                        end
                    end
                end, function()
                end)
            end

            if RageUI.Visible(RMenu:Get('storage', 'my_inv')) then
                RageUI.DrawContent({ header = true, glare = false }, function()
                    local inventory = Inventory.Inventory
                    if table.count(inventory) == 0 then
                        RageUI.Button("Vide", nil, {}, true, function(_, _, _)
                        end)
                    else
                        for k, v in pairs(inventory) do
                            if #v > 0 then
                                RageUI.Button(Items[k].label, nil, { RightLabel = #v }, true, function(_, _, Selected)
                                    if Selected then
                                        count = KeyboardInput("~b~Combien ?", nil, 25)
                                        count = tonumber(count)
                                        if count ~= nil and count <= #v then
                                            RageUI.GoBack()
                                            if not self:CanAcceptItem(k, count) then
                                                ShowAboveRadarMessage("~r~Pas assez de place dans le coffre")
                                                return false
                                            else

                                                local v = inventory[k]
                                                local _v = v
                                                local type = 0
                                                for i = 1, count, 1 do
                                                    if _v[i] ~= nil then

                                                        local item = { name = k, metadata = _v[i].data, storage = self.name }
                                                        TriggerServerEvent("rage-reborn:DepositStockageItem", item)
                                                        self:AddItem(item)

                                                    end
                                                end
                                                for i = 1, count, 1 do
                                                    if _v[1] ~= nil then
                                                        Inventory.removeItem(_v[i].id, k)
                                                    end
                                                end
                                                Citizen.CreateThread(function()
                                                    Wait(100)
                                                    Inventory:Load()
                                                end)
                                                Citizen.CreateThread(function()
                                                    Wait(500)
                                                    self:RefreshDB()
                                                end)
                                                
                                            end
                                        elseif count ~= nil and count > #v then
                                            ShowAboveRadarMessage("~r~Pas assez de " .. Items[k].label:lower() .. " dans le coffre")
                                        end

                                    end
                                end, RMenu:Get('storage', 'main'))
                            elseif table.count(inventory) == 1 then
                                RageUI.Button("Vide", nil, {}, true, function(_, _, _)
                                end)
                            end

                        end
                    end
                end, function()
                end)
            end
        end
    end
end)
