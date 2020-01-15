Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}




KeySettings = setmetatable({keyboard= {},controller={}}, KeySettings)

function KeySettings:Add(Type,Key,Fct,Name)

    if self[Type][Key] == nil then
        self[Type][Key] = {}
    end

    table.insert(self[Type][Key],{fct=Fct,name=Name,canPress =true})
    
end
function KeySettings:Clear(Type,Key,Name)
    -- if self[Type][Name][Key] ~= nil then
    --     self[Type][Name][Key] = nil
    -- end

    for _k,v in pairs(KeySettings.keyboard) do
        if _k == Key then
            for i = 1 ,#v,1 do

                if v[i].name == Name then
                    table.remove(self[Type][Key],i)
                    break
                    break
                end
            end
        end

    end

end
Citizen.CreateThread(function()
    while true do
        Wait(0)
        FreezePlayer(PlayerId(),false)
        if KeySettings.keyboard ~= nil then
            for _k,v in pairs(KeySettings.keyboard) do
                if GetLastInputMethod(0) then
                    
                    if  IsControlJustPressed(0, Keys[_k]) then

                        for i = 1 ,#v,1 do
                            if v[i].canPress then
                                v[i].fct(v.name)
                            end
                        end
                        Wait(400)
                    end
                end
            end
        end
        if KeySettings.controller ~= nil then
            for _k,v in pairs(KeySettings.controller) do
                if GetLastInputMethod(0) then
                    
                    if  IsControlJustPressed(0, Keys[_k]) then

                        for i = 1 ,#v,1 do
                            if v[i].canPress then
                                v[i].fct(v.name)
                            end
                        end
                        Wait(400)
                    end
                end
            end
        end
    end
end)
