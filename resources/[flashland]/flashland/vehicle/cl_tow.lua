
function EnterZoneTow()
	Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir la fourrière")
	KeySettings:Add("keyboard","E",OpenTow,"tow")
	KeySettings:Add("controller",46,OpenTow,"tow")
	
end

function ExitZoneTow()
	Hint:RemoveAll()
	KeySettings:Clear("keyboard","E","tow")
	KeySettings:Clear("controller","E","tow")
	RageUI.Visible(RMenu:Get('jobs',"tow"),false)

end


