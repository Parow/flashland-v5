Jobs = {
    chomeur = {
        label = "👤 Citoyen",
        grade = {
            {
                label = "",
                salary = 20
            },
        }
    },

    oneil = {
        label = "Ferme O'neil",
        label2 = "Ferme o'neil",
        FreeAccess = false,
        grade = {
            {
                label = "Fermier",
                salary = 20,
                name = "worker"
            },
            {
                label = "Gérant",
                salary = 20,
                name = "gerant"
            },
            {
                label = "Patron",
                salary = 20,
                name = "boss"
            }
        },
        requiredService = false,
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=2201.97,y=5179.28,z=58.35},
                giveitem = "blez",
                blipcolor =7,
                blipname = "Récolte du blé",
                add = "~p~+ 1 Blé",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement du blé",
                Pos =  {x=2309.5,y=4885.85,z=41.81},
                required = "blez",
                giveitem = "farine",
                add = "~p~+ 1  Bouteille de vin"
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement de la farine",
                Pos =  {x=2680.62,y=3508.35,z=53.3},
                required = "farine",
                giveitem = "pain",
                add = "~p~+ 1  Pain"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=83.14,y=-1551.22,z=29.6},
                required = "pain",
                price = math.random( 5,7 ),
                add = "~p~- 1 Pain"
            },
        }
    },
    vigneron = {
        label = "🍇 Vigneron",
        label2 = "Vigneron",
        FreeAccess = true,
        grade = {
            {
                label = "CDD",
                salary = 20,
                name = "cdd"
            },
            {
                label = "CDI",
                salary = 20,
                name = "cdi"
            },
            {
                label = "Patron",
                salary = 20,
                name = "boss"
            }
        },
        Menu = {
            menu = {
                title = "Vigneron",
                subtitle = "Actions disponibles",
                name = "vigneron_menuperso"
            },
            buttons = {
                {label="Facturation",onSelected=function() CreateFacture("vigneron") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        garage = {
            Name = "Garage vigneron",
            Pos =  {x = -1887.76,  y = 2045.01,  z =140.86}, 
            Properties = {
                type = 1,-- = garage self service = illimité
                vehicles = {
                    {name="bison",label="Voiture de service",tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {x = -1895.71,  y = 2034.61,  z =141.86,h=339.66}, 

            },
            Blipdata = {
                Pos = {x = -1887.76,  y = 2045.01,  z =140.86}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
        requiredService = false,
    
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=-1812.54,y=2206.83,z=92.37},
                giveitem = "raisin",
                blipcolor =7,
                blipname = "Récolte",
                add = "~p~+ 1 Raisin",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement raisin",
                Pos = {x=-52.83,y=1903.4,z=195.36},
                required = "raisin",
                giveitem = "jus_raisin",
                add = "~p~+ 1  Jus de raisin"
            },
            
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement jus de raisin",
                Pos = {x=-1929.02,y=1779.09,z=173.07},
                required = "jus_raisin",
                giveitem = "bouteille_vin",
                add = "~p~+ 1  Bouteille de vin"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=51.59,y=6486.16,z=31.36},
                required = "bouteille_vin",
                price = math.random( 5,7 ),
                add = "~p~- 1 Bouteille de vin"
            },
        }
    },
    raffinerie = {
        label = "Rafinerie",
        label2 = "Rafinerie",
        FreeAccess = false,
        grade = {
            {
                label = "Raffineur",
                salary = 20,
                name = "cdd"
            },
            {
                label = "Responsable de prod",
                salary = 20,
                name = "cdi"
            },
            {
                label = "Patron",
                salary = 20,
                name = "boss"
            }
        },
        Menu = {
            menu = {
                title = "Raffinerie",
                subtitle = "Actions disponibles",
                name = "Raffinerie_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("raffinerie") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        requiredService = false,
    
        work = {

            recolte = {
                type = "recolte",
                workSize = 10.0,
                Pos = {x=1343.01,y=-2113.07,z=54.85},
                giveitem = "petrol",
                blipcolor =7,
                blipname = "Récolte",
                add = "~p~+ 1 Pétrole",
                anim = {
      
                    lib = "anim@mp_snowball",
                    anim = "pickup_snowball"
            
                },
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement pétrole",
                Pos = {x=270.72,y=-3056.22,z=5.83},
                required = "petrol",
                giveitem = "petrol_melanged",
                add = "~p~+ 1  Mélange pétrole"
            },
            
            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =7,
                blipname = "Traitement mélange pétrole",
                Pos = {x=2760.85,y=1486.87,z=30.79},
                required = "petrol_melanged",
                giveitem = "petrol_rafined",
                add = "~p~+ 1  Pétrole raffiné"
            },
            vente = {
                type = "vente",
                blipcolor =7,
                workSize = 10.45,
                blipname = "Vente",
                Pos = {x=51.59,y=6486.16,z=31.36},
                required = "petrol_rafined",
                price = math.random( 5,7 ),
                add = "~p~- 1 Pétrole raffiné"
            },
        }
    },
    police = {  
        label = "👮🏼 LSPD",
        label2 = "LSPD",
        grade = {
            {
                label = "Cadet",
                salary = 60,
                name = "cadet"
            },
            {
                label = "Officier",
                salary = 70,
                name = "officier"
            },
            {
                label = "Sergent",
                salary = 80,
                name = "sergent"
            },
            {
                label = "Sergent-Chef",
                salary = 95,
                name = "sergent-Chef"
            },
            {
                label = "Lieutenant",
                salary = 105,
                name = "drh"
            },
            {
                label = "Capitaine",
                salary = 115,
                name = "boss"
            }
        },
        Menu = {
            menu = {
                title = "Police",
                subtitle = "Actions disponibles",
                name = "police_menuperso"
            },
            submenus = {
                ["Actions citoyen"] = {
                    submenu ="police_menuperso",
                    title = "Actions citoyen",
                    menus = {
                        buttons = {
                            {label="Menotter",onSelected=function() Police.HandcuffPly() end,ActiveFct= function() HoverPlayer() end},
                            {label="Démenotter",onSelected=function() Police.CutMenottes() end,ActiveFct= function() HoverPlayer() end},
                            {label="Retrait points permis",onSelected=function() Police.RetraitPermis() end},
                        },
                        submenus = {}
                    }

                },
                ["Actions véhicule"] = {
                    submenu ="police_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {label="Inspecter la plaque",onSelected=function() Police.PlateCheck() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Crocheter",onSelected=function() Police.Crocheter() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Immobiliser",onSelected=function() Police.Immobiliser() end,ActiveFct= function() Mecano.ShowMarker() end},
                            
                        },
                        submenus = {}
                    }

                },
            },
            buttons = {
                {label="Amendes",onSelected=function() CreateFacture("police") end,ActiveFct=function() HoverPlayer() end},
                {label="Supprimer herse",onSelected=function() DeleteHerse() end},
            },
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=450.05,y=-993.16,z=30.69},
                
                Tenues = {
                    ['Tenue de service'] = {
                        male = {
                            ['tshirt_1'] = 53, ['tshirt_2'] = 0,
                            ['torso_1'] = 149, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 19,
                            ['pants_1'] = 25, ['pants_2'] = 3,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 27, ['tshirt_2'] = 0,
                            ['torso_1'] = 146, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 31,
                            ['pants_1'] = 34, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ["Tenue manches longues"] = {
                        male = {
                            ['tshirt_1'] = 53, ['tshirt_2'] = 0,
                            ['torso_1'] = 52, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 25, ['pants_2'] = 3,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 0, ['tshirt_2'] = 0,
                            ['torso_1'] = 0, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 0,
                            ['pants_1'] = 0, ['pants_2'] = 0,
                            ['shoes_1'] = 0, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue cérémonie'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 220, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 77,
                            ['pants_1'] = 25, ['pants_2'] = 3,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 46, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 1,
                            ['torso_1'] = 225, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 88,
                            ['pants_1'] = 34, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 45, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue K9'] = {
                        male = {
                            ['tshirt_1'] = 53, ['tshirt_2'] = 0,
                            ['torso_1'] = 102, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 19,
                            ['pants_1'] = 52, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 46, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 2, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 27, ['tshirt_2'] = 0,
                            ['torso_1'] = 93, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 31,
                            ['pants_1'] = 54, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ['Tenue enquêteur'] = {
                        male = {
                            ['tshirt_1'] = 0, ['tshirt_2'] = 2,
                            ['torso_1'] = 35, ['torso_2'] = 1,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 49, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 51, ['tshirt_2'] = 1,
                            ['torso_1'] = 168, ['torso_2'] = 1,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 23,
                            ['pants_1'] = 51, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
                    ["Tenue d'intervention"] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 49, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 31, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 1,
                            ['torso_1'] = 42, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 18,
                            ['pants_1'] = 30, ['pants_2'] = 1,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                    },
            
                }
            },
        },
    },
    banker = {
        label = "💰  Banquier",
        grade = {
            {
                label = "Employé",
                salary = 20,
                name = "employe",
                show = true
            },
            {
                label = "Trésorier",
                salary = 20,
                name = "tresorier",
                show = true
            },
            {
                label = "DRH",
                salary = 20,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 20,
                name = "pdg",
                show = true                
            }
        },
        Menu = {
            menu = {
                title = "Banquier",
                subtitle = "Actions disponibles",
                name = "Banquier_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("banker") end,ActiveFct=function() HoverPlayer() end},
            },
        },
    },
    gouv = {
        label = "Gouvernement",
        label2 = "Gouvernement",
        grade = {
            {
                label = "Assistant",
                salary = 20,
                name = "Assistant",
                show = true
            },
            {
                label = "Secrétaire",
                salary = 20,
                name = "secretaire",
                show = true
            },
            {
                label = "Président",
                salary = 20,
                name = "boss",
                show = true
            },
        },
        CustomMenu = true,
        Storage = {
            {
                Pos = {x=-43.38,y=-1748.37,z=29.42},
                Limit = 500,
                Name = "coffre"
            },
        },

        garage = {
            Name = "Garage gouvernement",
            Pos =  {}, 
            Properties = {
                type = 1,-- = garage self service 
                Limit = 50,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {}, 

            },
            Blipdata = {
                Pos = {}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
    },



    darnell = {     
        label = "💼 Ponsonby's",
        grade = {
            {
                label = "Employé",
                salary = 20,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 20,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 20,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 20,
                name = "pdg",
                show = true            
            }
        },
        extraPos = { 
            Manequin = {
                Pos = {
                    {x=-168.4,y=-298.3,z=39.79},
                },
            }
        }
    },

    lsms = {    
        label = "💉 LSMS",
        grade = {
            {
                label = "Infirmier",
                salary = 60,
                name = "infirmier",
                show = true            
            },
            {
                label = "Médecin",
                salary = 70,
                name = "medecin",
                show = true
            },
            {
                label = "Médecin-chef",
                salary = 80,
                name = "medecinchef",
                show = true
            }, 

            {
                label = "Directeur adjoint",
                salary = 95,
                name = "drh",
                show = true                
            },
            {
                label = "Directeur",
                salary = 110,
                name = "pdg",
                show = true               
            },
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=336.25,y=-579.53,z=28.79},
                Tenues = {
                    ['Tenue de services'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 250, ['torso_2'] = 0,
                            ['decals_1'] = 58, ['decals_2'] = 0,
                            ['arms'] = 85,
                            ['pants_1'] = 96, ['pants_2'] = 0,
                            ['shoes_1'] = 69, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 126, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 58, ['tshirt_2'] = 0,
                            ['torso_1'] = 258, ['torso_2'] = 0,
                            ['decals_1'] = 66, ['decals_2'] = 0,
                            ['arms'] = 109,
                            ['pants_1'] = 99, ['pants_2'] = 0,
                            ['shoes_1'] = 72, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 96, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0,
                        }
                    }
                }
            },
        },
    },

    mecano = {     
        label = "🔧 Mécano",
        grade = {
            {
                label = "Employé",
                salary = 20,
                name = "employe",
                show = true               
            },
            {
                label = "Trésorier",
                salary = 20,
                name = "tresorier",
                show = true              
            },
            {
                label = "DRH",
                salary = 20,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 20,
                name = "pdg",
                show = true           
            }
        },
        Menu = {
            menu = {
                title = "Mécano",
                subtitle = "Actions disponibles",
                name = "mecano_menuperso"
            },
            submenus = {
                ["Actions véhicule"] = {
                    submenu ="mecano_menuperso",
                    title = "Actions véhicule",
                    menus = {
                        buttons = {
                            {label="Inspecter l'état du véhicule",onSelected=function() Mecano.CheckVehicle() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Ouvrir le capot",onSelected=function() Mecano.OpenTrunk() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Réparer le véhicule",onSelected=function() Mecano.Repair() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Nettoyer le véhicule",onSelected=function() Mecano.CleanVehicule() end,ActiveFct= function() Mecano.ShowMarker() end},
                            {label="Fourière",onSelected=function() Mecano.Fouriere() end,ActiveFct= function() Mecano.ShowMarker() end},

                        },
                        submenus = {}
                    }

                },

            },
            buttons = {
                {label="Facturation",onSelected=function() CreateFacture("mecano") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Extrapos = {
            Tow = { -- fourrière
                Pos = {
                    {x=-41.63,y=-1683.18,z=29.43}
                },
                Enter = EnterZoneTow,
                Exit = ExitZoneTow,
                zonesize = 1.5,
                Blips = {
                    sprite = 473,
                    color = 81,
                    name = "Fourrière",
                },
                Marker = {
                    type = 1,
                    scale = {x=1.5,y=1.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        stockages = {
            coffremechanics1 = { -- fourrière
                Pos = {
                    {x=-46.52,y=-1682.81,z=29.43}
                },
                zonesize = 1.5,
                maxWeight = 15,
                Marker = {
                    type = 1,
                    scale = {x=1.5,y=1.5,z=0.2},
                    color = {r=255,g=255,b=255,a=120},
                    Up = false,
                    Cam = false,
                    Rotate = false,
                    visible = true
                }
            }
        },
        work = {
            vestiaire = {
                type = "Vestiaire",
                workSize = 1.45,
                Pos = {x=958.76,y=-3005.28,z=-39.64},
                Tenues = {
                    ['Tenue de services'] = {
                        male = {
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 65, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 17,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        },
                        female = {
                            ['tshirt_1'] = 14, ['tshirt_2'] = 0,
                            ['torso_1'] = 59, ['torso_2'] = 0,
                            ['decals_1'] = 0, ['decals_2'] = 0,
                            ['arms'] = 18,
                            ['pants_1'] = 38, ['pants_2'] = 0,
                            ['shoes_1'] = 25, ['shoes_2'] = 0,
                            ['helmet_1'] = 0, ['helmet_2'] = 0,
                            ['chain_1'] = 0, ['chain_2'] = 0,
                            ['ears_1'] = 0, ['ears_2'] = 0
                        }
                    }
                }
            },
        },
    },
    ltd = {     
        label = "🍕 Épicier",
        grade = {
            {
                label = "Employé",
                salary = 40,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 40,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 40,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 40,
                name = "boss",
                show = true            
            }
        },
        garage = {
            Name = "Garage épicier",
            Pos =  {x = -40.92,  y = -1747.97,  z =29.33}, 
            Properties = {
                type = 1,-- = garage self service 
                Limit = 50,
                vehicles = {
                    {name="bison",label="Voiture de service",job=true,tuning = {
                        modXenon = true
                    }},     
                },
                spawnpos = {x = -38.99,  y = -1745.07,  z =29.33,h=224.97}, 

            },
            Blipdata = {
                Pos = {x = -40.92,  y = -1747.97,  z =29.33}, 
                Blipcolor  =7,
                Blipname = "Garage"
            }
        },
        Menu = {
            menu = {
                title = "LTD",
                subtitle = "Actions disponibles",
                name = "LTD_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("ltd") end,ActiveFct=function() HoverPlayer() end},
            },
        },
        Storage = {
            {
                Pos = {x=-43.38,y=-1748.37,z=29.42},
                Limit = 500,
                Name = "coffre"
            },
        },
        work = {

            traitement = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage batteries",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "batterypack",
                giveitem = "battery",
                add = "~b~+ 1  Batterie"
            },
            traitement2 = {
                type = "traitement",
                workSize = 10.45,
                blipcolor =51,
                blipname = "Déballage téléphones",
                Pos = {x=2919.98,y=4298.13,z=50.91},
                required = "telpack",
                giveitem = "tel",
                add = "~o~+ 1  Téléphone"
            },
        }
    },

    import = {     
        label = "🚛 Import Export",
        grade = {
            {
                label = "Employé",
                salary = 130,
                name = "employe",
                show = true                
            },
            {
                label = "Trésorier",
                salary = 130,
                name = "tresorier",
                show = true                
            },
            {
                label = "DRH",
                salary = 150,
                name = "drh",
                show = true
            },
            {
                label = "PDG",
                salary = 160,
                name = "pdg",
                show = true            
            }
        },
    },

    concess = {     
        label = "🚗 Concessionnaire",
        grade = {
            {
                label = "Employé",
                salary = 40,
                name = "employe",
                show = true                
            }
        },
        Menu = {
            menu = {
                title = "Concessionnaire",
                subtitle = "Actions disponibles",
                name = "Concessionnaire_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("concess") end,ActiveFct=function() HoverPlayer() end},
            },
        },
    },

    immo = {     
        label = "🏡 Agent Immobilier",
        grade = {
            {
                label = "Employé",
                salary = 40,
                name = "employe",
                show = true                
            }
        },
    },

    unicorn = {     
        label = "🍹 Unicorn",
        grade = {
            {
                label = "Employé",
                salary = 20,
                name = "employe",
                show = false              
            }
        },
    },

    fib = {     
        label = "🕵️ Agent Fédéral",
        grade = {
            {
                label = "Employé",
                salary = 100,
                name = "employe",
                show = false                
            }
        },
    },

    Taxi = {     
        label = "Taxi",
        label2 = "Taxi",
        grade = {
            {
                label = "Chaffeur",
                salary = 20,
                name = "employe",
                show = true              
            },
            {
                label = "Manager",
                salary = 20,
                name = "employe2",
                show = true              
            },
            {
                label = "Patron",
                salary = 20,
                name = "boss",
                show = true                
            },
        },
        Menu = {
            menu = {
                title = "Taxi",
                subtitle = "Actions disponibles",
                name = "taxi_menuperso"
            },

            buttons = {
                {label="Facture",onSelected=function() CreateFacture("taxi") end,ActiveFct=function() HoverPlayer() end},
            },
        },
    },

    bcso = {     
        label = "🚔 BCSO",
        grade = {
            {
                label = "Aspirant",
                salary = 80,
                name = "aspi",
            },
            {
                label = "Deputy",
                salary = 130,
                name = "deputy",
            },
            {
                label = "Deputy-Chef",
                salary = 130,
                name = "deputychef",
            },
            {
                label = "Chef De Division",
                salary = 130,
                name = "chefdivi",
            },
            {
                label = "Sherif Adjoint",
                salary = 150,
                name = "drh",
            },
            {
                label = "Sherif",
                salary = 160,
                name = "pdg",
            }
        },
    },
}
