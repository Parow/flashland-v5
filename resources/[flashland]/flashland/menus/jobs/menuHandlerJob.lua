local MenusJob = {}

function LoadJobMenu( tab )
    RMenu.Add('jobs',tab.menu.name, RageUI.CreateMenu(tab.menu.title, tab.menu.subtitle,10,100))
    for k , v in pairs(tab.submenus) do
        RMenu.Add('jobs',k, RageUI.CreateSubMenu(RMenu:Get('jobs',v.submenu),v.title, v.subtitle,10,100))
        table.insert(MenusJob,{menu=RMenu:Get('jobs',k),data=v.menus})
    end

    KeySettings:Add("keyboard","F6",function() RageUI.Visible(RMenu:Get('jobs',tab.menu.name),true) end,tab.menu.name)

    table.insert(MenusJob,{menu=RMenu:Get('jobs',tab.menu.name),data=tab})
end

local curMenu = nil

Citizen.CreateThread(function()
    while true do
        Wait(1)
        for i = 1 , #MenusJob ,1 do
            if RageUI.Visible(MenusJob[i].menu) then
                curMenu = MenusJob[i].menu
                RageUI.DrawContent({ header = true, glare = true }, function()
                    for k ,v in pairs(MenusJob[i].data.submenus) do
                        RageUI.Button(k,nil,{},true,function(_,_,Selected)
                            if Selected then
                        --        Players.SelectedUUID = i.uuid
                            end
                        end,RMenu:Get('jobs',k))
                    end
                    for _ ,v in pairs(MenusJob[i].data.buttons) do
                        RageUI.Button(v.label,nil,{},true,function(_,Active,Selected)
                            if Selected then
                                v.onSelected()
                            end
                            if Active then
                                if v.ActiveFct ~= nil then
                                    v.ActiveFct()
                                end
                            end
                        end)

                    end
                end, function()
                end)
            end
        end
    end
end)


function ClosecurretnJobMenu()
    RageUI.Visible(curMenu,false)
end


local accounts=  {}
local filteracc = nil
function LoadCustomMenu(k)
    if k == "gouv" then
        RMenu.Add('jobs',"gouvmain", RageUI.CreateMenu("Gouvernement", "Actions disponibles",10,100))
        RMenu.Add('jobs',"gouvaccounts", RageUI.CreateSubMenu(RMenu:Get('jobs',"gouvmain"),"Gouvernement","Comptes disponibles"))
        KeySettings:Add("keyboard","F6",function() RageUI.Visible(RMenu:Get('jobs',"gouvmain"),true) end,"gouv_menu")
    end
end
Citizen.CreateThread(function()
    while true do
        Wait(1)
        if RageUI.Visible(RMenu:Get('jobs',"gouvmain")) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Consulter comptes",nil,{},true,function(_,Active,Selected)
                    if Selected then
                        TriggerServerCallback("getAllBanks",function(result)
                            print(dump(result))
                            accounts = result
                        end)
                    end
                end,RMenu:Get('jobs',"gouvaccounts"))
            end, function()
            end)
        end
        if RageUI.Visible(RMenu:Get('jobs',"gouvaccounts")) then
            RageUI.DrawContent({ header = true, glare = true }, function()
                RageUI.Button("Rechercher",nil,{RightLabel = "🔍"},true,function(_,Active,Selected)
                    if Selected then
                        filteracc = KeyboardInput("Entrez un nom de compte",nil,500)
                    end
                end)
                for i  = 1 , #accounts , 1 do
                    if filteracc == nil or string.find(accounts[i].label,filteracc) then
                        RageUI.Button(accounts[i].label,accounts[i].iban,{RightLabel = accounts[i].amount .."$" },true,function(_,Active,Selected)

                        end)
                    end
                end
            end, function()
            end)
        end
    end
end)
