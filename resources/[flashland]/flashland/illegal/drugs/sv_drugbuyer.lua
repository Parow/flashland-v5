---- GENERATE AND SEND TO CLIENT
local DrugBuyTable = {}
local function Generate()
    DrugBuyTable = {
        {
            Pos = {x=-44.95,y=-1290.03,z=28.17,a=271.1},
            Model = "u_m_y_militarybum",
            Name = "Maxime",
            Qty = {
                coke = math.random(0,8),
                meth =  math.random(0,8),
                lsd =  math.random(0,5),
                cannabis = math.random(10,25),
                heroine =  math.random(0,5),
                mdma =  math.random(0,4)
            },
            Price = {
                coke = math.random(50,140),
                meth = math.random(100,200),
                lsd = math.random(100,220),
                cannabis = math.random(20,80),
                heroine = math.random(100,190),
                mdma = math.random(100,240),
            },
            Quality = {
                coke = math.random(60,100),
                meth = math.random(60,100),
                lsd = math.random(60,100),
                cannabis = math.random(60,100),
                heroine = math.random(60,100),
                mdma = math.random(60,100)
            }
        },
        {
            Pos = {x=-42.18,y=-1276.03,z=28.17,a=271.1},
            Model = "a_m_y_mexthug_01",
            Name = "Nathan",
            Qty = {
                coke = math.random(0,8),
                meth =  math.random(0,8),
                lsd =  math.random(0,5),
                cannabis = math.random(10,25),
                heroine =  math.random(0,5),
                mdma =  math.random(0,4)
            },
            Price = {
                coke = math.random(50,140),
                meth = math.random(100,200),
                lsd = math.random(100,220),
                cannabis = math.random(20,80),
                heroine = math.random(100,190),
                mdma = math.random(100,240),
            },
            Quality = {
                coke = math.random(60,100),
                meth = math.random(60,100),
                lsd = math.random(60,100),
                cannabis = math.random(60,100),
                heroine = math.random(60,100),
                mdma = math.random(60,100)
            }
        },
    }
end

Generate()


RegisterServerCallback("drugs_buyer:GetInfo", function(source, callback)
    while #DrugBuyTable == 0 do 
        Wait(1)
        print("waiting")
    end
    callback(DrugBuyTable)
end)

RegisterServerEvent("drugs_buyer:Update")
AddEventHandler("drugs_buyer:Update", function(tab,index)
    TriggerClientEvent("drugs_buyer:sendInfo", -1, tab[index],index)
end)