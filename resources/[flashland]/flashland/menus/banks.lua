local Atm = {
    {prop = 'prop_atm_02'},
    {prop = 'prop_atm_03'},
    {prop = 'prop_fleeca_atm'},
    {prop = 'prop_atm_01'}
}

function IsNearATM()
    local objects = {}
    for _,v in pairs(Atm) do
      table.insert(objects, v.prop)
    end
  
    local ped = GetPlayerPed(-1)
    local list = {}
  
    for _,v in pairs(objects) do
        local obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 5.0, GetHashKey(v), false, true ,true)
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
        table.insert(list, {object = obj, distance = dist})
      end
  
      local closest = list[1]
      for _,v in pairs(list) do
        if v.distance < closest.distance then
          closest = v
        end
      end
  
      local distance = closest.distance
      local object = closest.object
      

      if distance < 1.8 then
        return true
      end
end
local ATM = {
    Accounts = {
        own = {},
        coOwn = {}
    }
}

RMenu.Add('banking', "main_atm", RageUI.CreateMenu(nil, "Actions disponibles",10,100))
RMenu.Add('banking', "manage_account", RageUI.CreateSubMenu(RMenu:Get('banking', "main_atm")))
local stillNear = true
function ATM.Open()
    if IsNearATM() then
        TriggerServerCallback("getBankingAccountsPly",function(result)
            stillNear = true
            ATM.Accounts = result
            RageUI.Visible(RMenu:Get('banking', "main_atm"),not RageUI.Visible(RMenu:Get('banking', "main_atm")))
        end)
    end
end
KeySettings:Add("keyboard","E",ATM.Open,"ATM")


Citizen.CreateThread(function()
    while true do 
        Wait(1)

        if stillNear then
            if RageUI.Visible(RMenu:Get('banking', "main_atm")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    RageUI.CenterButton("~b~↓↓↓ Vos comptes ~b~↓↓↓"  ,nil,{},true,function(_,_,Selected)

                    end)
                    if #ATM.Accounts.own == 0 then
                        RageUI.Button("Aucun",nil,{RightLabel=nil },true,function(_,_,Selected)
                        end)
                    end
                    for i = 1 , #ATM.Accounts.own , 1 do
                        RageUI.Button(ATM.Accounts.own[i].label,"RIB : " .. ATM.Accounts.own [i].iban,{RightLabel=ATM.Accounts.own [i].amount .. "$" },true,function(_,_,Selected)
                            if Selected then
                                ATM.Selected = ATM.Accounts.own[i]
                                RMenu:Get('banking', "manage_account").Subtitle = ATM.Accounts.own[i].label .. " " .. ATM.Accounts.own [i].amount .. "$"
                            end
                        end,RMenu:Get('banking', "manage_account"))
                    end
                    RageUI.CenterButton("~b~↓↓↓ Comptes co-propriétaires ~b~↓↓↓"  ,nil,{},true,function(_,_,Selected)

                    end)
                    if #ATM.Accounts.coOwn == 0 then
                        RageUI.Button("Aucun",nil,{RightLabel=nil },true,function(_,_,Selected)
                        end)
                    end
                    for i = 1 , #ATM.Accounts.coOwn , 1 do
                        RageUI.Button(ATM.Accounts.coOwn[i].label,"RIB : " .. ATM.Accounts.coOwn [i].iban,{RightLabel=ATM.Accounts.coOwn [i].amount .. "$" },true,function(_,_,Selected)
                            if Selected then
                                ATM.Selected = ATM.Accounts.coOwn[i]
                                RMenu:Get('banking', "manage_account").Subtitle = ATM.Accounts.coOwn[i].label .. " " .. ATM.Accounts.coOwn [i].amount .. "$"
                            end
                        end,RMenu:Get('banking', "manage_account"))
                    end
                end, function()
                end)
            end
            if RageUI.Visible(RMenu:Get('banking', "manage_account")) then
                RageUI.DrawContent({ header = false, glare = false}, function()
                    RageUI.Button("Envoyer de l'argent",nil,{RightLabel=nil },true,function(_,_,Selected)
                        if Selected then
                            local finish = false
                            local rib1 = KeyboardInput("RIB du bénéficiaire ?", nil, 255)
                            local rib2 = KeyboardInput("Confirmez svp", nil, 255)
                            if rib1 == rib2 then
                                        local amount = KeyboardInput("Montant ? ", nil, 100)
                                        local amount = tonumber(amount)
                                        if amount ~= nil then

                                            if amount <= ATM.Selected.amount then
                                                
                                                    TriggerServerCallback("banksExists",function(bool)
                                                        if bool then
                                                            TriggerServerEvent("bankingSendMoney",rib1,amount,ATM.Selected.iban)
                                                            RageUI.Popup({message="Virement effectué vers "..rib1 .. " " .. amount .. "$" })
                                                        else
                                                            RageUI.Popup({message="Le compte n'existe pas"})
                                                        end
                                                    end,rib1)
                                                
                                            end
                                        end
                            else
                                RageUI.Popup({message="Les deux rib sont différents"})
                            end
                        end
                    end)
                    RageUI.Button("Déposer de l'argent",nil,{RightLabel=nil },true,function(_,_,Selected)
                        if Selected then
                            local data = json.decode(ATM.Selected.todayratio)
                            local amount = KeyboardInput("Combien ?", nil, 255)
                            local amount = tonumber(amount)
                            if amount ~= nil then
                                if Money:CanBuy(amount) then
                                    if data.deposit + amount <= data.maxDeposit then
                                        ATM.Selected.amount = ATM.Selected.amount + amount
                                        data.deposit = data.deposit + amount
                                        RMenu:Get('banking', "manage_account").Subtitle = ATM.Selected.label .. " " .. ATM.Selected.amount .. "$"
                                        TriggerServerEvent("bankingAddFromAccount",ATM.Selected.iban,amount,data)
                                        
                                    else
                                        RageUI.Popup({message="Quotas ~r~atteint\n~s~"..data.deposit.."(~g~+"..amount.. ")~s~/"..data.maxDeposit.."$\n~b~Contactez un banquier"})
                                    end
                                else
                                    RageUI.Popup({message="Montant du compte ~r~insufisant"})
                                end
                            end
                            ATM.Selected.todayratio = json.encode(data)
                        end
                    end)
                    RageUI.Button("Retirer de l'argent",nil,{RightLabel=nil },true,function(_,_,Selected)
                        if Selected then
                            local data = json.decode(ATM.Selected.todayratio)
                            local amount = KeyboardInput("Combien ?", nil, 255)
                            local amount = tonumber(amount)
                            if amount ~= nil then
                                if amount <= ATM.Selected.amount then
                                    if data.remove + amount <= data.maxRemove then
                                        ATM.Selected.amount = ATM.Selected.amount - amount
                                        data.remove = data.remove + amount
                                        RMenu:Get('banking', "manage_account").Subtitle = ATM.Selected.label .. " " .. ATM.Selected.amount .. "$"
                                        TriggerServerEvent("bankingRemoveFromAccount",ATM.Selected.iban,amount,data)
                                        
                                    else
                                        RageUI.Popup({message="Quotas ~r~atteint\n~s~"..data.remove.."(~g~+"..amount.. ")~s~/"..data.maxRemove.."$\n~b~Contactez un banquier"})
                                    end
                                else
                                    RageUI.Popup({message="Montant du compte ~r~insufisant"})
                                end
                            end
                            ATM.Selected.todayratio = json.encode(data)
                        end
                        
                    end)
                    RageUI.Button("Informations",nil,{RightLabel=nil },true,function(_,_,Selected)
                        if Selected then
                            local data = json.decode(ATM.Selected.todayratio)
                            RageUI.Popup({message="~b~Informations du compte:~s~\nRIB ~b~"..ATM.Selected.iban..""})
                            RageUI.Popup({message="~b~Informations du quotas:~s~\nDépot ~b~"..data.deposit.."/"..data.maxDeposit .. "$\n~s~Retrait ~b~"..data.remove.."/"..data.maxRemove.."$"})
                        end
                    end)
                end, function()
                end)
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do 
        Wait(1000)
        if RageUI.Visible(RMenu:Get('banking', "main_atm")) then
            stillNear = IsNearATM()
            
            if not stillNear then
                RageUI.Visible(RMenu:Get('banking', "main_atm"),false)
            end
        end
    end
end)