


RegisterServerEvent("skin:AddMySkin")
AddEventHandler("skin:AddMySkin", function(p)

    local face = json.encode(p.skin)
    local outfit = json.encode(p.outfit)
    local tattoo = nil
    MySQL.Async.execute(
        'INSERT INTO players_appearance (uuid,face,outfit,tattoo) VALUES(@uuid,@face,@outfit,@tattoo)',
        {
            ['@uuid']   = Player.GetCurrentUuid(source),
            ['@face'] = face,
            ['@outfit'] = outfit,
            ['@tattoo'] = tattoo,

        }
    )

end)