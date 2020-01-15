local function j(t)
    return json.decode(t)
end
function isMale()
    return GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01")
end
local male_torso = {
    [0] = 0,                                         
    [1] = 0,
    [2] = 2,
    [3] = 14,
    [4] = 6,
    [5] = 5,
    [6] = 0,
    [7] = 1,
    [8] = 8,
    [9] = 0,
    [10] = 4,
    [11] = 1,
    [12] = 1,
    [13] = 11,
    [14] = 1,
    [15] = 15,
    [16] = 0,
    [17] = 5,
    [18] = 0,
    [19] = 4,
    [20] = 4,
    [21] = 4,
    [22] = 1,
    [23] = 2,
    [24] = 1,
    [25] = 4,
    [26] = 11,
    [27] = 4,
    [28] = 4,
    [29] = 4,
    [30] = 4,
    [31] = 4,
    [32] = 4,
    [33] = 0,
    [34] = 0,
    [35] = 4,
    [36] = 5,
    [37] = 4,
    [38] = 8,
    [39] = 0,
    [40] = 4,
    [41] = 1,
    [42] = 11,
    [43] = 11,
    [44] = 0,
    [45] = 4,
    [46] = 4,
    [47] = 0,
    [48] = 1,
    [49] = 12,
    [50] = 12,
    [51] = 12,
    [52] = 12,
    [53] = 1,
    [54] = 0,
    [55] = 0,
    [56] = 1,
    [57] = 1,
    [58] = 4,
    [59] = 4,
    [60] = 8,
    [61] = 1,
    [62] = 1,
    [63] = 0,
    [64] = 4,
    [65] = 4,
    [66] = 4,
    [67] = 4,
    [68] = 4,
    [69] = 4,
    [70] = 4,
    [71] = 0,
    [72] = 4,
    [73] = 0,
    [74] = 4,
    [75] = 0,
    [76] = 4,
    [77] = 4,
    [78] = 4,
    [79] = 4,
    [80] = 0,
    [81] = 0,
    [82] = 0,
    [83] = 0,
    [84] = 1,
    [85] = 1,
    [86] = 1,
    [87] = 1,
    [88] = 4,
    [89] = 4,
    [90] = 4,
    [91] = 15,
    [92] = 6,
    [93] = 0,
    [94] = 0,
    [95] = 11,
    [96] = 4,
    [97] = 0,
    [98] = 4,
    [99] = 4,
    [100] = 4,
    [101] = 4,
    [102] = 4,
    [103] = 4,
    [104] = 4,
    [105] = 0,
    [106] = 4,
    [107] = 4,
    [108] = 4,
    [109] = 4,
    [110] = 4,
    [111] = 4,
    [112] = 4,
    [113] = 6,
    [114] = 14,
    [115] = 4,
    [116] = 4,
    [117] = 6,
    [118] = 4,
    [119] = 4,
    [120] = 4,
    [121] = 4,
    [122] = 4,
    [123] = 0,
    [124] = 4,
    [125] = 4,
    [126] = 4,
    [127] = 4,
    [128] = 0,
    [129] = 4,
    [130] = 4,
    [131] = 0,
    [132] = 0,
    [133] = 11,
    [134] = 4,
    [135] = 0,
    [136] = 4,
    [137] = 4,
    [138] = 4,
    [139] = 4,
    [140] = 4,
    [141] = 12,
    [142] = 4,
    [143] = 4,
    [144] = 14,
    [145] = 4,
    [146] = 0,
    [147] = 4,
    [148] = 4,
    [149] = 4,
    [150] = 4,
    [151] = 4,
    [152] = 4,
    [153] = 4,
    [154] = 6,
    [155] = 4,
    [156] = 4,
    [157] = 2,
    [158] = 2,
    [159] = 2,
    [160] = 2,
    [161] = 6,
    [162] = 5,
    [163] = 1,
    [164] = 0,
    [165] = 1,
    [166] = 4,
    [167] = 4,
    [168] = 6,
    [169] = 4,
    [170] = 2,
    [171] = 4,
    [172] = 4,
    [173] = 2,
    [174] = 6,
    [175] = 5,
    [176] = 2,
    [177] = 2,
    [178] = 4,
    [179] = 2,
    [180] = 15,
    [181] = 4,
    [182] = 4,
    [183] = 4,
    [184] = 4,
    [185] = 4,
    [186] = 4,
    [187] = 6,
    [188] = 6,
    [189] = 4,
    [190] = 4,
    [191] = 4,
    [192] = 4,
    [193] = 0,
    [194] = 4,
    [195] = 4,
    [196] = 4,
    [197] = 4,
    [198] = 6,
    [199] = 6,
    [200] = 4,
    [201] = 7,
    [202] = 15,
    [203] = 4,
    [204] = 6,
    [205] = 15,
    [206] = 15,
    [207] = 4,
    [208] = 0,
    [209] = 4,
    [210] = 4,
    [211] = 4,
    [212] = 4,
    [213] = 15,
    [214] = 4,
    [215] = 4,
    [216] = 15,
    [217] = 4,
    [218] = 4,
    [219] = 2,
    [220] = 4,
    [221] = 4,
    [222] = 0,
    [223] = 2,
    [224] = 6,
    [225] = 8,
    [226] = 0,
    [227] = 4,
    [228] = 4,
    [229] = 4,
    [230] = 4,
    [231] = 4,
    [232] = 4,
    [233] = 4,
    [234] = 11,
    [235] = 0,
    [236] = 0,
    [237] = 5,
    [238] = 5,
    [239] = 5,
    [240] = 4,
    [241] = 0,
    [242] = 0,
    [243] = 4,
    [244] = 6,
    [245] = 4,
    [246] = 7,
    [247] = 0,
    [248] = 4,
    [249] = 6,
    [250] = 0,
    [251] = 4,
    [252] = 15, 
    [253] = 4,
    [254] = 8,
    [255] = 8,
    [256] = 4,
    [257] = 6,
    [258] = 6,
    [259] = 4,
    [260] = 11,
    [261] = 4,
    [262] = 4,
    [263] = 4,
    [264] = 6,
    [265] = 4,
    [266] = 4,
    [267] = 4,
    [268] = 4,
    [269] = 4,
    [270] = 4,
    [271] = 0,
    [272] = 4,
    [273] = 0,
    [274] = 7,
    [275] = 8,
    [276] = 4,
    [277] = 164,
    [278] = 4,
    [279] = 4,
    [280] = 4,
    [281] = 4,
    [282] = 0,
    [283] = 4,
    [284] = 4,
    [285] = 4,
    [286] = 4,
    [287] = 7,
    [288] = 4,
    [289] = 5,
}
local braseditInd = 1
local tshirt1 = 1
local tshirt2 = 1
local Clothes = {
    pricePerClothes = 50,
    config_clothes = {
        {x=72.254,    y=-1399.102, z=28.376},
        {x=-703.776,  y=-152.258,  z=36.415},
        {x=-167.863,  y=-298.969,  z=38.733},
        {x=428.694,   y=-800.106,  z=28.491},
        {x=-829.413,  y=-1073.710, z=10.328},
        {x=-1447.797, y=-242.461,  z=48.820},
        {x=11.632,    y=6514.224,  z=30.877},
        {x=123.646,   y=-219.440,  z=53.557},
        {x=1696.291,  y=4829.312,  z=41.063},
        {x=618.093,   y=2759.629,  z=41.088},
        {x=1190.550,  y=2713.441,  z=37.222},
        {x=-1193.429, y=-772.262,  z=16.324},
        {x=-3172.496, y=1048.133,  z=19.863},
        {x=-1108.441, y=2708.923,  z=18.107},
    },
    category = {
        {label="Haut",component=11,type=0,staticM=j(Config.Haut),staticF=j(Config.HautF)},
   --     {label="T-shirt",component=8,type=0,staticM=j(Config.Under),staticF=j(Config.UnderF)},
        {label="Pantalon",component=4,type=0,staticM=j(Config.Pant),staticF=j(Config.PantF)},
        {label="Chaussures",component=6,type=0,staticM=j(Config.Shoes),staticF=j(Config.ShoesF)},
    --    {label="Badges",component=10,type=0},
        {label="Accessoires",component=7,type=0,staticM=j(Config.Accessories),staticF=j(Config.AccessoriesF)},
        {label="Chapeau",component=0,type=1,staticM=j(Config.Hats),staticF=j(Config.HatsF)},
        {label="Lunettes",component=1,type=1,staticM=j(Config.Glasses),staticF=j(Config.GlassesF)},
        {label="Oreilles",component=2,type=1,staticM=json.decode(Config.Ears),staticF=json.decode(Config.EarsF)},
        {label="Montres",component=6,type=1,staticM=json.decode(Config.Watches),staticF=json.decode(Config.Watches)},
        {label="Bracelet",component=7,type=1,staticM=j(Config.Bracelets),staticF=j(Config.BraceletsF)}
    }

}
function Clothes.CreateShops()
    for i = 1 , #Clothes.config_clothes , 1 do
        local v = Clothes.config_clothes[i]
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite (blip, 73)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 17)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin de vêtement")
        EndTextCommandSetBlipName(blip)
        Blips:AddBlip(blip,"Magasin",v.Blips)
        v.Pos = {x=v.x,y=v.y,z=v.z}
        Zone:Add(v.Pos,Clothes.EnterZone,Clothes.ExitZone,i,2.5)
        RMenu.Add('clothesSHOP', i, RageUI.CreateMenu(nil, "Objets disponibles",10,100,"shopui_title_midfashion","shopui_title_midfashion"))
        RMenu.Add('clothesSHOP', "my_clothes_"..i, RageUI.CreateSubMenu(RMenu:Get('clothesSHOP',i),nil, "Inventaire"))
        RMenu.Add('clothesSHOP', "custom_clothes_"..i, RageUI.CreateSubMenu(RMenu:Get('clothesSHOP',"my_clothes_"..i),nil, "Modifier un vêtement"))
        RMenu.Add('clothesSHOP',"clothes_chooser_"..i, RageUI.CreateSubMenu(RMenu:Get('clothesSHOP',i),nil, "Vêtements disponibles"))
        RMenu:Get('clothesSHOP',i).Closed = function()
            Clothes.static = {}
            RefreshClothes()
        end
    end
end
local ixixi = 0
local CurrentZone = nil
function Clothes.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",Clothes.Open,"Shop")
    KeySettings:Add("controller",46,Clothes.Open,"Shop")
    CurrentZone = zone
end

function Clothes.ExitZone()
    if CurrentZone ~= nil then
        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get('clothesSHOP', CurrentZone)) then
            RageUI.Visible(RMenu:Get('clothesSHOP', CurrentZone),not RageUI.Visible(RMenu:Get('clothesSHOP', CurrentZone)))
        end
        KeySettings:Clear("keyboard","E","Shop")
        CurrentZone  = nil

        RefreshClothes()
    end
end

function Clothes.Open()
    RageUI.Visible(RMenu:Get('clothesSHOP', CurrentZone),not RageUI.Visible(RMenu:Get('clothesSHOP', CurrentZone)))
end

Clothes.CreateShops()
local oldClothes = nil
local oldVar = nil
Citizen.CreateThread(function()
    while true do 
        Wait(1)
        if CurrentZone ~= nil then
            if RageUI.Visible(RMenu:Get('clothesSHOP',"clothes_chooser_"..CurrentZone)) then
                RageUI.DrawContent({ header = true, glare = false}, function()
                    local label = nil

                    local amount = {}
                        for i = 0,Clothes.amount-1,1 do
                           
                            if Clothes.static[tostring(i)] ~= nil then
                            local u = Clothes.static[tostring(i)][tostring(Clothes.Indexes[i]-1)]
                            
                            if u == nil then
                                u = Clothes.static[tostring(i)][tostring(Clothes.Indexes[i-1]-1)]
                            end
                                label = GetLabelText(u["GXT"])
                                if label ~= nil then
                                    if label == "NULL" then
                                        label = GetLabelText(Clothes.static[tostring(i)][tostring(0)]["GXT"])
                                    end
                                    if label ~= "NULL" then
                                        for p = 1 , tableCount(Clothes.static[tostring(i)]), 1 do
                                            amount[p] = p
                                        end
                                        RageUI.List(label,amount,Clothes.Indexes[i], nil,{},true,function(_,Active,Selected,Index)
                                            Clothes.Indexes[i] = Index
                                            if Active then
                                                if oldClothes ~= i or oldVar ~= Index -1 then
                                                    if Clothes.type == 0 then
                                                        SetPedComponentVariation(GetPlayerPed(-1), Clothes.component, i, Index-1)
                                                        oldClothes = i
                                                        oldVar = Index-1
                                                        if Clothes.component == 11 then
                                                            SetPedComponentVariation(GetPlayerPed(-1),3,male_torso[i],0)
                                                        end
                                                    else
                                                        SetPedPropIndex(GetPlayerPed(-1), Clothes.component, i, Index-1)
                                                        oldClothes = i
                                                        oldVar = Index-1
                                                    end
                                                end
                                            end
                                            if Selected then
                                                if Clothes.type == 0 then
                                                    local canBuy = Money:CanBuy(Clothes.pricePerClothes)
                                                    if canBuy then
                                                        if Inventory.canReceive("clothe",1) then
                                                            local m = "female"
                                                            if isMale() then
                                                                m = "male"
                                                            end
                                                            items = {name="clothe",data={component=Clothes.component,type=Clothes.type,sex=m,equiped=false,var=i,ind=Index-1},label=label}
                                                            TriggerServerEvent("inventory:AddItem", items)
                                                            TriggerServerEvent("money:Pay", Clothes.pricePerClothes )
                                                        end
                                                    end
                                                else
                                                    local canBuy = Money:CanBuy(Clothes.pricePerClothes)
                                                    if canBuy then
                                                        if Inventory.canReceive("access",1) then
                                                            local m = "female"
                                                            if isMale() then
                                                                m = "male"
                                                            end
                                                            items = {name="access",data={component=Clothes.component,type=Clothes.type,sex=m,equiped=false,var=i,ind=Index-1},label=label}
                                                            TriggerServerEvent("inventory:AddItem", items)
                                                            TriggerServerEvent("money:Pay", Clothes.pricePerClothes )
                                                        end
                                                    end
                                                end
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('clothesSHOP',CurrentZone)) then
                RageUI.DrawContent({ header = true, glare = false}, function()
                    RageUI.Button("Modifier un vêtement", nil, {}, true, function(_, _, S)


                    end,RMenu:Get('clothesSHOP', "my_clothes_"..CurrentZone))
                    for i = 1 , #Clothes.category, 1 do
                        RageUI.Button(Clothes.category[i].label, nil, {}, true, function(_, _, S)
                            if S then
                                RMenu:Get('clothesSHOP', "clothes_chooser_"..CurrentZone).Index = 1
                                Clothes.component = Clothes.category[i].component
                                Clothes.type = Clothes.category[i].type

                                Clothes.listLabel = {}
                                Clothes.amount = GetNumberOfPedDrawableVariations(GetPlayerPed(-1),Clothes.component)
                                if isMale()  then
                                    Clothes.static = Clothes.category[i].staticM 
                                else
                                    Clothes.static = Clothes.category[i].staticF
                                end

                                Clothes.Indexes = {}
                                for i = 0,Clothes.amount-1,1 do
                                    Clothes.Indexes[i] = 1
                                end
                            end
                        end,RMenu:Get('clothesSHOP', "clothes_chooser_"..CurrentZone))
                    end
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('clothesSHOP','custom_clothes_'..CurrentZone)) then
                RageUI.DrawContent({ header = true, glare = false}, function()
                    local am = {} 
                    for i = 1 , GetNumberOfPedDrawableVariations(GetPlayerPed(-1),3) ,1 do

                        am[i] = i
                    end
                    RageUI.List("Bras", am, braseditInd, nil,{}, true, function(Hovered, Active, Selected, Index)
                        braseditInd = Index
                    
                        if Active then
                            SetPedComponentVariation(GetPlayerPed(-1), 3, Index, 0, 2)
                        end		
                    end)
                    local am = {} 
                    for i = 0 , GetNumberOfPedDrawableVariations(GetPlayerPed(-1),8) ,1 do

                        am[i] = i
                    end
                    RageUI.List("T-shirt", am, tshirt1, nil,{}, true, function(Hovered, Active, Selected, Index)

	
                        if tshirt1 ~= Index then
                            tshirt1 = Index
                            tshirt2 = 0
                            if Active then
                                SetPedComponentVariation(GetPlayerPed(-1), 8, tshirt1,tshirt2, 2)
                            end	
                        end
                    end)
                    local am = {}
                    for i = 0 , GetNumberOfPedTextureVariations(GetPlayerPed(-1),8,tshirt1) , 1 do
                        am[i] = i
                    end
                    RageUI.List("T-shirt 2", am, tshirt2, nil,{}, true, function(Hovered, Active, Selected, Index)
                        tshirt2 = Index
                    
                        if Active then
                            SetPedComponentVariation(GetPlayerPed(-1), 8, tshirt1, tshirt2, 2)
                        end		
                    end)
                    RageUI.Button("Sauvegarder", nil, {}, true, function(_,_,S)
                        if S then
                            Inventory.SelectedItem.data.bras = braseditInd
                            Inventory.SelectedItem.data.h = tshirt1
                            Inventory.SelectedItem.data.hV = tshirt2
                            TriggerServerEvent("inventory:editData",Inventory.SelectedItem.id,Inventory.SelectedItem.data)
                            RageUI.GoBack()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            RageUI.GoBack()
                            Inventory.Inventory["clothe"][ixixi].data.bras = braseditInd
                            Inventory.Inventory["clothe"][ixixi].data.h = tshirt1
                            Inventory.Inventory["clothe"][ixixi].data.hV = tshirt2
                        end
                    end)

                end, function()
                end)
            end      
            if RageUI.Visible(RMenu:Get('clothesSHOP',"my_clothes_"..CurrentZone)) then
                RageUI.DrawContent({ header = true, glare = false}, function()
                    local count = 0
                    if tableCount(Inventory.Inventory) == 0 then
                        RageUI.Button("Vide", nil, {}, true, function()
                        end)
                    else
                        for k, v in pairs(Inventory.Inventory) do

                            if k == "clothe" then
                                
                                for i = 1, #v,1 do  
                                    if v[i].label == nil then
                                        v[i].label =  ""
                                    end
                                    if v[i].data.component == 11 then
                                        RageUI.Button(Items[k].label .. " : " .. v[i].label , nil, {RightLabel }, true, function(_, _, Selected)
                                            if Selected then
                                                ixixi = i
                                                Inventory.SelectedItem = v[i]
                                                braseditInd = v[i].data.bras or 1
                                                tshirt1 = v[i].data.h or 1
                                                tshirt2 = v[i].data.hV or 1
                                                SetPedComponentVariation(GetPlayerPed(-1), 11, v[i].data.var, v[i].data.ind)
                                            end
                                        end, RMenu:Get('clothesSHOP', 'custom_clothes_'..CurrentZone))
                                        count = count + 1
                                    end
                                end
                            end
                        end
                        if count == 0 then
                            RageUI.Button("Vide", nil, {}, true, function()
                            end)
                        end
                    end
                end, function()
                end)
            end
        end
    end
end)

local masks = {
    Pos = {x=-1336.49,y=-1277.66,z=4.87,h=102.23},
    PedModel = "a_m_m_afriamer_01",
    array = json.decode(Config.MaskName),
    Indexes = {},
    price=1000
}
function masks.EnterZone(zone)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la boutique")
    KeySettings:Add("keyboard","E",masks.Open,"Shop")
    KeySettings:Add("controller",46,masks.Open,"Shop")
end

function masks.ExitZone()

        Hint:RemoveAll()
        if RageUI.Visible(RMenu:Get('masks', "main")) then
            RageUI.Visible(RMenu:Get('masks', "main"),not RageUI.Visible(RMenu:Get('masks', "main")))
        end
        KeySettings:Clear("keyboard","E","Shop")
        CurrentZone  = nil

end

function masks.Open()
    RageUI.Visible(RMenu:Get('masks', "main"),not RageUI.Visible(RMenu:Get('masks', "main")))
    playerPed = GetPlayerPed(-1)
    for i=0,GetNumberOfPedDrawableVariations(playerPed, 1)-1,1 do
        masks.Indexes[i] = 1
    end
end
function masks.Create()

    local blip = AddBlipForCoord(masks.Pos.x, masks.Pos.y, masks.Pos.z)
    SetBlipSprite (blip, 362)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 83)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Magasin de masques")
    EndTextCommandSetBlipName(blip)

    Zone:Add(masks.Pos,masks.EnterZone,masks.ExitZone,i,2.5)
    RMenu.Add('masks', "main", RageUI.CreateMenu(nil, "Masques disponibles",10,100,"shopui_title_movie_masks","shopui_title_movie_masks"))
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('masks',"main")) then
            RageUI.DrawContent({ header = true, glare = false}, function()
                playerPed = GetPlayerPed(-1)
                for i=0,GetNumberOfPedDrawableVariations(playerPed, 1)-1,1 do 
                    amount = {}
                    for c = 1, GetNumberOfPedTextureVariations(playerPed, 1, i), 1 do
            
                        amount[c] = c 
                        
                    end
                    label = GetLabelText(masks.array[tostring(i)][tostring(masks.Indexes[i]-1)]["GXT"])
                    if label ~= "NULL" then
                        RageUI.List(label, amount, masks.Indexes[i], "",{}, true, function(Hovered, Active, Selected, Index)
                            masks.Indexes[i] = Index
                        
                            if Active then
                                SetPedComponentVariation(playerPed, 1, i, Index-1, 2)
                            end		
                            if Selected then
                                local canBuy = Money:CanBuy(masks.price)
                                if canBuy then
                                    if Inventory.canReceive("mask",1) then
                                        items = {name="mask",data={component=1,equiped=false,var=i,ind=Index-1},label=label}
                                        TriggerServerEvent("inventory:AddItem", items)
                                        TriggerServerEvent("money:Pay", Clothes.price )
                                    end
                                end
                            end
                        end)
                    end
                end
            end, function()
            end)
        end
    end
end)


masks.Create()