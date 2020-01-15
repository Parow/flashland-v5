Blips = setmetatable({}, Blips)
Blips.Data = {}


function Blips:AddBlip(blip,category,stats)
    if self.Data[category] == nil then
        self.Data[category] = {}
    end

    table.insert( self.Data[category], {blip=blip,stats=stats,isShow=true} )
end