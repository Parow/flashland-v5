


RegisterServerCallback('core:GetPlayerPos', function(source, callback)
    local _source = source
    local identifers = GetIdentifiers(_source).steam
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifiers AND is_active = 1', {
        ["@identifiers"] = identifers
    }, function(result)
        callback(result[1].position)
    end)
end)




