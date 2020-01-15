local KeyList = {
    ["F5"] = "Ouverture/fermeture du menu personnel",
    ["G"] = "Ouverture/fermeture coffre véhicule",
    ["Y"] = "Ouverture/fermeture véhicule (verrouillage)",
    ["K"] = "Fouiller un joueur",
    ["G"] = "Action joueur",
}
local function chatMessage(msg)
    TriggerEvent("chatMessage", "^3Flash^2Land", {0,255,0}, msg)
end


RegisterCommand("help", function()
    local helpText = ""
    for k , v in pairs(KeyList) do
        helpText = helpText .. "\n ^1[^3" ..k.. "^1]^0 " .. v 
    end
    chatMessage(helpText)
end)

