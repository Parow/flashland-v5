RegisterServerEvent('rage-reborn:PlayerEventHandler')
AddEventHandler("rage-reborn:PlayerEventHandler",function(name,source,...)
    TriggerClientEvent(name,source,...)
end)