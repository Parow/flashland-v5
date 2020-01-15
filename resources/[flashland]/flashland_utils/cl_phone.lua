
local OBJ = {"p_phonebox_02_s","p_phonebox_01b_s","prop_phonebox_04","prop_phonebox_03","prop_phonebox_01a","prop_phonebox_01b","prop_phonebox_01c"}


local inAnim = "cellphone_text_in"
local outAnim = "cellphone_text_out"
local outInCallAnim = "cellphone_call_out"
local callAnim = "cellphone_call_listen_base"
local idleAnim = "cellphone_text_read_base"

local phoneProp = 0
local phoneModel = "prop_npc_phone_02"

function ePhoneCallAnim()
	if IsPlayerDead(PlayerId()) then
		return
	end
	local dict = "cellphone@"

	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	StopAnimTask(GetPlayerPed(-1), "cellphone@", inAnim, 1.0)
	TaskPlayAnim(GetPlayerPed(-1), dict, callAnim, 3.0, -1, -1, 50, 0, false, false, false)
end

function IsNearATM()
    local objects = {}
    
    for i=1,#OBJ,1 do
      table.insert(objects, OBJ[i])
    end
  
    local ped = GetPlayerPed(-1)
    local list = {}
  
    for _,v in pairs(objects) do
        
        local obj = GetClosestObjectOfType(GetEntityCoords(ped).x, GetEntityCoords(ped).y, GetEntityCoords(ped).z, 5.0, GetHashKey(v), false, true ,true)
        local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(obj), true)
        table.insert(list, {object = obj, distance = dist})
    end
  
      local closest = list[1]
      for _,v in pairs(list) do
       -- --(v)
        if v.distance < closest.distance then
          closest = v
        end
      end
  
      local distance = closest.distance
      local object = closest.object
      
  
      if distance < 1.8 then
        
        return true
      end
  end
local CurrentCall = nil
  RegisterNetEvent("parow:CurrentCall")
  AddEventHandler("parow:CurrentCall", function(s)
    CurrentCall = s
  end)
  

local inCall = false
RegisterNetEvent("parow:ValidCall")
AddEventHandler("parow:ValidCall", function()
    inCall = true
    TriggerEvent("parow:shownotif","~r~G ~s~pour arrêter l'appel." ,6) 
    TriggerEvent("parow:shownotif","Appel en cours..." ,26) 


    ePhoneCallAnim()
end)
RegisterNetEvent("parow:acceptcall")
AddEventHandler("parow:acceptcall", function()
    
    TriggerEvent("parow:shownotif","L'individu à répondu" ,26) 
end)

RegisterNetEvent("parow:rejectcall")
AddEventHandler("parow:rejectcall", function()
    inCall = false
    TriggerEvent("parow:shownotif","L'individu à racroché" ,6) 
end)
local Near = false
Citizen.CreateThread(function()
	
	while true do
          Wait(2000)
          if IsNearATM() then
            Near   = true
          else

            Near = false
          end

	end
end)
  Citizen.CreateThread(function()
	
	while true do
          Wait(0)
          if Near == true then
              SetTextComponentFormat("STRING")
             AddTextComponentString("~INPUT_CONTEXT~ pour commencer un appel")
             DisplayHelpTextFromStringLabel(0, 0, 0, -1)
          end

            if IsControlJustReleased(0,38) and IsNearATM() and inCall == false then

                numb = GetNumber("Numéro")
                numb = tonumber(numb)
                
                if numb ~= nil then
                    
                    TriggerServerEvent("gcphone:AnonstartCall",numb)
                    --inCall = true
                end
                
            end
            if inCall == true then
               if not IsNearATM() or IsControlJustReleased(0,47)  then
                    ClearPedTasks(GetPlayerPed(-1))
                    inCall = false
                    TriggerEvent("parow:shownotif","Appel terminé" ,26) 
                    TriggerServerEvent('gcphone:rejectCall', CurrentCall)
                    TriggerEvent("parow:rejectcallstop")
               end
            end
	    
	end
end)
function GetNumber(txt)
    AddTextEntry('FMMC_MPM_NA', txt)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 39)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
        local result = GetOnscreenKeyboardResult()
        return result
    end

end