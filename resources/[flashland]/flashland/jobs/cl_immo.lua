Citizen.CreateThread(function()
    Wait(10000)
    while Job == nil do
      Wait(1)
    end
    print("ready immo")
    if Job:Get().name == "immo" then
        local PosOfMarker, isMarkerEnabled,WeightOfPos,PosOfInterior,cam, numberOfHouse
        local PosInLabelAppart = 1
        local 			createdCamera  = nil
        local AppartementList = {"Petit hangars","Moyen hangars","Grand hangars","Appartement bas de gamme","Appartement moyen gamme","Appartement haute gamme","Garage"}
        local CoordsCamList = {
        {
            coords={x=1087.69,y=-3095.56,z=-36.5},
            r={x=-200.0,y=-180.0,z=-57.39},
            entry ={x=1087.63,y=-3099.42,z=-39.0},
            coffre = {x=1091.37,y=-3096.9,z=-39.0}
        },
        {
            coords={x=1048.45,y=-3111.36,z=-36.8},
            r={x=-10.0,y=0.0,z=-74.39},
            entry ={x=1048.31,y=-3097.34,z=-39.0},
            coffre = {x=1052.97,y=-3095.2,z=-39.0}
        },
        {
            coords={x=993.13,y=-3092.36,z=-33.5},
            r={x=-200.0,y=-180.0,z=-57.39},
            entry ={x=992.76,y=-3097.81,z=-39.0},
            coffre = {x=1003.48,y=-3102.71,z=-39.0}

        },
        {
            coords={x=257.73,y=-995.36,z=-98.0},
            r={x=-190.0,y=-180.0,z=-49.43},
            entry ={x=266.06,y=-1007.38,z=-101.01},
            coffre = {x=259.81,y=-1003.95,z=-99.01},
        },
        {
            coords={x=337.98,y=-993.43,z=-98.0},
            r={x=-190.0,y=-180.0,z=-49.43},
            entry ={x=346.38,y=-1012.72,z=-99.2},
            coffre = {x=351.9,y=-998.6,z=-99.2},
        },
        {
            coords={x=-769.52,y=342.82,z=213.04},
            r={x=-190.0,y=-180.0,z=49.01},
            entry ={x=-781.56,y=322.36,z=212.0},
            coffre = {x=-765.52,y=327.23,z=211.4},
        },

        {
            coords={x=1097.9,y=-3166.48,z=-35.25},
            r={x=-190.0,y=-180.0,z=220.44},
            entry ={x=1121.09,y=-3152.33,z=-37.06},
            coffre = {x=-1114.99,y=-3162.1,z=-36.87},
        },

        }
        function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
            AddTextEntry("FMMC_KEY_TIP1", TextEntry)
            DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
            blockinput = true
        
            while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
                Citizen.Wait(0)
            end
        
            if UpdateOnscreenKeyboard() ~= 2 then
                local result = GetOnscreenKeyboardResult()
                Citizen.Wait(500)
                blockinput = false
                return result
            else
                Citizen.Wait(500)
                blockinput = false
                return nil
            end
        end
        local price
        local oldIndex
        local priceAm 
        local CurrentIndexS
        local CurrentProperty
        local MYPOS
        local users = {}
        local usersID = {}
        local selectedPri = 0
        local selectedID = 0 
        local selectedName = ""
        local px = true
        local CurrentSonnerieSalope = nil
        RMenu.Add('immo',"main", RageUI.CreateMenu("Immobilier ", "Actions disponibles",10,100))

        RMenu.Add('immo',"put_proprio", RageUI.CreateSubMenu(RMenu:Get('immo',"main"),"Immobilier ", "Actions disponibles",10,100))
        RMenu:Get('immo',"put_proprio").Closed = function()
            PosOfMarker, isMarkerEnabled,WeightOfPos,PosOfInterior,cam, numberOfHouse  = nil
            PosInLabelAppart = 1
            createdCamera  = nil
            DestroyCam(createdCamera, 0)
            RenderScriptCams(0, 0, 1, 1, 1)
            createdCamera = 0
            ClearTimecycleModifier("scanline_cam_cheap")
            SetFocusEntity(GetPlayerPed(PlayerId()))
        end
        KeySettings:Add("keyboard","F6",function() RageUI.Visible(RMenu:Get('immo',"main"),true) end,"immo")
      --  RageUI.Visible(RMenu:Get('immo',"put_proprio"),true)
        Citizen.CreateThread(function()
            while true do
                Wait(1)
                if RageUI.Visible(RMenu:Get('immo',"main")) then
                  RageUI.DrawContent({ header = true, glare = false }, function()
                    RageUI.Button("Créer une propriété", nil, {
                      --RightLabel = "→"
                      }, true, function(Hovered, Active, Selected)

                    end,RMenu:Get('immo',"put_proprio"))
                    RageUI.Button("Facture", nil, {
                      --RightLabel = "→"
                      }, true, function(Hovered, Active, Selected)
                        if Selected then
                          CreateFacture("immo")
                        end
                        if Active then
                          HoverPlayer()
                        end
                    end)
                  end, function()
                  end)
                end
                if RageUI.Visible(RMenu:Get('immo',"put_proprio")) then
                    RageUI.DrawContent({ header = true, glare = false }, function()
                        if isMarkerEnabled then
                            DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                          end
                          RageUI.Button("Placer une propriété", "Place l'entrée de la propriété", {
                            --RightLabel = "→"
                            }, true, function(Hovered, Active, Selected)
                              if Active then
                                coords = GetEntityCoords(GetPlayerPed(-1))
                                if PosOfMarker == nil then
                                  DrawMarker(25, coords.x, coords.y, coords.z-0.95, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                                else
                                  DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                                end
                              end
                              if Selected then
                                isMarkerEnabled = true
                                coords =  GetEntityCoords(GetPlayerPed(-1))
                                PosOfMarker = {x=coords.x,y=coords.y,z=coords.z-0.95}
                              end
                          end,RMenu:Get('immo',"main_second"))
                    
                          if isMarkerEnabled then
                            DrawMarker(25, PosOfMarker.x, PosOfMarker.y, PosOfMarker.z, nil, nil, nil, nil, nil, nil, 1.0 , 1.0, 1.0, 255, 255, 255, 100)
                    
                            RageUI.Button("Capacité du coffre", nil, {
                              RightLabel = WeightOfPos
                              }, true, function(Hovered, Active, Selected)
                                if Selected then
                                  amount = KeyboardInput("Entrez la capacité du coffre", nil, 5)
                                  if tonumber(amount) ~= nil then
                                    WeightOfPos = amount .. "KG"
                                  end
                                end 
                            end)
                            local streetName --[[ Hash ]], crossingRoad --[[ Hash ]] = GetStreetNameAtCoord( PosOfMarker.x, PosOfMarker.y, PosOfMarker.z)
                            realstreetname = GetStreetNameFromHashKey(streetName)
                            if numberOfHouse == nil then
                                RageUI.Button("Numéro de la propriété", "Indiquez le numéro de la maison", {
                                RightLabel = nil
                                }, true, function(Hovered, Active, Selected)
                                    if Selected then
                                    amount = KeyboardInput("Entrez le numéro de la propriété", nil, 25)
                                    if tonumber(amount) ~= nil then
                                        numberOfHouse = amount
                                    end
                                    end 
                                end)
                            else
                                RageUI.Button("Numéro", "Indiquez le numéro de la maison", {
                                RightLabel = realstreetname .. " " .. numberOfHouse
                                }, true, function(Hovered, Active, Selected)
                                    if Selected then
                                    amount = KeyboardInput("Entrez le numéro de la propriété", nil, 3)
                                    if tonumber(amount) ~= nil then
                                        numberOfHouse = amount
                                    end
                                    end 
                                end)
                            
                            end
                            RageUI.List("Intérieur", AppartementList, PosInLabelAppart,nil, {},true, function(Hovered, Active, Selected, Index)
                              PosInLabelAppart = Index
                              if Active and oldIndex ~= Index then
                                DestroyCam(createdCamera, 0)
                                RenderScriptCams(0, 0, 1, 1, 1)
                                createdCamera = 0
                                ClearTimecycleModifier("scanline_cam_cheap")
                                SetFocusEntity(GetPlayerPed(PlayerId()))
                                oldIndex = Index
                                m = CoordsCamList[Index]
                                c = m.coords
                                r = m.r
                                
                                local int = GetInteriorAtCoords(
                                  c.x , 
                                  c.y , 
                                  c.z 
                                )
                                LoadInterior(int)
                                while not IsInteriorReady(int) do
                                  Wait(1)
                                end
                                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 2)
                                SetCamCoord(cam,c.x,c.y,c.z)
                                SetCamRot(cam, r.x,r.y,r.z, 1)
                                SetFocusArea(c.x,c.y,c.z,c.x,c.y,c.z)
                                RenderScriptCams(1, 0, 0, 1, 1)
                                createdCamera = cam
                              elseif not Active then
                                DestroyCam(createdCamera, 0)
                                RenderScriptCams(0, 0, 1, 1, 1)
                                createdCamera = 0
                                ClearTimecycleModifier("scanline_cam_cheap")
                                SetFocusEntity(GetPlayerPed(PlayerId()))
                              end
                            end)
                            RageUI.Button("Prix", nil, {
                              RightLabel = price
                              }, true, function(Hovered, Active, Selected)
                                if Selected then
                                  amount = KeyboardInput("Entrez le prix de la propriété", nil, 25)
                                  if tonumber(amount) ~= nil then
                                    priceAm = amount
                                    price = amount .. "$"
                    
                                  end
                                end 
                            end)
                            if price ~= nil then
                              RageUI.Button("Prix de la location", "Chaque semaine le client devra payer " .. math.floor(priceAm/40) .. "$", {
                                RightLabel =math.floor(priceAm/40) .. "$"
                                }, true, function(Hovered, Active, Selected)
                                  if Selected then
                                  end 
                              end)
                    
                              RageUI.Button("Enregistrer la propriété",nil, {
                                }, true, function(Hovered, Active, Selected)
                                  if Selected then
                                    if numberOfHouse ~= nil then
                                      appartement = {index=PosInLabelAppart,price=priceAm,priceloc=math.floor(priceAm/10),max=WeightOfPos,name=realstreetname .. " " .. numberOfHouse,entry=json.encode(PosOfMarker)}
                                      TriggerServerEvent("core:NewAppartDuSexe", appartement)
                                    else
                                      ShowNotification("~r~Vous avez oubliez le numéro de la maison")
                                    end
                                  end 
                              end)
                            end
                        end
                    end, function()
                    end)
                end
            end
        end)
    end
end)