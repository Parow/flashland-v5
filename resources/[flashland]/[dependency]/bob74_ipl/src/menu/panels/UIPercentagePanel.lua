
---PercentagePanel
---@param Percent number
---@param HeaderText string
---@param MinText string
---@param MaxText string
---@param Callback function
---@return nil
---@public
function RageUI.PercentagePanel(Percent, HeaderText, MinText, MaxText, Callback)
    if RageUI.CurrentMenu ~= nil then
        if RageUI.CurrentMenu() then

            ---@type boolean
            local Hovered = RageUI.IsMouseInBounds(RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + RageUI.CurrentMenu.SafeZoneSize.X, RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + RageUI.CurrentMenu.SafeZoneSize.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 4, RageUI.Settings.Panels.Percentage.Bar.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Panels.Percentage.Bar.Height + 8)

            ---@type boolean
            local Selected = false

            ---@type number
            local Progress = RageUI.Settings.Panels.Percentage.Bar.Width

            if Percent < 0.0 then
                Percent = 0.0
            elseif Percent > 1.0 then
                Percent = 1.0
            end

            Progress = Progress * Percent

            RenderSprite(RageUI.Settings.Panels.Percentage.Background.Dictionary, RageUI.Settings.Panels.Percentage.Background.Texture, RageUI.CurrentMenu.X, RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Background.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Percentage.Background.Width + RageUI.CurrentMenu.WidthOffset, RageUI.Settings.Panels.Percentage.Background.Height)
            RenderRectangle(RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Percentage.Bar.Width, RageUI.Settings.Panels.Percentage.Bar.Height, 87, 87, 87, 255)
            RenderRectangle(RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Progress, RageUI.Settings.Panels.Percentage.Bar.Height, 245, 245, 245, 255)

            RenderText(HeaderText or "Opacity", RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Middle.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Middle.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Middle.Scale, 245, 245, 245, 255, 1)
            RenderText(MinText or "0%", RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Left.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Left.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Left.Scale, 245, 245, 245, 255, 1)
            RenderText(MaxText or "100%", RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Right.X + (RageUI.CurrentMenu.WidthOffset / 2), RageUI.CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Right.Y + RageUI.CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Right.Scale, 245, 245, 245, 255, 1)

            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true

                    Progress = math.round(GetControlNormal(0, 239) * 1920) - RageUI.CurrentMenu.SafeZoneSize.X - (RageUI.CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (RageUI.CurrentMenu.WidthOffset / 2))

                    if Progress < 0 then
                        Progress = 0
                    elseif Progress > (RageUI.Settings.Panels.Percentage.Bar.Width) then
                        Progress = RageUI.Settings.Panels.Percentage.Bar.Width
                    end

                    Percent = math.round(Progress / RageUI.Settings.Panels.Percentage.Bar.Width, 2)
                end
            end

            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Panels.Percentage.Background.Height + RageUI.Settings.Panels.Percentage.Background.Y

            if Hovered and Selected then
                RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Slider, true)
            end

            Callback(Hovered, Selected, Percent)
        end
    end
end
