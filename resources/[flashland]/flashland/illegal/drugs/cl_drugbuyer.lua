local serverData = {}
local serverIndex = 1
DrugsSeller = setmetatable({
    Selling = false,
    LeftRightIndex = 1,
    XP = 5412,
    selectedIndex = 1,
    Buying = false,
    Items = {"coke1","meth1","lsd" ,"cana","hero","mdma"},
    Icon = {"coke","meth","lsd" ,"cannabis","heroine","mdma"},
    Qty = {
        coke = 1,
        meth = 0,
        lsd = 50,
        cannabis = 10,
        heroine = 0,
        mdma = 1
    },
    Price = {
        coke = 25,
        meth = 44,
        lsd = 33,
        cannabis = 900,
        heroine = 11,
        mdma = 1
    },
    Quality = {
        coke = math.random(60,100),
        meth = math.random(60,100),
        lsd = math.random(60,100),
        cannabis = math.random(60,100),
        heroine = math.random(60,100),
        mdma = math.random(60,100)
    }
}, DrugsSeller)

RMenu.Add('drugs', 'Choosing', RageUI.CreateMenu("", "Actions disponibles",10,200))

Citizen.CreateThread(function()

    Wait(1200)

    while true do
        Wait(1)

        if DrugsSeller.Choosing then
            if RageUI.Visible(RMenu:Get('drugs', 'Choosing')) then
                RageUI.DrawContent({ header = false, glare = false }, function()
                    RageUI.Button("Acheter",nil,{},true,function(_,_,Selected)
                        if Selected then
                            DrugsSeller.Selling = true
                            DrugsSeller.Choosing = false
                        end
                    end)

                    RageUI.Button("Vendre",nil,{},true,function(_,_,Selected)
                        if Selected then
                            DrugsSeller.Buying = true
                            DrugsSeller.Choosing = false
                        end
                    end)

                end, function()
                end)
            end
        end

        -- if DrugsSeller.Buying then
        --     RenderSprite("mpentry", "mp_modenotselected_gradient", 820.0, 170.0, 600, 60, 0, 0, 0, 0, 255)
        --     RenderSprite("commonmenu", "gradient_bgd", 1200.0, 220.0, 350, 450, 0, 0, 0, 0, 255)
        --     RenderRectangle(1200.0, 140.0,350,80,112, 161, 255,255)
        --     RenderText("VENDRE",1310,145,2,1.0,0,0,0,255)
        --     RenderSprite("mpinventory", "mp_specitem_package", 1044.0, 175.0, 40, 45, 0, 255, 255, 255, 255)
        --     RenderText(Inventory.Weight.."/32Kg",1130,180,4,0.55,255,255,255,255,"Center")

        --     DrugsSeller.Qty = {
        --         coke = Inventory:GetItemCount("coke1"),
        --         meth = Inventory:GetItemCount("meth1"),
        --         lsd = Inventory:GetItemCount("lsd"),
        --         cannabis = Inventory:GetItemCount("cana"),
        --         heroine = Inventory:GetItemCount("hero"),
        --         mdma = Inventory:GetItemCount("mdma"),
                
        --     }
            
            

        --     DrugsSeller.Quality = {
        --         coke = Inventory.Inventory["coke1"] ~= nil  and Inventory.Inventory["coke1"][1] ~= nil and Inventory.Inventory["coke1"][1].data.pure or 0,
        --         meth = Inventory.Inventory["meth1"] ~= nil and Inventory.Inventory["meth1"][1] ~= nil and Inventory.Inventory["meth1"][1].data.pure or 0,
        --         lsd = Inventory.Inventory["lsd"] ~= nil and Inventory.Inventory["lsd"][1] ~= nil and Inventory.Inventory["lsd"][1].data.pure or 0,
        --         cannabis = Inventory.Inventory["cana"] ~= nil and Inventory.Inventory["cana"][1] ~= nil and Inventory.Inventory["cana"][1].data.pure or 0,
        --         heroine = Inventory.Inventory["heroine"] ~= nil and Inventory.Inventory["heroine"][1] ~= nil and Inventory.Inventory["heroine"][1].data.pure or 0,
        --         mdma = Inventory.Inventory["mdma"] ~= nil and Inventory.Inventory["mdma"][1] ~= nil and Inventory.Inventory["mdma"][1].data.pure or 0
        --     }

        --     if DrugsSeller.selectedIndex == 1 then
        --         RenderSprite("mpinventory", "mp_specitem_coke", 1250.0, 260.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Cocaine",1253.0, 242.0,1,0.55,255,255,255,255)
        --         RenderText(DrugsSeller.Qty.coke.."x",1255.0, 328.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.coke .. "$",1335.0, 328.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_coke", 1250.0, 260.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Cocaine",1253.0, 242.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.coke.."x",1255.0, 328.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.coke .. "$",1335.0, 328.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 2 then
        --         RenderSprite("mpinventory", "mp_specitem_meth", 1410.0, 272.0, 70, 70, 0, 255, 255, 255, 255)
        --         RenderText("Meth",1415.0, 242.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.meth.."x",1413.0, 328.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.meth .. "$",1483.0, 328.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_meth", 1410.0, 272.0, 70, 70, 0, 255, 255, 255, 100)
        --         RenderText("Meth",1415.0, 242.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.meth.."x",1413.0, 328.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.meth .. "$",1483.0, 328.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 3 then
        --         RenderSprite("mpinventory", "mp_specitem_safe", 1250.0, 400.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("LSD",1269.0, 372.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.lsd.."x",1255.0, 478.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.lsd .. "$",1335.0, 478.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_safe", 1250.0, 400.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("LSD",1269.0, 372.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.lsd.."x",1255.0, 478.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.lsd .. "$",1335.0, 478.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 4 then
        --         RenderSprite("mpinventory", "mp_specitem_weed", 1400.0, 400.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Cannabis",1400.0, 372.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.cannabis.."x",1413.0, 478.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.cannabis .. "$",1483.0, 478.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_weed", 1400.0, 400.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Cannabis",1400.0, 372.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.cannabis.."x",1413.0, 478.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.cannabis .. "$",1483.0, 478.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 5 then
        --         RenderSprite("mpinventory", "mp_specitem_heroin", 1250.0, 538.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Héroine",1253.0, 510.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.heroine.."x",1255.0, 618.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.heroine .. "$",1335.0, 618.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_heroin", 1250.0, 538.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Héroine",1253.0, 510.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.heroine.."x",1255.0, 618.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.heroine .. "$",1335.0, 618.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 6 then
        --         RenderSprite("mpinventory", "drug_trafficking", 1400.0, 538.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("MDMA",1405.0, 510.0,1,0.55,255,255,255,255)
        --         RenderText(DrugsSeller.Qty.mdma.."x",1413.0, 618.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.mdma .. "$",1483.0, 618.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "drug_trafficking", 1400.0, 538.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("MDMA",1405.0, 510.0,1,0.55,255,255,255,100)
        --         RenderText(DrugsSeller.Qty.mdma.."x",1413.0, 618.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.BuyerPrice.mdma .. "$",1483.0, 618.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     DrugsSeller.Selling = false
        --     DrugsSeller:Controls()

        -- end
        -- if DrugsSeller.Selling then
        --     RenderSprite("mpentry", "mp_modenotselected_gradient", 820.0, 170.0, 600, 60, 0, 0, 0, 0, 255)
        --     RenderSprite("commonmenu", "gradient_bgd", 1200.0, 220.0, 350, 450, 0, 0, 0, 0, 255)
        --     RenderRectangle(1200.0, 140.0,350,80,255,255,255,255)
        --     RenderText("ACHETER",1300,145,2,1.0,0,0,0,255)
        --     RenderSprite("mpinventory", "mp_specitem_package", 1044.0, 175.0, 40, 45, 0, 255, 255, 255, 255)
        --     RenderText(Inventory.Weight.."/32Kg",1130,180,4,0.55,255,255,255,255,"Center")

        --     DrugsSeller.Qty = serverData[serverIndex].Qty
        --     DrugsSeller.Price = serverData[serverIndex].Price
        --     DrugsSeller.Quality = serverData[serverIndex].Quality

        --     if DrugsSeller.selectedIndex == 1 then
        --         RenderSprite("mpinventory", "mp_specitem_coke", 1250.0, 260.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Cocaine",1253.0, 242.0,1,0.55,255,255,255,255)
        --         RenderText(DrugsSeller.Qty.coke.."x",1255.0, 328.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.coke .. "$",1335.0, 328.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_coke", 1250.0, 260.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Cocaine",1253.0, 242.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.coke.."x",1255.0, 328.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.coke .. "$",1335.0, 328.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 2 then
        --         RenderSprite("mpinventory", "mp_specitem_meth", 1410.0, 272.0, 70, 70, 0, 255, 255, 255, 255)
        --         RenderText("Meth",1415.0, 242.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.meth.."x",1413.0, 328.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.meth .. "$",1483.0, 328.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_meth", 1410.0, 272.0, 70, 70, 0, 255, 255, 255, 100)
        --         RenderText("Meth",1415.0, 242.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.meth.."x",1413.0, 328.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.meth .. "$",1483.0, 328.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 3 then
        --         RenderSprite("mpinventory", "mp_specitem_safe", 1250.0, 400.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("LSD",1269.0, 372.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.lsd.."x",1255.0, 478.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.lsd .. "$",1335.0, 478.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_safe", 1250.0, 400.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("LSD",1269.0, 372.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.lsd.."x",1255.0, 478.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.lsd .. "$",1335.0, 478.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 4 then
        --         RenderSprite("mpinventory", "mp_specitem_weed", 1400.0, 400.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Cannabis",1400.0, 372.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.cannabis.."x",1413.0, 478.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.cannabis .. "$",1483.0, 478.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_weed", 1400.0, 400.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Cannabis",1400.0, 372.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.cannabis.."x",1413.0, 478.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.cannabis .. "$",1483.0, 478.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 5 then
        --         RenderSprite("mpinventory", "mp_specitem_heroin", 1250.0, 538.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("Héroine",1253.0, 510.0,1,0.55,255,255,255,255)

        --         RenderText(DrugsSeller.Qty.heroine.."x",1255.0, 618.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.heroine .. "$",1335.0, 618.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "mp_specitem_heroin", 1250.0, 538.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("Héroine",1253.0, 510.0,1,0.55,255,255,255,100)

        --         RenderText(DrugsSeller.Qty.heroine.."x",1255.0, 618.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.heroine .. "$",1335.0, 618.0,4,0.35,100,205,100,100,"Center")
        --     end

        --     if DrugsSeller.selectedIndex == 6 then
        --         RenderSprite("mpinventory", "drug_trafficking", 1400.0, 538.0, 90, 90, 0, 255, 255, 255, 255)
        --         RenderText("MDMA",1405.0, 510.0,1,0.55,255,255,255,255)
        --         RenderText(DrugsSeller.Qty.mdma.."x",1413.0, 618.0,4,0.35,255,255,255,255,"Center")
        --         RenderText(DrugsSeller.Price.mdma .. "$",1483.0, 618.0,4,0.35,100,205,100,255,"Center")
        --     else
        --         RenderSprite("mpinventory", "drug_trafficking", 1400.0, 538.0, 90, 90, 0, 255, 255, 255, 100)
        --         RenderText("MDMA",1405.0, 510.0,1,0.55,255,255,255,100)
        --         RenderText(DrugsSeller.Qty.mdma.."x",1413.0, 618.0,4,0.35,255,255,255,100,"Center")
        --         RenderText(DrugsSeller.Price.mdma .. "$",1483.0, 618.0,4,0.35,100,205,100,100,"Center")
        --     end
        --     DrugsSeller.Buying = false
        --     DrugsSeller:Controls()
        -- end
    end
end)

function DrugsSeller:Controls()
    local UP = IsControlJustPressed(0,27)
    local DOWN = IsControlJustPressed(0,Keys["DOWN"])
    local LEFT = IsControlJustPressed(0,Keys["LEFT"])
    local RIGHT = IsControlJustPressed(0,Keys["RIGHT"])
    local ENTER = IsControlJustPressed(0,191)
    local BACK = IsControlJustPressed(0,Keys["BACKSPACE"])
    Citizen.CreateThread(function()
        if self.selectedIndex == 1 then
            if UP then
                self.selectedIndex = 5
                return
            end
            if DOWN then
                self.selectedIndex = 3
                return
            end
            if RIGHT then
                self.selectedIndex = 2
                return
            end
            if LEFT then
                self.selectedIndex = 6
                return
            end
        elseif self.selectedIndex == 2 then
            if UP then
                self.selectedIndex = 6
                return
            end
            if DOWN then
                self.selectedIndex = 4
                return
            end
            if RIGHT then
                self.selectedIndex = 3
                return
            end
            if LEFT then
                self.selectedIndex = 1
                return
            end
        elseif self.selectedIndex == 3 then
            if UP then
                self.selectedIndex = 1
                return
            end
            if DOWN then
                self.selectedIndex = 5
                return
            end
            if RIGHT then
                self.selectedIndex = 4
                return
            end
            if LEFT then
                self.selectedIndex = 2
                return
            end
        elseif self.selectedIndex == 4 then
            if UP then
                self.selectedIndex = 2
                return
            end
            if DOWN then
                self.selectedIndex = 6
                return
            end
            if RIGHT then
                self.selectedIndex = 5
                return
            end
            if LEFT then
                self.selectedIndex = 3
                return
            end
        elseif self.selectedIndex == 5 then
            if UP then
                self.selectedIndex = 3
                return
            end
            if DOWN then
                self.selectedIndex = 1
                return
            end
            if RIGHT then
                self.selectedIndex = 6
                return
            end
            if LEFT then
                self.selectedIndex = 4
                return
            end
        elseif self.selectedIndex == 6 then
            if UP then
                self.selectedIndex = 4
                return
            end
            if DOWN then
                self.selectedIndex = 2
                return
            end
            if RIGHT then
                self.selectedIndex = 1
                return
            end
            if LEFT then
                self.selectedIndex = 5
                return
            end
        end

        if ENTER then
            if self.Selling then
                if Inventory.CanReceive(self.Items[self.selectedIndex],1) and self.Qty[self.Icon[self.selectedIndex]] > 0  then
                    local enought = "no"          
                    if BlackMoney:CanBuy( self.Price[self.Icon[self.selectedIndex]]) then
                        enought = "sale"
                    elseif Money:CanBuy( self.Price[self.Icon[self.selectedIndex]]) then
                        enought = "propre"
                    end
                    if enought ~= "no" then
                        items = {name=self.Items[self.selectedIndex],data={pure=self.Quality[self.Icon[self.selectedIndex]]}}
                        TriggerServerEvent("inventory:AddItem", items)
                        self.Qty[self.Icon[self.selectedIndex]] = self.Qty[self.Icon[self.selectedIndex]] - 1 
                        TriggerServerEvent("drugs_buyer:Update",serverData,serverIndex)
                        if enought == "propre" then
                            TriggerServerEvent("money:Pay", self.Price[self.Icon[self.selectedIndex]] )
                        else
                            TriggerServerEvent("black_money:Pay", self.Price[self.Icon[self.selectedIndex]] )
                        end
                    end
                elseif self.Qty[self.Icon[self.selectedIndex]] == 0 then
                    RageUI.PopupChar({message="Man j'en ai plus assez ! ",sender="~r~Dealer",picture="DIA_DEALER",request_stream_texture_dics="DIA_DEALER"})
                end
            else
                if Inventory:GetItemCount(self.Items[self.selectedIndex]) > 0 then
                    local id = nil
                    for k,v in pairs(Inventory.Inventory) do
                        if k == self.Items[self.selectedIndex] then
                            for i = 1 , #v , 1 do
                                id = v[i].id
                                break
                            end
                            break
                        end
                    end
                    serverData[serverIndex].Qty[self.Icon[self.selectedIndex]] = serverData[serverIndex].Qty[self.Icon[self.selectedIndex]] + 1 
                    TriggerServerEvent("drugs_buyer:Update",serverData,serverIndex)
                    TriggerServerEvent("inventory:RemoveItem",id,self.Items[self.selectedIndex])
                    TriggerServerEvent("black_money:Add",DrugsSeller.BuyerPrice[self.Icon[self.selectedIndex]])
                end
            end
        end

        if BACK then
            if self.Selling then
                self.Selling = false
                DrugsSeller.Choosing = true
                RageUI.Visible(RMenu:Get('drugs', 'Choosing'),true)
            end
            if self.Buying then
                self.Buying = false
                DrugsSeller.Choosing = true
                RageUI.Visible(RMenu:Get('drugs', 'Choosing'),true)
            end
        end
        Wait(10)
    end)
end

function DrugsSeller.EnterZone(i)
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour parler avec le dealer")
    serverIndex = i
    KeySettings:Add("keyboard","E",function()
        DrugsSeller.Choosing = true
        RageUI.Visible(RMenu:Get('drugs', 'Choosing'),true)
        DrugsSeller.BuyerPrice = {
            coke = math.random(serverData[serverIndex].Price.coke-25,serverData[serverIndex].Price.coke-5),
            meth = math.random(serverData[serverIndex].Price.meth-25,serverData[serverIndex].Price.meth-5),
            lsd = math.random(serverData[serverIndex].Price.lsd-25,serverData[serverIndex].Price.lsd-5),
            cannabis = math.random(serverData[serverIndex].Price.cannabis-8,serverData[serverIndex].Price.cannabis-2),
            heroine =math.random(serverData[serverIndex].Price.heroine-25,serverData[serverIndex].Price.heroine-5),
            mdma = math.random(serverData[serverIndex].Price.mdma-25,serverData[serverIndex].Price.mdma-5),
        }
        
    end,"DRUGS")
end

function DrugsSeller.ExitZone()
    Hint:RemoveAll()
    DrugsSeller.Selling = false
    DrugsSeller.Choosing = false
    DrugsSeller.Buying = false
    RageUI.Visible(RMenu:Get('drugs', 'Choosing'),false)
end

function DrugsSeller:getData()
    TriggerServerCallback('drugs_buyer:GetInfo', function(Data)
        serverData = Data
        for i = 1 , #Data, 1 do
            Zone:Add(Data[i].Pos,self.EnterZone,self.ExitZone,i,1.5)
            Ped:Add(Data[i].Name,Data[i].Model,Data[i].Pos,nil,function(ped)
                self.CurrentPed = ped
            end)
        end
    end)
end

RegisterNetEvent("drugs_buyer:sendInfo")
AddEventHandler("drugs_buyer:sendInfo", function(data,index)
    serverData[index] = data
end)




local SpriteIndex = {
    Items = {"coke1","meth1","lsd" ,"cana","hero","mdma"},
    Labels = {"Cocaine","Meth","LSD" ,"Cannabis","Héroine","MDMA"},
    Index = 1,
    Sprites = {"mp_specitem_coke","mp_specitem_meth","mp_specitem_safe","mp_specitem_weed","mp_specitem_heroin","drug_trafficking"},
    Count = 0,
    Valeur = 10,
    NpcBuyerPrice = 500,
    AchatMoyen = 400
}

function DrugsSeller:SellControls()
    local UP = IsControlJustPressed(0, 208)
    local DOWN = IsControlJustPressed(0, 207)
    

    local UPKey = IsControlJustPressed(0,27)
    local DOWNKey = IsControlJustPressed(0,Keys["DOWN"])
    local RightKey = IsControlJustPressed(0,Keys["RIGHT"])
    local LEFTKey = IsControlJustPressed(0,Keys["LEFT"])

    local EnterKey = IsControlJustPressed(0, Keys["ENTER"])
        if UP then
            if SpriteIndex.Index == #SpriteIndex.Items then
                SpriteIndex.Index = 1
            else
                SpriteIndex.Index = SpriteIndex.Index + 1
            end
            SpriteIndex.Count = 0
        end
        
        if DOWN then
            if SpriteIndex.Index == 1 then
                SpriteIndex.Index = #SpriteIndex.Items
            else
                SpriteIndex.Index = SpriteIndex.Index - 1
            end
            SpriteIndex.Count = 0
        end
        if UPKey then
            if SpriteIndex.Count + 1 <= Inventory:GetItemCount(SpriteIndex.Items[SpriteIndex.Index]) then
                SpriteIndex.Count =  SpriteIndex.Count + 1 
            else
                SpriteIndex.Count = 0
            end
        end

        if DOWNKey then
            if SpriteIndex.Count - 1 < 0 then
                SpriteIndex.Count = Inventory:GetItemCount(SpriteIndex.Items[SpriteIndex.Index])

            else
                SpriteIndex.Count = SpriteIndex.Count - 1
            end
        end

        if LEFTKey then
            if DrugsSeller.LeftRightIndex == 1 then
                DrugsSeller.LeftRightIndex = 2
            else
                DrugsSeller.LeftRightIndex = 1
            end
        end

        if RightKey then
            if DrugsSeller.LeftRightIndex == 1 then
                DrugsSeller.LeftRightIndex = 2
            else
                DrugsSeller.LeftRightIndex = 1
            end
        end

        if EnterKey then
            if DrugsSeller.LeftRightIndex == 1 then
                if SpriteIndex.Count > 0 then
                    local valColor = nil
                    if (SpriteIndex.NpcBuyerPrice*SpriteIndex.Count)- (SpriteIndex.AchatMoyen*SpriteIndex.Count) < 0 then
                        valColor = "~r~"
                    else
                        valColor = "~g~"
                    end
                    local xpEarn = ((SpriteIndex.NpcBuyerPrice*SpriteIndex.Count)- (SpriteIndex.AchatMoyen*SpriteIndex.Count)) * (math.random(10,20)/100)
                    if xpEarn < 0 then
                        xpEarn = 0
                    else
                        XNL_AddPlayerXP(math.floor( xpEarn ))
                    end
                    xpEarn = math.floor( xpEarn )
                    
                    RageUI.Popup({message="Vous avez vendu ~g~" ..SpriteIndex.Count .. " " .. SpriteIndex.Labels[SpriteIndex.Index] .. "~s~ pour " .. valColor .. SpriteIndex.Count*SpriteIndex.NpcBuyerPrice .. "$" .. "\n~s~Vous avez gagné ~g~" ..xpEarn.. " d'expériences" })
                else

                end
            else
                DrugsSeller.Selling = false
            end
        end
end
Citizen.CreateThread(function()
    Wait(1200)
    
DrugsSeller:getData()

    while true do
        Wait(1)
        while #serverData == 0 do

            DrugsSeller:getData()
            Wait(1)
        end

        if DrugsSeller.Selling then
            local aUp = 150
            local aDown = 150
            RenderSprite("shared", "bggradient_16x512", 1200.0, 225, 370, 500, 255, 255, 255, 255)
            RenderSprite("commonmenu", "arrowleft", 1140.0, 460, 40, 40, 0, 255, 255, 255, 255)
            RenderRectangle(1200.0, 225,370, 40,255,255,255,255)
            RenderText("VENDRE",1345.0, 225,2,0.6,0,0,0,255)
            RenderSprite("mpinventory", SpriteIndex.Sprites[SpriteIndex.Index], 1230.0, 288.0, 90, 90, 0, 255, 255, 255, 255)
            RenderText(SpriteIndex.Labels[SpriteIndex.Index],1330.0, 315,1,0.6,255,255,255,255)
            if IsControlPressed(0, 27) then
                aUp = 255
            end
            if IsControlPressed(0, Keys["DOWN"]) then
                aDown = 255
            end
            RenderSprite("basejumping", "arrow_pointer", 1520.0, 298, 40, 40, 0, 255, 255, 255, aUp)
            RenderSprite("basejumping", "arrow_pointer", 1520.0, 378, 40, -40, 0, 255, 255, 255, aDown)
            
            RenderText(SpriteIndex.Count.."x",1480.0, 310,0,0.60,255,255,255,255,"Center")

            RenderText("Valeur sur le marché",1210.0, 410,0,0.38,255,255,255,255)
            RenderText("Prix d'achat moyen",1210.0, 440,0,0.38,255,255,255,255)
            RenderText("Prix de vente",1210.0, 470,0,0.38,255,255,255,255)
            RenderText("Bénéfice",1210.0, 500,0,0.38,255,255,255,255)
            if (SpriteIndex.NpcBuyerPrice*SpriteIndex.Count)- (SpriteIndex.AchatMoyen*SpriteIndex.Count) < 0 then
                RenderText("~r~Perte potentielle de $"..(SpriteIndex.NpcBuyerPrice*SpriteIndex.Count)- (SpriteIndex.AchatMoyen*SpriteIndex.Count),1385.0, 590,0,0.38,255,255,255,255,"Center")
            else 
                RenderText("~g~Bénéfice potentiel de $"..(SpriteIndex.NpcBuyerPrice*SpriteIndex.Count)- (SpriteIndex.AchatMoyen*SpriteIndex.Count),1385.0, 590,0,0.38,255,255,255,255,"Center")
            end
            RenderText(SpriteIndex.Count .. " paquets X $".. SpriteIndex.NpcBuyerPrice .." = $"..SpriteIndex.Count*SpriteIndex.NpcBuyerPrice,1385.0, 540,0,0.38,255,255,255,255,"Center")


            RenderSprite("commonmenu", "shop_box_tick", 1300.0, 614, 80, 80, 0, 255, 255, 255, DrugsSeller.LeftRightIndex == 1 and 255 or 120)
            RenderSprite("commonmenu", "shop_box_cross", 1400.0, 614, 80, 80, 0, 255, 255,  255, DrugsSeller.LeftRightIndex == 2 and 255 or 120)
            local negatif = "~g~"
            if SpriteIndex.NpcBuyerPrice-SpriteIndex.AchatMoyen < 0 then
                negatif = "~r~"
            end
            RenderText("~g~$"..SpriteIndex.Valeur,1565.0, 410,0,0.38,255,255,255,255,"Right")
            RenderText("~g~$"..SpriteIndex.AchatMoyen,1565.0, 440,0,0.38,255,255,255,255,"Right")
            RenderText("~g~$"..SpriteIndex.NpcBuyerPrice,1565.0, 470,0,0.38,255,255,255,255,"Right")
            RenderText(negatif.."$"..SpriteIndex.NpcBuyerPrice-SpriteIndex.AchatMoyen,1565.0, 500,0,0.38,255,255,255,255,"Right")

            RenderSprite("shared", "bggradient_16x512", 580+140+20, 600, 300, 200, 255, 255, 255, 255)
            RenderRectangle(580+140+20, 600,300, 28,255,255,255,255)
            RenderText("STATISTIQUES",680+140+20, 600,2,0.4,0,0,0,255)

            RenderText("Argent dépensé:",590+140+20, 640,0,0.26,255,255,255,255)

            RenderText("Argent gagné:",590+140+20, 660,0,0.26,255,255,255,255)

            RenderText("$0",850+140+20, 640,0,0.26,255,255,255,255)
            RenderText("$0",850+140+20, 660,0,0.26,255,255,255,255)

            
            local Width = (GetPlyTotalXp()/(levelsRange*1.25*GetPlyLevel())) * 200
            -- bar xp
            RenderSprite("timerbars", "damagebarfill_128", 665+140 , 720, 200, 20, 0, 255, 255, 255, 100)
            RenderSprite("timerbars", "damagebarfill_128", 665+140, 720, Width, 20, 0, 255, 255, 255, 255)
            -- planete lvl
            RenderSprite("mprankbadge", "globe", 600+140, 700, 64, 64, 0, 200, 200, 200, 100)
            -- text du level
            RenderText(GetPlyLevel(),631+140, 706,0,0.60,255,255,255,255,"Center")
            RenderText("Prochain niveau ~g~".. GetPlyTotalXp() .."~s~/~y~"..GetXpRequiredNextLvl(),665+140+20, 740,0,0.20,255,255,255,255)
            ------

            DrugsSeller:SellControls()
        end
        if DrugsSeller.Buying then
            
            DrugsSeller.Qty = serverData[serverIndex].Qty
            DrugsSeller.Price = serverData[serverIndex].Price
            DrugsSeller.Quality = serverData[serverIndex].Quality
            RenderSprite("shared", "bggradient_16x512", 50.0, 225, 370, 500, 255, 255, 255, 255)
            RenderSprite("commonmenu", "arrowleft", 470.0, 460, -40, 40, 0, 255, 255, 255, 255)
            RenderRectangle(50.0, 225,370, 40,255,255,255,255)
            RenderText("ACHETER",188.0, 225,2,0.6,0,0,0,255)
            RenderSprite("mpentry", "mp_modenotselected_gradient", 330.0, 215, 600, 60, 0, 0, 0, 0, 255)
            RenderSprite("mpinventory", "mp_specitem_package",675.0, 220, 40, 45, 0, 255, 255, 255, 255)
            RenderText(Inventory.Weight.."/32Kg",630.0, 225,4,0.55,255,255,255,255,"Center")

            -- stats
            RenderSprite("shared", "bggradient_16x512", 580, 600, 300, 200, 255, 255, 255, 255)
            RenderRectangle(580, 600,300, 28,255,255,255,255)
            RenderText("STATISTIQUES",680, 600,2,0.4,0,0,0,255)

            RenderText("Argent dépensé:",590, 640,0,0.26,255,255,255,255)

            RenderText("Argent gagné:",590, 660,0,0.26,255,255,255,255)

            RenderText("$0",850, 640,0,0.26,255,255,255,255)
            RenderText("$0",850, 660,0,0.26,255,255,255,255)

            
            local Width = (GetPlyTotalXp()/(levelsRange*1.25*GetPlyLevel())) * 200
            -- bar xp
            RenderSprite("timerbars", "damagebarfill_128", 665, 720, 200, 20, 0, 255, 255, 255, 100)
            RenderSprite("timerbars", "damagebarfill_128", 665, 720, Width, 20, 0, 255, 255, 255, 255)
            -- planete lvl
            RenderSprite("mprankbadge", "globe", 600, 700, 64, 64, 0, 200, 200, 200, 100)
            -- text du level
            RenderText(GetPlyLevel(),631, 706,0,0.60,255,255,255,255,"Center")
            RenderText("Prochain niveau ~g~".. GetPlyTotalXp() .."~s~/~y~"..GetXpRequiredNextLvl(),665, 740,0,0.20,255,255,255,255)
            ------


            if DrugsSeller.selectedIndex == 1 then
                RenderSprite("mpinventory", "mp_specitem_coke", 97.0, 300.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("Cocaine",100.0, 282.0,1,0.55,255,255,255,255)
                RenderText(DrugsSeller.Qty.coke.."x",102.0, 368.0,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.coke .. "$",182.0, 368.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "mp_specitem_coke", 97.0, 300.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("Cocaine",100.0, 282.0,1,0.55,255,255,255,100)

                RenderText(DrugsSeller.Qty.coke.."x",102.0, 368.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.coke .. "$",182.0, 368.0,4,0.35,100,205,100,100,"Center")
            end

            if DrugsSeller.selectedIndex == 2 then
                RenderSprite("mpinventory", "mp_specitem_meth", 290.0, 300.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("Meth",307.0, 272.0,1,0.55,255,255,255,255)

                RenderText(DrugsSeller.Qty.meth.."x",290.0, 368.0,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.meth .. "$",380.0, 368.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "mp_specitem_meth", 290.0, 300.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("Meth",307.0, 272.0,1,0.55,255,255,255,100)

                RenderText(DrugsSeller.Qty.meth.."x",290.0, 368.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.meth .. "$",380.0, 368.0,4,0.35,100,205,100,100,"Center")
            end

            if DrugsSeller.selectedIndex == 3 then
                RenderSprite("mpinventory", "mp_specitem_safe", 97.0, 420.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("LSD",117.0, 393.0,1,0.55,255,255,255,255)

                RenderText(DrugsSeller.Qty.lsd.."x",102.0, 494.00,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.lsd .. "$",182.0, 494.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "mp_specitem_safe",  97.0, 420.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("LSD",117.0, 393.0,1,0.55,255,255,255,100)

                RenderText(DrugsSeller.Qty.lsd.."x",102.0, 494.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.lsd .. "$",182.0, 494.0,4,0.35,100,205,100,100,"Center")
            end

            if DrugsSeller.selectedIndex == 4 then
                RenderSprite("mpinventory", "mp_specitem_weed", 290.0, 420.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("Cannabis",288.0, 393.0,1,0.55,255,255,255,255)

                RenderText(DrugsSeller.Qty.cannabis.."x",290.0, 494.0,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.cannabis .. "$",380.0, 494.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "mp_specitem_weed", 290.0, 420.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("Cannabis",288.0, 393.0,1,0.55,255,255,255,100)

                RenderText(DrugsSeller.Qty.cannabis.."x",290.0, 494.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.cannabis .. "$",380.0, 494.0,4,0.35,100,205,100,100,"Center")
            end

            if DrugsSeller.selectedIndex == 5 then
                RenderSprite("mpinventory", "mp_specitem_heroin", 97.0, 540.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("Héroine",104.0, 513.0,1,0.55,255,255,255,255)

                RenderText(DrugsSeller.Qty.heroine.."x",102.0, 614.0,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.heroine .. "$",182.0, 614.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "mp_specitem_heroin", 97.0, 540.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("Héroine",104.0, 513.0,1,0.55,255,255,255,100)

                RenderText(DrugsSeller.Qty.heroine.."x",102.0, 614.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.heroine .. "$",182.0, 614.0,4,0.35,100,205,100,100,"Center")
            end

            if DrugsSeller.selectedIndex == 6 then
                RenderSprite("mpinventory", "drug_trafficking",290.0, 540.0, 90, 90, 0, 255, 255, 255, 255)
                RenderText("MDMA",295.0, 513.0,1,0.55,255,255,255,255)
                RenderText(DrugsSeller.Qty.mdma.."x",290.0, 614.0,4,0.35,255,255,255,255,"Center")
                RenderText(DrugsSeller.Price.mdma .. "$",380.0, 614.0,4,0.35,100,205,100,255,"Center")
            else
                RenderSprite("mpinventory", "drug_trafficking", 290.0, 540.0, 90, 90, 0, 255, 255, 255, 100)
                RenderText("MDMA",295.0, 513.0,1,0.55,255,255,255,100)
                RenderText(DrugsSeller.Qty.mdma.."x",290.0, 614.0,4,0.35,255,255,255,100,"Center")
                RenderText(DrugsSeller.Price.mdma .. "$",380.0, 614.0,4,0.35,100,205,100,100,"Center")
            end

            DrugsSeller:Controls()
        end
    end
end)