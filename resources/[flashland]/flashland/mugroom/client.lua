local function GenerateGamemodeContent()
    return {
        Model = GenerateFreemodeModel(),
        Position = { x = 399.9, y = -998.7, z = -100.0, heading = 180.086 }, --- Mugshot coords
        mp_f_freemode_01 = {
            Face = GenerateEntityFace("mp_f_freemode_01"),
            Outfit = GenerateEntityOutfit("mp_f_freemode_01"),
            Tattoo = GenerateEntityTattoo("mp_f_freemode_01"),
            Identity = {},
        },
        mp_m_freemode_01 = {
            Face = GenerateEntityFace("mp_m_freemode_01"),
            Outfit = GenerateEntityOutfit("mp_m_freemode_01"),
            Tattoo = GenerateEntityTattoo("mp_m_freemode_01"),
            Identity = {},
        },
    }
end

RegisterNetEvent('spawnhandler:LoadCharacter')

AddEventHandler('spawnhandler:CharacterSelector', function(Skins, Identity, Jobs, Users)
    Citizen.CreateThread(function()
        LoadingPrompt("Chargement de vos personnages.", 3)
    end)

    Selector.LoadContent(Skins, Identity, Jobs, Users)
end)

AddEventHandler('spawnhandler:CharacterCreator', function(Table)
    Citizen.CreateThread(function()
        local _Generating = GenerateGamemodeContent()
        LoadingPrompt("Chargement de la création de personnage.", 3)

        local PlayerPed = GetPlayerPed(-1)
        local loadedCharacter = false;
        local selectedModel = _Generating.Model

        TriggerEvent('mugroom:updatePlayerData', GenerateGamemodeContent())

        loadedCharacter = UpdatePlayerPedFreemodeCharacter(PlayerPed, selectedModel, _Generating[selectedModel].Face, _Generating[selectedModel].Outfit, _Generating[selectedModel].Tattoo)

        while not loadedCharacter do
            Citizen.Wait(0)
        end

        SetCoords(PlayerPed, _Generating.Position)
        FreezePlayer(PlayerId(), true)

        ClearPlayerWantedLevel(PlayerId())
        ClearPedTasksImmediately(PlayerPed)
        RemoveLoadingPrompt()
        local interiorID = GetInteriorAtCoordsWithType(vector3(399.9, -998.7, -100.0), "v_mugshot")
        LoadInterior(interiorID)
        SetOverrideWeather("EXTRASUNNY")
        SetWeatherTypePersist("EXTRASUNNY")
        NetworkOverrideClockTime(16, 0, 0)

        while not IsInteriorReady(interiorID) do
            Citizen.Wait(0)
        end
    end)
    Creator.LoadContent()
end)

AddEventHandler('spawnhandler:LoadCharacter', function(Skins, Identity, Jobs, Users)
    Citizen.CreateThread(function()
        LoadingPrompt("Chargement du personnage...", 4)

        local loadedCharacter = false;
        local PlayerPed = GetPlayerPed(-1)
        PlySkin = json.decode(Skins[1].face)
        currentTattoos = json.decode(Skins[1].tattoo)
        loadedCharacter = UpdatePlayerPedFreemodeCharacter(PlayerPed, Skins[1].model, json.decode(Skins[1].face), json.decode(Skins[1].outfit), json.decode(Skins[1].tattoo))

        while not loadedCharacter do
            Citizen.Wait(0)
        end
        TriggerEvent("es:activateMoney",Users[1].money)
        TriggerEvent("es:activateBlackMoney",Users[1].black_money)
        XNL_SetInitialXPLevels(tonumber(Users[1].xp))
        Job:Set(Jobs[1].name,Jobs[1].rank)
        PlyUuid = Users[1].uuid
        Orga:Set(Jobs[1].orga,Jobs[1].orga_rank)
        Inventory:Load()
        ClearPlayerWantedLevel(PlayerId())
        ClearPedTasksImmediately(PlayerPed)
        if Users[1].position == nil then
            Users[1].position = json.encode({x=-1041.58,y=-2744.09,z=21.36})
        end
        SetCoords(GetPlayerPed(-1), json.decode(Users[1].position))
        StartEverything()
        PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
        RageUI.Popup({
            message = "Vous venez d'être téléporté à votre dernière position",
        })
    end)
    DoScreenFadeIn(500)
    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
    LocalPlayer().isBussy = false
    Citizen.Wait(5000)
    RemoveLoadingPrompt()
end)