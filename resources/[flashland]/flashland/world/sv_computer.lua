


RegisterServerCallback('computer:Register', function(source, callback,Session)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    TriggerEvent('sha1', function(result)
        Session.password = result

        MySQL.Async.fetchAll('SELECT * FROM players_computer_accounts WHERE username = @username', {
            ["@username"] = Session.username
        }, function(result)
            if result[1] ~= nil then
                callback(false)
            else
                MySQL.Async.execute(
                    'INSERT INTO players_computer_accounts (username,password) VALUES(@username,@password)',
                    {
                        ['@username'] = Session.username,
                        ['@password'] = Session.password,
            
                    }
                )
                callback(true)
            end
        end)
    end,Session.password)
end)
RegisterServerCallback('job:GetAllWorkers', function(source, callback,Job)
    local ply = {}

    MySQL.Async.fetchAll('SELECT * FROM players_jobs WHERE name = @Job', {
        ["@Job"] = Job
    }, function(result)
        ply = {}
        for i = 1,#result,1 do
            MySQL.Async.fetchAll('SELECT * FROM players_identity WHERE uuid = @uuid', {
                ["@uuid"] = result[i].uuid
            }, function(_result)
                
                ply[i] = {salary=result[i].job_salary,first_name=_result[1].first_name,last_name=_result[1].last_name,grade=result[i].rank,job=result[i].name,uuid=result[i].uuid}
            end)
        end
        while #ply == 0 do
            Wait(1)
        end
        callback(ply)
    end)
    
    --callback(ply)
end)
RegisterServerCallback('computer:Login', function(source, callback,Session)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    TriggerEvent('sha1', function(result)
        Session.password = result

        MySQL.Async.fetchAll('SELECT * FROM players_computer_accounts WHERE username = @username AND password=@password', {
            ["@username"] = Session.username,
            ["@password"] = Session.password
        }, function(result)
            if result[1] == nil then
                callback(false)
            else
                callback(true,result[1].perms)
            end
        end)
    end,Session.password)
end)

RegisterServerCallback('computer:GetPerms', function(source, callback,username)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
        MySQL.Async.fetchAll('SELECT * FROM players_computer_accounts WHERE username = @username', {
            ["@username"] = username,
        }, function(result)
            callback(result[1].perms)
        end)
end)

RegisterServerEvent("computer:EditPassword")
AddEventHandler("computer:EditPassword", function(Session)
    Session.password = enc(Session.password)
    MySQL.Async.execute(
        'UPDATE players_computer_accounts SET password = @password where username = @username',
        {
            ["@username"] = Session.username,
            ["@password"] = Session.password
        }
    )
end)

RegisterServerEvent("computer:SavePerms")
AddEventHandler("computer:SavePerms", function(username,Perms)
    Perms = json.encode(Perms)
    MySQL.Async.execute(
        'UPDATE players_computer_accounts SET perms = @perms where username = @username',
        {
            ["@username"] = username,
            ["@perms"] = Perms
        }
    )
end)
RegisterServerEvent("job:UpdateGrade")
AddEventHandler("job:UpdateGrade", function(uuid,rank,label2,gradelabel)
    MySQL.Async.execute(
        'UPDATE players_jobs SET rank = @rank where uuid = @uuid',
        {
            ["@rank"] = rank,
            ["@uuid"] = uuid
        }
    )
    for k ,v in pairs(Users) do
        if v.uuid == uuid then
            TriggerClientEvent("RageUI:Popup",k,{message="Vous êtes désormais "..label2.." - " .. gradelabel})
            TriggerClientEvent("Jobs:SetRank",k,rank)
        end
    end
end)

RegisterServerEvent("job:UpdateJob2")
AddEventHandler("job:UpdateJob2", function(job,rank,src)
    local ply = Player.GetPlayer(src)
    local uuid = ply.uuid
    MySQL.Async.execute(
        'UPDATE players_jobs SET name = @job, rank=@rank where uuid = @uuid',
        {
            ["@job"] = job,
            ["@rank"] = rank,
            ["@uuid"] = uuid
        }
    )
end)
RegisterServerEvent("job:UpdateJob3")
AddEventHandler("job:UpdateJob3", function(job,rank,uuid)

    MySQL.Async.execute(
        'UPDATE players_jobs SET name = @job, rank=@rank where uuid = @uuid',
        {
            ["@job"] = job,
            ["@rank"] = rank,
            ["@uuid"] = uuid
        }
    )
end)
RegisterServerEvent("job:UpdateSalaire")
AddEventHandler("job:UpdateSalaire", function(uuid,salary)
    MySQL.Async.execute(
        'UPDATE players_jobs SET job_salary = @salary where uuid = @uuid',
        {
            ["@salary"] = salary,
            ["@uuid"] = uuid
        }
    )
    for k ,v in pairs(Users) do
        if v.uuid == uuid then
            TriggerClientEvent("RageUI:Popup",k,{message="Votre salaire est désormais de ~g~"..salary})
            TriggerClientEvent("Jobs:SetSalary",k,rank)
        end
    end
end)
RegisterServerEvent("computer:DeleteAccount")
AddEventHandler("computer:DeleteAccount", function(username)
    MySQL.Async.execute(
        'DELETE From players_computer_accounts WHERE username = @id',
        {
            ['@id']   = username,
        }
    )
end)
-- character table string
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encoding
function enc(data)

end

-- decoding
function dec(data)
  data = string.gsub(data, '[^'..b..'=]', '')
  return (data:gsub('.', function(x)
    if (x == '=') then return '' end
    local r,f='',(b:find(x)-1)
    for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then return '' end
    local c=0
    for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
    return string.char(c)
  end))
end

RegisterServerCallback('jobs:GetEmploy', function(source, callback,job)
    MySQL.Async.fetchAll('SELECT * FROM players_jobs WHERE name = @job', {
        ["@job"] = job
    }, function(result)
        MySQL.Async.fetchAll('SELECT * FROM players_identity', {
            ["@job"] = job
        }, function(_result)
            for i = 1 , #result , 1 do
                result[i].source = Player.GetSourceFromUUID(result[i].uuid)
            end
            callback(result,_result)
        end)
    end)
end)

RegisterServerCallback('mail:GetMessage', function(source, callback,job)
    local _source = source
    MySQL.Async.fetchAll('SELECT * FROM mailing WHERE receiver = @job', {
        ["@job"] = job
    }, function(result)
        callback(result)
    end)
end)


RegisterServerCallback('criminalrecords:GetAll', function(source, callback)
    local _source = source

    MySQL.Async.fetchAll('SELECT * FROM criminal_records', {
    }, function(result)
        callback(result)
    end)
end)


RegisterServerEvent("mail:DeleteFromId")
AddEventHandler("mail:DeleteFromId", function(ID)
    MySQL.Async.execute(
        'DELETE From mailing WHERE id = @id',
        {
            ['@id']   = ID,
        }
    )
end)


RegisterServerEvent("criminalrecords:Delete")
AddEventHandler("criminalrecords:Delete", function(ID)
    MySQL.Async.execute(
        'DELETE From criminal_records WHERE id = @id',
        {
            ['@id']   = ID,
        }
    )
end)

RegisterServerEvent("mail:AddMail")
AddEventHandler("mail:AddMail", function(mailTo,Message,mailFrom)
    MySQL.Async.execute(
        'INSERT INTO mailing (receiver,message,expeditor) VALUES(@mailTo,@Message,@mailFrom)',
        {
            ['@mailTo'] = mailTo,
            ['@Message'] = Message,
            ['@mailFrom'] = mailFrom,

        }
    )
end)

RegisterServerEvent("criminalrecords:Add")
AddEventHandler("criminalrecords:Add", function(title,desc,coupable,author)
    MySQL.Async.execute(
        'INSERT INTO criminal_records (name,description,author,coupable) VALUES(@title,@desc,@author,@coupable)',
        {
            ['@title'] = title,
            ['@desc'] = desc,
            ['@coupable'] = coupable,
            ['@author'] = author,
        }
    )
end)