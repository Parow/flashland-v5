local Register = {}

local function GetIdentifiers(source)
    local identifiers = {}
    local playerIdentifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(playerIdentifiers) do
        local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
        identifiers[before] = playerIdentifiers[_]
    end
    return identifiers
end

function GetUUID(source, CallBack)
    print("o",source)
    
            TriggerEvent("rage-reborn:uuid",function(u)
                print(u)
                MySQL.Async.execute('INSERT INTO users (uuid, identifier, created_at, updated_at) VALUES (@uuid, @identifier, @created_at, @updated_at)', {
                    ['@uuid'] = u,
                    ['@identifier'] = GetIdentifiers(source).steam,
                    ['@created_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
                    ['@updated_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),


                })
                CallBack(u)
            end)
end

local function InsertIdentity(UUID, FacePicture, FirstName, LastName, BirthDate, Origin)
    MySQL.Async.execute('INSERT INTO players_identity (uuid, face_picutre, first_name, last_name, birth_date, origine, created_at, updated_at) VALUES (@uuid, @face_picutre, @first_name, @last_name, @birth_date, @origine, @created_at, @updated_at)', {
        ['@uuid'] = UUID,
        ['@face_picutre'] = FacePicture,
        ['@first_name'] = FirstName,
        ['@last_name'] = LastName,
        ['@birth_date'] = BirthDate,
        ['@origine'] = Origin,
        ['@created_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
        ['@updated_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
    })
end

local function InsertAppearance(UUID, Model, Face, Outfit, Tattoo)
    print(UUID, Model, Face, Outfit, Tattoo)
    MySQL.Async.execute('INSERT INTO players_appearance (uuid, model, face, outfit, tattoo, created_at, updated_at) VALUES (@uuid, @model, @face, @outfit, @tattoo, @created_at, @updated_at)', {
        ['@uuid'] = UUID,
        ['@model'] = Model,
        ['@face'] = json.encode(Face),
        ['@outfit'] = json.encode(Outfit),
        ['@tattoo'] = json.encode(Tattoo),
        ['@created_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
        ['@updated_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time())
    })
end

local function InsertJob(UUID, Name, Grade)

    MySQL.Async.execute('INSERT INTO players_jobs (uuid, name,rank, created_at, updated_at) VALUES (@uuid, @name, @rank, @created_at, @updated_at)', {
        ['@uuid'] = UUID,
        ['@name'] = Name,
        ['@rank'] = Grade,
        ['@created_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
        ['@updated_at'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
    })

end


local function UpdateRegisterCharecterCount(Source)
    MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier = @identifier', { ["@identifier"] = GetIdentifiers(Source).steam }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local currentCharacter = result[1].character_count
            MySQL.Async.execute('UPDATE whitelist SET character_count=@character_count where identifier=@identifier', { ['@identifier'] = GetIdentifiers(Source).steam, ['@character_count'] = currentCharacter + 1, })
        else
            DropPlayer(Source, "Une exception non gérée vient de se produire [UpdateRegisterCharecterCount], contactez un développeur rapidement.")
        end
    end)
end

RegisterServerEvent('mugroom:RegisterNewPlayer')
AddEventHandler('mugroom:RegisterNewPlayer', function(Model, Face, Outfit, Tattoo, Identity, SpawnLocation)
    local source = source
    print(source)
    GetUUID(source, function(UUID)
        print(UUID)
        InsertAppearance(UUID, Model, Face, Outfit, Tattoo)
        InsertIdentity(UUID, "N/A", Identity.first_name, Identity.last_name, Identity.birth_date, Identity.origine)
        InsertJob(UUID, "chomeur" , 1)
        UpdateRegisterCharecterCount(source)
    end)
end)

local Selector = {}

function Selector:GetCharacterSkin(Source, UUID, Callback)
    MySQL.Async.fetchAll('SELECT * FROM players_appearance WHERE uuid = @uuid', { ["@uuid"] = UUID }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            Callback(result)
        else
            DropPlayer(Source, "Une exception non gérée vient de se produire [GetCharacterSkin], contactez un développeur rapidement.")
        end
    end)
end

function Selector:GetCharacterIdentity(Source, UUID, Callback)
    MySQL.Async.fetchAll('SELECT * FROM players_identity WHERE uuid = @uuid', { ["@uuid"] = UUID }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            Callback(result)
        else
            DropPlayer(Source, "Une exception non gérée vient de se produire [GetCharacterIdentity], contactez un développeur rapidement.")
        end
    end)
end

function Selector:GetCharacterJobs(Source, UUID, Callback)
    MySQL.Async.fetchAll('SELECT * FROM players_jobs WHERE uuid = @uuid', { ["@uuid"] = UUID }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            Callback(result)
        else
            DropPlayer(Source, "Une exception non gérée vient de se produire [GetCharacterJobs], contactez un développeur rapidement.")
        end
    end)
end

function Selector:GetUsersValue(Source, UUID, Callback)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifiers AND uuid=@uuid', { ["@identifiers"] = GetIdentifiers(Source).steam, ["@uuid"] = UUID, }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            Callback(result)
        else
            DropPlayer(Source, "Une exception non gérée vient de se produire [GetUsersValue], contactez un développeur rapidement.")
        end
    end)
end
local AlreadyCoiffed = {}

RegisterServerCallback('isAlreadyCoiffed', function(source, callback)
    callback(AlreadyCoiffed[source] == nil)
end)

RegisterServerEvent('face:Save')
AddEventHandler('face:Save', function(skin)
    AlreadyCoiffed[source] = 1
    MySQL.Sync.execute("UPDATE players_appearance SET face=@face WHERE uuid=@uuid", { ['@uuid'] = Player.GetPlayer(source).uuid, ['@face'] = json.encode(skin) })
end)

RegisterServerEvent('mugroom:SelectedPlayer')
AddEventHandler('mugroom:SelectedPlayer', function(UUID)
    local source = source
    if (UUID ~= nil) then
        MySQL.Sync.execute("UPDATE users SET is_active=@is_active WHERE uuid=@uuid", { ['@uuid'] = UUID, ['@is_active'] = true })
        Citizen.Wait(500)
        Selector:GetCharacterSkin(source, UUID, function(Skins)
            Selector:GetCharacterIdentity(source, UUID, function(Identity)
                Selector:GetUsersValue(source, UUID, function(Users)
                    Selector:GetCharacterJobs(source, UUID, function(Jobs)
                        TriggerClientEvent('selector:onExited', source)
                        TriggerClientEvent('spawnhandler:LoadCharacter', source, Skins, Identity, Jobs, Users)
                        
                    end)
                end)
            end)
        end)
    else
        DropPlayer(source, "Une exception non gérée vient de se produire, [UUID IS NULL] contactez un développeur rapidement.")
    end
end)


---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 30/09/2019 18:37
---

---@type table
SQL = SQL or {} -- TODO Remove this and replace with Database value
Event = Event or {}
Database = Database or {}
Players = Players or {}

function Database:UpdateEconomy(uuid, column, operator, value)
    MySQL.Async.execute('UPDATE players_economy SET ' .. column .. ' = ' .. column .. ' ' .. operator .. ' ' .. value .. ' WHERE uuid=@uuid', { ['@uuid'] = uuid }, function()
        return true;
    end)
end

function Database:onRemoveConnected(source)
    MySQL.Async.execute('DELETE FROM connected WHERE identifier=@identifier', {
        ['@identifier'] = GetIdentifiers(source)[servers.identifier]
    })
end

function Database:UpdatePermissions(uuid, table)
    if (type(table) == "table") then
        MySQL.Async.execute('UPDATE whitelist SET permissions = @table WHERE identifier=@identifier', { ['@table'] = json.encode(table), ['@identifier'] = uuid }, function()
            return true;
        end)
    else
        error("DATABASE : Update permisssions table is not a table")
    end
end

function Database:GetPlayersActive(source, identifier, callback)
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier=@identifier AND is_active = @is_active', { ['@identifier'] = identifier, ['@is_active'] = 1 }, function(data)
        if (data ~= nil and data[1] ~= nil) then
            if (#data > 1) then
                DropPlayer(source, "[rage-reborn] you have too many active characters. report : contact@dylan-malandain.io")
                callback(false, false)
            else
                callback(data[1].uuid, data[1].position)
            end
        else
            callback(false, false)
        end
    end)
end

function Database:DeleteWhereID(table, id)
    MySQL.Async.execute('DELETE From ' .. table .. ' WHERE id = @id', { ['@id'] = id, })
end

function Database:GetCharacterLimit(source, identifier, callback)
    MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier=@identifier', { ['@identifier'] = identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local json = json.decode(result[1].character_table)
            if (json.limit == json.current) then
                callback(true)
            else
                callback(false)
            end
            --callback(false)
        else
            DropPlayer(source, '[rage-reborn] selecting all content in whitelist is null. report : contact@dylan-malandain.io')
        end
    end)
end

function Database:GetContentTableWithUUID(source, uuid, table, callback)
    MySQL.Async.fetchAll('SELECT * FROM ' .. table .. ' WHERE uuid=@uuid', { ['@uuid'] = uuid }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            callback(result[1]);
        else
            DropPlayer(source, string.format('[rage-reborn] GetContentTableWithUUID Table : %s | impossible to retrieve values with uuid. report : contact@dylan-malandain.io', table))
        end
    end)
end

function Database:GetContentTableWithMultipleUUID(source, uuidTable, queryTable, callback)
    local storage = {}
    for i = 1, #uuidTable do
        MySQL.Async.fetchAll('SELECT * FROM ' .. queryTable .. ' WHERE uuid=@uuid', { ['@uuid'] = uuidTable[i] }, function(result)
            if (result ~= nil and result[1] ~= nil) then
                table.insert(storage, result[1])
            else
                DropPlayer(source, string.format('[rage-reborn] GetContentTableWithUUID Table : %s | impossible to retrieve values with uuid. report : contact@dylan-malandain.io', queryTable))
            end
        end)
    end
    Citizen.Wait(100.0)
    callback(storage)
    Citizen.Wait(100.0)
    storage = nil
end

function Database:GetWhitelistContent(source, identifier, callback)
    MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier=@identifier', { ['@identifier'] = identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            callback(result[1]);
        else
            DropPlayer(source, string.format('[rage-reborn] GetWhitelistContent | impossible to retrieve values with uuid. report : contact@dylan-malandain.io'))
        end
    end)
end

function Database:GetSelectedPlayerContent(source, identifier, uuid, callback)
    self:GetContentTableWithUUID(source, uuid, "players_appearance", function(appearance)
        self:GetContentTableWithUUID(source, uuid, "players_economy", function(economy)
            self:GetContentTableWithUUID(source, uuid, "players_identity", function(identity)
                self:GetContentTableWithUUID(source, uuid, "players_needs", function(needs)
                    self:GetContentTableWithUUID(source, uuid, "players_jobs", function(jobs)
                        self:GetContentTableWithUUID(source, uuid, "players_organization", function(organization)
                            MySQL.Async.fetchAll('SELECT * FROM players_inventory WHERE uuid=@uuid', { ['@uuid'] = uuid }, function(inventory)
                                self:GetWhitelistContent(source, identifier, function(permissions)
                                    callback(appearance, economy, identity, needs, permissions.permissions, inventory, jobs, organization)
                                end)
                            end)
                        end)
                    end)
                end)
            end)
        end)
    end)
end

function Database:GetAllUUID(_s, identifier, callback)
    local storage = {}
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier=@identifier', { ['@identifier'] = identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            for i = 1, #result do
                table.insert(storage, result[i].uuid)
            end
        else
            DropPlayer(_s, string.format('[rage-reborn] GetAllUUID | impossible to retrieve values with identifier. report : contact@dylan-malandain.io'))
        end
    end)
    Citizen.Wait(100.0)
    callback(storage)
    Citizen.Wait(100.0)
    storage = nil
end

function Database:GetAllPlayerContent(_s, uuidList, callback)
    -- TODO Add Jobs
    -- TODO Add Organization
    Database:GetContentTableWithMultipleUUID(_s, uuidList, "players_appearance", function(appearance)
        Database:GetContentTableWithMultipleUUID(_s, uuidList, "players_economy", function(economy)
            Database:GetContentTableWithMultipleUUID(_s, uuidList, "players_identity", function(identity)
                callback(#uuidList, appearance, economy, identity, {}, {})
            end)
        end)
    end)
end

function Database:SelectedPlayer(uuid)
    MySQL.Async.execute('UPDATE players SET is_active=1 WHERE uuid=@uuid', { ['@uuid'] = uuid }, function()
        return true;
    end)
end

function Database:UnselectedPlayers(source, identifier)
    Database:GetAllUUID(source, identifier, function(_)
        for i = 1, #_ do
            MySQL.Sync.execute('UPDATE players SET is_active=0 WHERE uuid=@uuid', { ['@uuid'] = _[i] }, function()
            end)
        end
    end)
end

function Database:RegisterPlayer(source, position, callback)
    TriggerEvent('rage-reborn:uuid', function(uuid)
        MySQL.Async.execute("INSERT INTO players (identifier, uuid, is_active, position, created_at, updated_at) VALUES (@identifier, @uuid, @is_active, @position, @created_at, @updated_at)", {
            ['@identifier'] = GetIdentifiers(source)[servers.identifier],
            ['@uuid'] = uuid,
            ['@is_active'] = 1,
            ['@position'] = json.encode(position),
            ['@created_at'] = GetDatetime(),
            ['@updated_at'] = GetDatetime(),
        })
        callback(uuid)
    end)
end

function Database:RegisterJobs(uuid)
    MySQL.Async.execute("INSERT INTO players_jobs (uuid, jobs, rank_id, settings, permission, created_at, updated_at) VALUES (@uuid, @jobs, @rank_id, @settings, @permission, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@jobs'] = "unemployed",
        ['@rank_id'] = 0,
        ['@settings'] = json.encode({}),
        ['@permission'] = json.encode({ }),
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:RegisterOrganization(uuid)
    MySQL.Async.execute("INSERT INTO players_organization (uuid, name, rank_id, settings, permission, created_at, updated_at) VALUES (@uuid, @name, @rank_id, @settings, @permission, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@name'] = nil,
        ['@rank_id'] = 0,
        ['@settings'] = json.encode({}),
        ['@permission'] = json.encode({}),
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:RegisterIdentity(uuid, first_name, last_name, birth_date, origine)
    MySQL.Sync.execute("INSERT INTO players_identity (uuid, face_picutre, first_name, last_name, birth_date, origine, created_at, updated_at) VALUES (@uuid, @face_picutre, @first_name, @last_name, @birth_date, @origine, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@face_picutre'] = first_name,
        ['@first_name'] = first_name,
        ['@last_name'] = last_name,
        ['@birth_date'] = birth_date,
        ['@origine'] = origine,
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:RegisterAppearance(uuid, model, face, outfit, tattoo)
    MySQL.Sync.execute("INSERT INTO players_appearance (uuid, model, face, outfit, tattoo, created_at, updated_at) VALUES (@uuid, @model, @face, @outfit, @tattoo, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@model'] = model,
        ['@face'] = json.encode(face),
        ['@outfit'] = json.encode(outfit),
        ['@tattoo'] = json.encode(tattoo),
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:RegisterEconomy(uuid, money, dirty_money)
    MySQL.Sync.execute("INSERT INTO players_economy (uuid, money, dirty_money, created_at, updated_at) VALUES (@uuid, @money, @dirty_money, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@money'] = money,
        ['@dirty_money'] = dirty_money,
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:RegisterNeeds(uuid)
    content = {food=100,drink=100,sickness=100}
    MySQL.Sync.execute("INSERT INTO players_needs (uuid, content, health, armour, created_at, updated_at) VALUES (@uuid, @content, @health, @armour, @created_at, @updated_at)", {
        ['@uuid'] = uuid,
        ['@content'] = json.encode(content),

        ['@health'] = 100,
        ['@armour'] = 100,
        ['@created_at'] = GetDatetime(),
        ['@updated_at'] = GetDatetime(),
    })
end

function Database:UpdateCharacterCount(source, type)
    MySQL.Async.fetchAll('SELECT * FROM whitelist WHERE identifier=@identifier', { ['@identifier'] = GetIdentifiers(source)[servers.identifier] }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local _tbl = json.decode(result[1].character_table)
            if (type == "add") then
                _tbl.current = _tbl.current + 1;
            else
                _tbl.current = _tbl.current - 1;
            end
            MySQL.Async.execute('UPDATE whitelist SET character_table=@character_table, updated_at=@updated_at WHERE identifier=@identifier', {
                ['@character_table'] = json.encode(_tbl),
                ["@updated_at"] = GetDatetime(),
                ['@identifier'] = GetIdentifiers(source)[servers.identifier],
            })
        else
            DropPlayer(source, '[rage-reborn] fatal error on update character count. report : contact@dylan-malandain.io')
        end
    end)
end

function Database:DeletePlayerWithUUID(source, uuid)
    MySQL.Sync.execute('DELETE FROM players WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_appearance WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_economy WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_identity WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_inventory WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_needs WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_jobs WHERE uuid=@uuid', { ['@uuid'] = uuid })
    MySQL.Sync.execute('DELETE FROM players_organization WHERE uuid=@uuid', { ['@uuid'] = uuid })
    self:UpdateCharacterCount(source, "remove")
end

function SQL:GetPlayersActive(source, identifier, callback)
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier=@identifier AND is_active = @is_active', { ['@identifier'] = identifier, ['@is_active'] = 1 }, function(data)
        if (data ~= nil and data[1] ~= nil) then
            if (#data > 1) then
                DropPlayer(source, "[rage-reborn] you have too many active characters. report : contact@dylan-malandain.io")
                callback(false, false)
            else
                callback(data[1].uuid, data[1].position)
            end
        else
            callback(false, false)
        end
    end)
end

function SQL:GetAppearanceWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll('SELECT * FROM players_appearance WHERE uuid=@uuid', { ['@uuid'] = uuid }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            callback(result[1]);
        else
            DropPlayer(source, '[rage-reborn] GetAppearanceWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
        end
    end)
end

function SQL:GetIdentityWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll('SELECT * FROM players_identity WHERE uuid=@uuid', { ['@uuid'] = uuid }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            callback(result[1]);
        else
            DropPlayer(source, '[rage-reborn] GetIdentityWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
        end
    end)
end

function SQL:GetNeedsWithUUID(source, uuid, callback)
    MySQL.Async.fetchAll('SELECT * FROM players_needs WHERE uuid=@uuid', { ['@uuid'] = uuid }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            callback(result[1]);
        else
            DropPlayer(source, '[rage-reborn] GetNeedsWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
        end
    end)
end

function SQL:SavingNeeds()

end

function SQL:GetAllUUID(source, identifier, callback)
    local storage = {}
    MySQL.Async.fetchAll('SELECT * FROM players WHERE identifier = @identifiers', { ["@identifiers"] = identifier }, function(result)
        if (result ~= nil and result[1] ~= nil) then
            for i = 1, #result do
                table.insert(storage, { uuid = result[i].uuid })
            end
            callback(storage)
            storage = {}
        else
            DropPlayer(source, '[rage-reborn] GetAllUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
        end
    end)
end

function SQL:GetAllAppearanceWithUUID(source, uuid, callback)
    local storage = {}
    setmetatable(storage, { __index = table })
    for i = 1, #uuid do
        MySQL.Async.fetchAll('SELECT * FROM players_appearance WHERE uuid = @uuid', { ["@uuid"] = uuid[i].uuid }, function(result)
            if (result ~= nil and result[1] ~= nil) then
                storage:insert({ uuid = uuid[i].uuid, face = result[1].face, outfit = result[1].outfit, tattoo = result[1].tattoo })
                -- La sa print yes
            else
                DropPlayer(source, '[rage-reborn] GetAllAppearanceWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
            end
        end)
    end
    callback(storage)
    --storage = {}
end

function SQL:GetAllIdentityWithUUID(source, uuid, callback)
    local storage = {}
    for k, v in pairs(uuid) do
        MySQL.Async.fetchAll('SELECT * FROM players_identity WHERE uuid = @uuid', { ["@uuid"] = v.uuid }, function(result)
            if (result ~= nil and result[1] ~= nil) then
                table.insert(storage, { uuid = v.uuid, table = result[1] })
            else
                DropPlayer(source, '[rage-reborn] GetAllIdentityWithUUID impossible to retrieve values with uuid. report : contact@dylan-malandain.io')
            end
        end)
    end
    callback(storage)
    storage = {}
end


RegisterServerCallback('rage-reborn:GetStorageItems', function(source,callback,name)
    MySQL.Async.fetchAll('SELECT * FROM storages_inventory_items WHERE name = @name', {
        ["@name"] = name
    }, function(result)

        MySQL.Async.fetchAll('SELECT * FROM storages_inventory_accounts WHERE name = @name', {
            ["@name"] = name
        }, function(_result)
            if _result[1] == nil then
                MySQL.Async.execute(
                    'INSERT INTO storages_inventory_accounts (name,created_at,updated_at) VALUES(@name,@created_at,@updated_at)',
                    {
                        ['@name']   =name,
                        ['@created_at'] = GetDatetime(),
                        ['@updated_at'] = GetDatetime(),
            
                    }
                )
                _result[1] = {}
                _result[1].money = 0
                _result[1].dark_money = 0
            end

            callback(result,_result[1])
        end)
        
    end)
end)

function GetDatetime(time)
    time = time or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", time)
end
RegisterServerEvent("rage-reborn:RemoveItemFromStorage")
AddEventHandler("rage-reborn:RemoveItemFromStorage",function(id)
    Database:DeleteWhereID("storages_inventory_items",id)
end)

RegisterServerEvent("rage-reborn:DepositStockageItem")
AddEventHandler("rage-reborn:DepositStockageItem",function(item)
    MySQL.Sync.execute("INSERT INTO storages_inventory_items (name,itemName,metadata) VALUES (@name,@itemName,@metadata)", {
        ['@name'] = item.storage,
        ['@itemName'] = item.name,
        ['@metadata'] = json.encode(item.metadata),

    })

end)


