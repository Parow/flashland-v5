local AnnounceData = {}
local AnnounceDataByJob = {}
RegisterServerEvent("joblisting:SyncMyJobAnnounce")
AddEventHandler("joblisting:SyncMyJobAnnounce",function(job,table,table2)
    if AnnounceDataByJob[job] == nil then
        AnnounceDataByJob[job] = {}
    end
    table.insert( AnnounceDataByJob[job], table )
    AnnounceData = table2
end)



RegisterServerEvent("job:AddMails")
AddEventHandler("job:AddMails",function(job,msg)

end)


RegisterServerCallback('joblisting:RequestData', function(source, callback,job)
    callback(AnnounceData,AnnounceDataByJob[job])
end)



RegisterServerEvent("facture:pay")
AddEventHandler("facture:pay",function(_facture)
    local account = Banking.GetAccount(_facture.account)
    account.addMoney(_facture.montant)
    TriggerClientEvent("facture:paied",_facture.source)
end)
RegisterServerEvent("facture:send")
AddEventHandler("facture:send",function(_facture)
    _facture.source = source
    TriggerClientEvent("facture:get",_facture.playerId,_facture)
end)
