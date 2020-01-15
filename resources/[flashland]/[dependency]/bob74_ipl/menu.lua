local updateShowcaseData = {
    count = 1;
}

Citizen.CreateThread(function()

    local mainMenu = RageUI.CreateMenu("IplEditor", "Availables IPL")


    mainMenu.EnableMouse = false;

    local updateShowcase = RageUI.CreateSubMenu(mainMenu, "", "Availables styles")
    updateShowcase.EnableMouse = false;

    while true do
        Citizen.Wait(1)

        if IsControlJustPressed(1, 51) then
            RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
        end

        if RageUI.Visible(mainMenu) then

            RageUI.DrawContent({ header = true, instructionalButton = true }, function()

                RageUI.Button("Franklin's Aunt", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        updateShowcase:SetTitle("Franklin's Aunt")
                        FranklinAunt.Style.Clear()
                    end
                end, updateShowcase)

            end, function()
                ---Panels
            end)
        end
        if RageUI.Visible(updateShowcase) then
            RageUI.DrawContent({ header = true, instructionalButton = true }, function()

            end, function()
                ---Panels
            end)

        end
    end

end)
