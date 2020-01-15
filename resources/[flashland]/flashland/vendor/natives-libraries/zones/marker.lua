Marker = setmetatable({}, Marker)
Marker.Data = {}

function Marker:Add(Pos,Data)
    table.insert( self.Data, {pos=Pos,data=Data})
end
function Marker:Visible(Pos,Visible)
	for i = 1 , #self.Data,1 do
		if self.Data[i].pos == Pos then
			self.Data[i].data.visible = Visible
			break
		end
	end
end
function Marker:Remove(Pos)
	for i = 1 , #self.Data , 1 do
		if self.Data[i].pos == Pos then
			table.remove(self.Data ,i)
			break
		end
	end
end
Citizen.CreateThread(function()
	while true do
		Wait(1)
		for i = 1 ,#Marker.Data , 1 do
			local o = Marker.Data[i]
			if o.data.visible then
				DrawMarker(o.data.type, o.pos.x, o.pos.y, o.pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, o.data.scale.x, o.data.scale.y, o.data.scale.z, o.data.color.r, o.data.color.g, o.data.color.b, o.data.color.a, o.data.Up, o.data.Cam, nil, o.data.Rotate, nil, nil, nil)
			end
		end
	end
end)