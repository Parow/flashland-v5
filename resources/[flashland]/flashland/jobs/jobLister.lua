local JobListing = {}
local JobAnnounce = {}
local myJobAnnounce = {}
local myJobAnnounceSelected = {}
local myJobAnnounceIndex = 1

function JobListing.EnterZone()
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour parler au conseiller")
    KeySettings:Add("keyboard","E",JobListing.Open,"Shop")
    KeySettings:Add("controller",46,JobListing.Open,"Shop")
    while Job:Get() == nil do 
        Wait(1)
    end
    TriggerServerCallback('joblisting:RequestData', function(data1,data2)
        JobAnnounce = data1
        if data2 ~= nil then
            myJobAnnounce = data2
        end
    end,Job:Get().name)
end

function JobListing.ExitZone()
    Hint:RemoveAll()
    KeySettings:Clear("keyboard","E","Shop")
    KeySettings:Clear("controller",46,"Shop")
    if RageUI.Visible(RMenu:Get('joblisting', "main")) then
        RageUI.Visible(RMenu:Get('joblisting', "main"),false)
    end
end

function JobListing.Open()
    RageUI.Visible(RMenu:Get('joblisting', "main"),not RageUI.Visible(RMenu:Get('joblisting', "main")))
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-267.0,-958.0,31.0)
    SetBlipSprite (blip, 480)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip,  2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pôle emploi")
    EndTextCommandSetBlipName(blip)
    Zone:Add({x=-267.65,y=-958.8,z=31.22},JobListing.EnterZone,JobListing.ExitZone,nil,2.5)
    Ped:Add("Marc","ig_bankman",{x=-267.65,y=-958.8,z=30.22,a=201.94},nil)
    RMenu.Add('joblisting', "main", RageUI.CreateMenu(nil, "Emplois disponibles",10,100))
    RMenu.Add('joblisting', "main_boss", RageUI.CreateSubMenu(RMenu:Get('joblisting',"main"),nil, "Actions disponibles",10,100))
    RMenu.Add('joblisting', "main_boss_manage", RageUI.CreateSubMenu(RMenu:Get('joblisting',"main_boss"),nil, "Mes annonces",10,100))
    RMenu.Add('joblisting', "main_boss_manage_job", RageUI.CreateSubMenu(RMenu:Get('joblisting',"main_boss_manage"),nil, "Modifier une annonce",10,100))
end)

Citizen.CreateThread(function()
    while true do 
        Wait(1)
            if RageUI.Visible(RMenu:Get('joblisting',"main_boss_manage")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    if #myJobAnnounce == 0 then
                        RageUI.Button("Vide",nil,{},true,function(_,_,Selected)

                        end)
                    end
                    for i = 1 , #myJobAnnounce , 1 do
                        local v = myJobAnnounce[i]
                        RageUI.Button("Annonces #"..i,v.desc.."\nSalaire ~g~" .. v.salary.."$",{},true,function(_,_,Selected)
                            if Selected then
                                myJobAnnounceSelected = v
                                myJobAnnounceIndex = i
                            end
                        end,RMenu:Get('joblisting',"main_boss_manage_job"))
    
                    end
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('joblisting',"main_boss_manage_job")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    RageUI.Button("Modifier la description",myJobAnnounceSelected.desc,{},true,function(_,_,Selected)
                        if Selected then
                            myJobAnnounceSelected.desc = KeyboardInput("Descriptif de votre annonce (400 caractère maximum !)",myJobAnnounceSelected.desc,400)
                            JobListing.SyncMyJobAnnounce()
                        end
                    end)
                    RageUI.Button("Salaire",nil,{RightLabel=myJobAnnounceSelected.salary.."$"},true,function(_,_,Selected)
                        if Selected then
                            myJobAnnounceSelected.salary = KeyboardInput("Salaire",myJobAnnounceSelected.salary,3)
                            JobListing.SyncMyJobAnnounce()
                        end
                    end)

                    RageUI.Button("~r~Supprimer",nil,{},true,function(_,_,Selected)
                        if Selected then
                            table.remove(myJobAnnounce,myJobAnnounceIndex)
                            RageUI.GoBack()
                            JobListing.SyncMyJobAnnounce()
                        end
                    end)
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('joblisting',"main_boss")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    RageUI.Button("Gérer mes annonces",nil,{},true,function(_,_,_)
                    end,RMenu:Get('joblisting',"main_boss_manage"))

                    RageUI.Button("Ajouter une annonce",nil,{},true,function(_,_,Selected)
                        if Selected then
                            local desc = KeyboardInput("Descriptif de votre annonce (400 caractère maximum !)","",400)

                            local salary = KeyboardInput("Salaire","",3)

                            if tostring(desc) ~= nil and tonumber(salary) ~= nil then
                                table.insert( myJobAnnounce, {job=Job:Get().name,salary=salary,desc=desc})
                                table.insert( JobAnnounce, {job=Job:Get().name,salary=salary,desc=desc})
                                RageUI.Popup({message="Votre annonce à été ajouté avec ~g~succès"})
                                JobListing.SyncMyJobAnnounce()
                            end
                        end
                    end)
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('joblisting',"main")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    for k,v in pairs(Jobs) do
                        if v.FreeAccess then
                            RageUI.Button(v.label2,"Salaire de ~g~" .. v.grade[1].salary .."$",{},true,function(_,_,Selected)
                                if Selected then
                                    Job:Set(k,v.grade[1])
                                end
                            end)
                        end
                    end
                    for i = 1 , #JobAnnounce,1 do
                        RageUI.Button(Jobs[JobAnnounce[i].job].label2,JobAnnounce[i].desc.."\nSalaire de ~g~" .. JobAnnounce[i].salary .."$",{},true,function(_,_,Selected)
                            if Selected then
                                local Candid = KeyboardInput("Votre candidature (800 caractère maximum !)","",800)
                                if tostring(Candid) ~= nil then
                                    local MailFrom = KeyboardInput("Votre adresse email (50 caractère maximum !)","",50)
                                    TriggerServerEvent("mail:AddMail",JobAnnounce[i].job,Candid,MailFrom)
                                end
                            end
                        end)
                    end
                    if Job:IsBoss() then
                        RageUI.Button("Mes annonces",nil,{},true,function(_,_,_)
                        end,RMenu:Get('joblisting',"main_boss"))
                    end
                end, function()
                end)
            end

    end
end)

function JobListing.SyncMyJobAnnounce() 
    TriggerServerEvent("joblisting:SyncMyJobAnnounce",Job:Get().name,myJobAnnounce,JobAnnounce)
end


