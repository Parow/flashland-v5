local Property = {}
local currentProperty = {}
local currentAppart = nil
PlyUuid = nil
RMenu.Add('appart',"main", RageUI.CreateMenu(nil, "Actions disponibles",10,100))
local CoordsCamList = {
    {
        coords={x=1087.69,y=-3095.56,z=-36.5},
        r={x=-200.0,y=-180.0,z=-57.39},
        entry ={x=1087.63,y=-3099.42,z=-39.0},
        coffre = {x=1091.37,y=-3096.9,z=-39.0}
    },
    {
        coords={x=1048.45,y=-3111.36,z=-36.8},
        r={x=-10.0,y=0.0,z=-74.39},
        entry ={x=1048.31,y=-3097.34,z=-39.0},
        coffre = {x=1052.97,y=-3095.2,z=-39.0}
    },
    {
        coords={x=993.13,y=-3092.36,z=-33.5},
        r={x=-200.0,y=-180.0,z=-57.39},
        entry ={x=992.76,y=-3097.81,z=-39.0},
        coffre = {x=1003.48,y=-3102.71,z=-39.0}

    },
    {
        coords={x=257.73,y=-995.36,z=-98.0},
        r={x=-190.0,y=-180.0,z=-49.43},
        entry ={x=266.06,y=-1007.38,z=-101.01},
        coffre = {x=259.81,y=-1003.95,z=-99.01},
    },
    {
        coords={x=337.98,y=-993.43,z=-98.0},
        r={x=-190.0,y=-180.0,z=-49.43},
        entry ={x=346.38,y=-1012.72,z=-99.2},
        coffre = {x=351.9,y=-998.6,z=-99.2},
    },
    {
        coords={x=-769.52,y=342.82,z=213.04},
        r={x=-190.0,y=-180.0,z=49.01},
        entry ={x=-781.56,y=322.36,z=212.0},
        coffre = {x=-765.52,y=327.23,z=211.4},
    },

    {
        coords={x=1097.9,y=-3166.48,z=-35.25},
        r={x=-190.0,y=-180.0,z=220.44},
        entry ={x=1121.09,y=-3152.33,z=-37.06},
        coffre = {x=-1114.99,y=-3162.1,z=-36.87},
    },

    }
local function Exit22()
    -- Zone:Remove(PosSS)
    TriggerEvent('instance:leave')
    ExitProperty()
    KeySettings:Clear("keyboard","E","Appart_")
    KeySettings:Clear("controller","E","Appart_")
    Hint:RemoveAll()
 end
 local function Enter2(pos)
     PosSS = pos
     Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
     KeySettings:Add("keyboard","E",Exit22,"Appart_")
     KeySettings:Add("controller",46,Exit22,"Appart_")
 end
 
 local function Exit2()
     KeySettings:Clear("keyboard","E","Appart_")
     KeySettings:Clear("controller","E","Appart_")
     Hint:RemoveAll()
 end
local function Format()
    for i = 1 , #Property, 1 do
        Property[i].Pos = json.decode(Property[i].pos)
        Property[i].capacity = string.gsub(Property[i].capacity, "KG", "")
        Property[i].capacity = tonumber(Property[i].capacity)

        Property[i].coowner = Property[i].coowner == nil and {} or json.decode(Property[i].coowner)
    end
    SetupApparts()
end
local function Exit()
    currentAppart = nil
    KeySettings:Clear("keyboard","E","Appart")
    KeySettings:Clear("controller","E","Appart")
    Hint:RemoveAll()
end
local function Open()
    currentProperty = Property[currentAppart]
    RMenu:Get('appart',"main"):SetTitle(currentProperty.name)
    RageUI.Visible(RMenu:Get('appart',"main"),true)
    Exit()
end
local function Enter(z)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
    KeySettings:Add("keyboard","E",Open,"Appart")
    KeySettings:Add("controller",46,Open,"Appart")
    currentAppart = z
end


local _Marker = {
    type = 25,
    scale = {x=1.5,y=1.5,z=0.2},
    color = {r=255,g=255,b=255,a=120},
    Up = false,
    Cam = false,
    Rotate = false,
    visible = true
}


function SetupApparts()
    for i = 1 , #Property, 1 do
        Zone:Add(Property[i].Pos,Enter,Exit,i,1.3)
        Marker:Add(Property[i].Pos,_Marker)
    end
end

function StartEverything()
    for i=1 , #CoordsCamList , 1 do
        local property = CoordsCamList[i]
        property.entry.z = property.entry.z - 0.9
        Zone:Add(property.entry,Enter2,Exit2,property.entry,1.3)
        Marker:Add(property.entry,_Marker)
    end
    TriggerServerCallback('appart:requestData', function(apparts)
        Property = apparts
        Format()
    end)
end
RegisterNetEvent('appart:RequestApparts')
AddEventHandler('appart:RequestApparts', function(_users)
    for i = 1 , #Property, 1 do
        Zone:Remove(Property[i].Pos)
        Marker:Remove(Property[i].Pos)
    end
    Wait(500)
    TriggerServerCallback('appart:requestData', function(apparts)
        Property = apparts
        Format()
    end)
end)
local Exist = false
RegisterNetEvent('instance:Exist')
AddEventHandler('instance:Exist', function(_users)
    Exist = _users
end)
RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)

	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end

end)

TriggerEvent('instance:registerType', 'property',
  function(instance)
    EnterProperty()
  end,
  function(instance)
    ExitProperty()
  end
)

local PosSS = {}

local MYPOS = {}
function EnterProperty()



  local playerPed      = GetPlayerPed(-1)
  local propertyX = currentProperty
  local property = CoordsCamList[currentProperty.indexx]

	Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

	    SetEntityCoords(playerPed, property.entry.x,  property.entry.y,  property.entry.z)

		DoScreenFadeIn(800)

        DrawSub(propertyX.name, 5000)
    
        w = propertyX["capacity"]


    end)
    


end
function DrawSub(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, 1)
end
function ExitProperty()
--  Marker:Remove(CoordsCamList[currentProperty.indexx].entry)
  outside = MYPOS

  Zone:Remove(CoordsCamList[currentProperty.indexx].coffre)
  Citizen.CreateThread(function()

		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

	  SetEntityCoords(playerPed, outside.x,  outside.y,  outside.z)

		DoScreenFadeIn(800)

	end)
end
function DeletePropr()
   for i = 1 ,#Property, 1 do
        if Property[i].id == currentProperty.id then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            TriggerServerEvent("appart:remove",Property[i].id)
            Marker:Remove(Property[i].Pos)
            Zone:Remove(Property[i].Pos)
            table.remove(Property,i)
            break
        end
   end
end
function NoOwnerAppart()
    RageUI.Button("Visiter",nil,{},true,function(_,_,Selected)
        if Selected then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            MYPOS = currentProperty.Pos
            
            TriggerServerEvent("instance:checkifexist",currentProperty.name)
            while Exist == false do
              Wait(1)
            end
            if Exist == nil then
              TriggerEvent('instance:create', 'property', {property =currentProperty.name , owner = currentProperty.name})
            else
              TriggerEvent("instance:enter",{host=Exist,property = currentProperty.name, owner = currentProperty.name,type="property"})
            end
            Exist = false
        end
    end)
    RageUI.Button("Propriétaire",nil,{RightLabel = "Aucun"},true,function(_,_,Selected)
    end)
    RageUI.Button("Contacter un agent immobilier",nil,{RightLabel = ""},true,function(_,_,Selected)
        if Selected then
            no("Vous avez appellé un ~b~agent immobilier")
            MakeCall("immo")
        end
    end)

    if Job:Get().name == "immo" then
        RageUI.CenterButton("~b~↓↓↓ ~s~Action immobilier ~b~↓↓↓", nil, {}, true, function(_, _, _)
        end)
        RageUI.Button("Capacité du coffre",nil,{RightLabel = currentProperty.capacity .. "KG"},true,function(_,_,Selected)
        end)

        RageUI.Button("Prix de la propriété",nil,{RightLabel = currentProperty.price .. "$"},true,function(_,_,Selected)
        end)

        RageUI.Button("Prix de la location (par semaine)",nil,{RightLabel = currentProperty.price/50 .. "$"},true,function(_,_,Selected)
        end)

        RageUI.Button("Assigner quelqu'un à cet propriété",nil,{},true,function(_,Ac,Selected)
            if Ac then  
                HoverPlayer()
            end
            if Selected then
                local pedId = GetPlayerServerIdInDirection(10.0)
                if pedId then
                    TriggerServerEvent("core:SetNewOwner",pedId,currentProperty.id)
                end
            end
        end)

        RageUI.Button("~r~Supprimer la propriété",nil,{RightLabel = nil},true,function(_,_,Selected)
            if Selected then
                DeletePropr()
            end
        end)
    end
end
function addStorage()
    local Storage = Storage.New(currentProperty.name.."_storage", currentProperty.capacity) -- storageName is the bdd name
    Storage:LinkToPos(CoordsCamList[currentProperty.indexx].coffre)

end

function OwnAppart()
    RageUI.Button("Rentrer",nil,{},true,function(_,_,Selected)
        if Selected then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            MYPOS = currentProperty.Pos
            
            TriggerServerEvent("instance:checkifexist",currentProperty.name)
            while Exist == false do
              Wait(1)
            end
            if Exist == nil then
              TriggerEvent('instance:create', 'property', {property =currentProperty.name , owner = currentProperty.name})
            else
              TriggerEvent("instance:enter",{host=Exist,property = currentProperty.name, owner = currentProperty.name,type="property"})
            end
            Exist = false
            addStorage()

        end
    end)
    RageUI.Button("Propriétaire",nil,{RightLabel = "Vous"},true,function(_,_,Selected)
    end)
    if currentProperty.time == nil then
        currentProperty.time = "Propriétaire"
    end
    RageUI.Button("Fin du bail",nil,{RightLabel = currentProperty.time},true,function(_,_,Selected)
    end)

    RageUI.Button("Ajouter un copropriétaire",nil,{RightLabel = currentProperty.time},true,function(_,Ac,Selected)
        if Ac then
            HoverPlayer()
        end

        if Selected then
            local pedId = GetPlayerServerIdInDirection(10.0)
            if pedId then
                TriggerServerEvent("core:AddCoOwner",pedId,currentProperty.id,currentProperty.coowner)
            end
        end
    end)
end

function isCoOwn(PlyUuid)
    local found = false
    for i = 1 , #currentProperty.coowner, 1 do
        if currentProperty.coowner[i] == PlyUuid then
            found = true
            break
        end
    end
    return found
end

function CoOwnAppart()
    RageUI.Button("Rentrer",nil,{},true,function(_,_,Selected)
        if Selected then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            MYPOS = currentProperty.Pos
            
            TriggerServerEvent("instance:checkifexist",currentProperty.name)
            while Exist == false do
              Wait(1)
            end
            if Exist == nil then
              TriggerEvent('instance:create', 'property', {property =currentProperty.name , owner = currentProperty.name})
            else
              TriggerEvent("instance:enter",{host=Exist,property = currentProperty.name, owner = currentProperty.name,type="property"})
            end
            Exist = false
            addStorage()

        end
    end)
    RageUI.Button("Propriétaire",nil,{RightLabel = "Masqué"},true,function(_,_,Selected)
    end)
    if currentProperty.time == nil then
        currentProperty.time = "Propriétaire"
    end
    RageUI.Button("Fin du bail",nil,{RightLabel = currentProperty.time},true,function(_,_,Selected)
    end)
end

function Idontownappart()
    RageUI.Button("Sonner",nil,{},true,function(_,_,Selected)
        if Selected then
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            RageUI.GoBack()
            -- TODO
        end
    end)

end


Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('appart',"main")) then
            RageUI.DrawContent({ header = true, glare = false }, function()
                if currentProperty.owner == nil then
                    NoOwnerAppart()
                else
                    if PlyUuid == currentProperty.owner then
                        OwnAppart()
                    else
                        if isCoOwn(PlyUuid) then
                            CoOwnAppart()
                        else
                            Idontownappart()
                        end
                    end
                end
            end,function()
            end)
        end

    end
end)
