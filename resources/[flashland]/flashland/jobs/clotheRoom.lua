local ClotheTenues = {}


function Job:OpenClotheRoom(type)
    if type == "Job" then
        ClotheTenues = Job.Job.work.vestiaire.Tenues
    else
        ClotheTenues = Orga.Job.work.vestiaire.Tenues
    end
    RageUI.Visible(RMenu:Get('jobs',"vestiaire"),true)
end

local function isMale()
    if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey('mp_m_freemode_01')) then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    while true do 
        Wait(1)
            if RageUI.Visible(RMenu:Get('jobs',"vestiaire")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    for k , v in pairs(ClotheTenues) do
                        RageUI.Button(k,nil,{},true,function(_,Active,Selected)
                            if Selected then
                                if Inventory.CanReceive("tenue",1) then
                                    if isMale() == 0 then
                                        local data = {torso=v.male["arms"],pant=v.male["pants_1"],chaus=v.male["shoes_1"],unders=v.male["tshirt_1"],access=-1,tops=v.male["torso_1"],pantcolor=v.male["pants_2"],chausscolor=v.male["shoes_2"],underscolor=v.male["tshirt_2"],topcolor=v.male["torso_2"],accesscolor=-1}
                                        local item = {}
                                        item.name = "tenue"
                                        item.data = data
                                        item.label = k
                                        TriggerServerEvent("inventory:AddItem", item)
                                        item = {}
                                    else
                                        local data = {torso=v.female["arms"],pant=v.female["pants_1"],chaus=v.female["shoes_1"],unders=v.female["tshirt_1"],access=-1,tops=v.female["torso_1"],pantcolor=v.female["pants_2"],chausscolor=v.female["shoes_2"],underscolor=v.female["tshirt_2"],topcolor=v.female["torso_2"],accesscolor=-1}
                                        local item = {}
                                        item.name = "tenue"
                                        item.data = data
                                        item.label = k
                                        TriggerServerEvent("inventory:AddItem", item)
                                        item = {}
                                    end
                                    RageUI.Popup({message="Vous avez reçu une nouvelle tenue"})
                                end
                            end
                        end)
                    end
                end, function()
                end)
            end
        
    end
end)


