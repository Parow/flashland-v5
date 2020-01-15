---GridPanel
---@param X number
---@param Y number
---@param TopText string
---@param BottomText string
---@param LeftText string
---@param RightText string
---@param Callback table
---@return table
---@public
function RageUI.GridPanel(X, Y, TopText, BottomText, LeftText, RightText, Callback)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then

            ---@type boolean
            local Hovered = RageUI.IsMouseInBounds(CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20, RageUI.Settings.Panels.Grid.Grid.Width + CurrentMenu.WidthOffset - 40, RageUI.Settings.Panels.Grid.Grid.Height - 40)

            ---@type boolean
            local Selected = false

            ---@type number
            local CircleX = CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20

            ---@type number
            local CircleY = CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20

            if X < 0.0 or X > 1.0 then
                X = 0.0
            end

            if Y < 0.0 or Y > 1.0 then
                Y = 0.0
            end

            CircleX = CircleX + ((RageUI.Settings.Panels.Grid.Grid.Width - 40) * X) - (RageUI.Settings.Panels.Grid.Circle.Width / 2)
            CircleY = CircleY + ((RageUI.Settings.Panels.Grid.Grid.Height - 40) * Y) - (RageUI.Settings.Panels.Grid.Circle.Height / 2)

            RenderSprite(RageUI.Settings.Panels.Grid.Background.Dictionary, RageUI.Settings.Panels.Grid.Background.Texture, CurrentMenu.X, CurrentMenu.Y + RageUI.Settings.Panels.Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Grid.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Panels.Grid.Background.Height)
            RenderSprite(RageUI.Settings.Panels.Grid.Grid.Dictionary, RageUI.Settings.Panels.Grid.Grid.Texture, CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Grid.Grid.Width, RageUI.Settings.Panels.Grid.Grid.Height)
            RenderSprite(RageUI.Settings.Panels.Grid.Circle.Dictionary, RageUI.Settings.Panels.Grid.Circle.Texture, CircleX, CircleY, RageUI.Settings.Panels.Grid.Circle.Width, RageUI.Settings.Panels.Grid.Circle.Height)

            RenderText(TopText or "", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            RenderText(BottomText or "", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            RenderText(LeftText or "", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            RenderText(RightText or "", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Right.Scale, 245, 245, 245, 255, 1)

            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true

                    CircleX = math.round(GetControlNormal(0, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (RageUI.Settings.Panels.Grid.Circle.Width / 2)
                    CircleY = math.round(GetControlNormal(0, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (RageUI.Settings.Panels.Grid.Circle.Height / 2)

                    if CircleX > (CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + RageUI.Settings.Panels.Grid.Grid.Width - 40) then
                        CircleX = CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + RageUI.Settings.Panels.Grid.Grid.Width - 40
                    elseif CircleX < (CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + 20 - (RageUI.Settings.Panels.Grid.Circle.Width / 2)) then
                        CircleX = CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + 20 - (RageUI.Settings.Panels.Grid.Circle.Width / 2)
                    end

                    if CircleY > (CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + RageUI.Settings.Panels.Grid.Grid.Height - 40) then
                        CircleY = CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + RageUI.Settings.Panels.Grid.Grid.Height - 40
                    elseif CircleY < (CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (RageUI.Settings.Panels.Grid.Circle.Height / 2)) then
                        CircleY = CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (RageUI.Settings.Panels.Grid.Circle.Height / 2)
                    end

                    X = math.round((CircleX - (CurrentMenu.X + RageUI.Settings.Panels.Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20) + (RageUI.Settings.Panels.Grid.Circle.Width / 2)) / (RageUI.Settings.Panels.Grid.Grid.Width - 40), 2)
                    Y = math.round((CircleY - (CurrentMenu.Y + RageUI.Settings.Panels.Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20) + (RageUI.Settings.Panels.Grid.Circle.Height / 2)) / (RageUI.Settings.Panels.Grid.Grid.Height - 40), 2)

                    if X > 1.0 then
                        X = 1.0
                    end
                    if Y > 1.0 then
                        Y = 1.0
                    end
                end
            end
            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Panels.Grid.Background.Height + RageUI.Settings.Panels.Grid.Background.Y
            if Hovered and Selected then
                RageUI.PlaySound(RageUI.Settings.Audio.Library, RageUI.Settings.Audio.Slider, true)
            end
            Callback(Hovered, Selected, X, Y)
        end
    end
end
