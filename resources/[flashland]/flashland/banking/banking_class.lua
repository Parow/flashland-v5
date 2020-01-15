Banking = {}
local Banks = {}

Banking.GetAccount = function(name)
    if Banks[name] == nil then
        Banks[name] = Banking.CreateBanks(name)
    end
    return Banks[name]
end

function Banking.CreateBanks(name)
    local FLT = {}
    local self = FLT
    FLT.label = nil
    FLT.name = name
    FLT.owner = nil
    FLT.coowner = nil
    FLT.money = nil
    FLT.quotas = nil
    -- TODO Fix this

    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account WHERE iban = @name",
        {
            ["@name"] = name
        },
        function(result)
            if result[1] ~= nil then
                FLT.label = result[1].label
                FLT.owner = result[1].uuid
                FLT.coowner = result[1].coowner
                FLT.money = result[1].amount
                FLT.id = result[1].id
                FLT.quotas = result[1].todayratio
            else
                return print("Aucun compte créer à cette adresse")
            end
        end
    )
    while FLT.money == 0 do
        Wait(1)
    end
    FLT.removeMoney = function(m)
        if m ~= nil then
            if m < 0 then
                TriggerEvent("banImACheater", FLT.source)
            end
                local newMoney = FLT.money - m
                FLT.money = newMoney
        end
    end
    FLT.addMoney = function(m)
        local newMoney = FLT.money + m
        FLT.money = newMoney
    end

    FLT.getMoney = function(m)
        return FLT.money
    end

    return FLT
end
function Banking.SaveBanks()
    for k, v in pairs(Banks) do
        MySQL.Async.execute(
            "UPDATE banking_account SET amount=@data,label=@label,coowner=@coowner,todayratio=@quotasd where id=@id",
            {
                ["@id"] = v.id,
                ["@data"] = v.money,
                ["@coowner"] = v.coowner,
                ["@label"] = v.label,
                ["@quotasd"] = json.encode(v.quotas)
            }
        )
    end
    print("^3[Banking] ^2Banks accounts saved ^0")
    SetTimeout(60000, Banking.SaveBanks)
end

SetTimeout(60000, Banking.SaveBanks)

RegisterServerCallback(
    "getBankingAccountsPly",
    function(source, callback)
        local _source = source
        local uuid = Player.GetPlayer(_source).uuid
        local acc = {own = {}, coOwn = {}}
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where uuid=@uuid",
            {
                ["@uuid"] = uuid
            },
            function(result)
                acc.own = result

            end
        )
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account where coowner=@uuid",
            {
                ["@uuid"] = uuid
            },
            function(result)

                acc.coOwn = result

                callback(acc)
            end
        )
        while acc == nil do
            Wait(1)
        end

    end
)
RegisterServerCallback(
    "banksExists",
    function(source, callback,name)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account WHERE iban = @name",
            {
                ["@name"] = name
            },
            function(result)
                if result[1] ~= nil then
                    callback(true)
                else
                    callback(false)
                end
            end
        )
    end
)
RegisterServerCallback(
    "getAllBanks",
    function(source, callback)
        MySQL.Async.fetchAll(
            "SELECT * FROM banking_account",
            {},
            function(result)
                callback(result)
            end
        )
    end
)

MySQL.ready(function ()
    MySQL.Async.fetchAll(
        "SELECT * FROM banking_account",
        {
            ["@uuid"] = uuid
        },
        function(result)
            for i = 1 , #result , 1 do 
                local data = json.decode(result[i].todayratio)
                data.remove = 0
                data.deposit = 0
                data = json.encode(data)
                MySQL.Async.execute(
                    "UPDATE banking_account SET todayratio=@data where id=@id",
                    {
                        ["@id"] = result[1].id,
                        ["@data"] = data,
                    }
                )
            end
        end
    )
end)


RegisterServerEvent('bankingRemoveFromAccount')
AddEventHandler('bankingRemoveFromAccount', function(name,rem,dat)
    local source = source
    local account = Banking.GetAccount(name)
    while account.getMoney() == nil do 
        Wait(1)
    end
    if 0 <= account.getMoney()-rem then
        account.removeMoney(rem )
        account.quotas = dat
        local player = Player.GetPlayer(source)
        player.addMoney(rem)
    end
end)

RegisterServerEvent('bankingAddFromAccount')
AddEventHandler('bankingAddFromAccount', function(name,rem,dat)
    local source = source
    local account = Banking.GetAccount(name)
    while account.getMoney() == nil do 
        Wait(1)
    end

        account.addMoney(rem )
        account.quotas = dat
        local player = Player.GetPlayer(source)
        player.removeMoney(rem)

end)

RegisterServerEvent('bankingSendMoney')
AddEventHandler('bankingSendMoney', function(target,money,src)
    local targetAccount = Banking.GetAccount(target)
    local srcAccount = Banking.GetAccount(src)
    while targetAccount.getMoney() == nil do 
        Wait(1)
    end
    while srcAccount.getMoney() == nil do 
        Wait(1)
    end
    targetAccount.addMoney(money )
    srcAccount.removeMoney(money)

    for k,v in pairs(Users) do
        if v.uuid == srcAccount.uuid then
            TriggerClientEvent("RageUI:Popup", v.source, {message="Vous avez reçu un nouveau virement de " .. money .."$ de la part du compte " .. src})
            break
        end
    end
end)