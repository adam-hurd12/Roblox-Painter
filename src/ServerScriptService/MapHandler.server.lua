local Map = require(game:GetService('ServerScriptService').MapModule)

local MapsFolder = workspace.Maps

for _, map in ipairs(MapsFolder:GetChildren()) do
	
	if map:IsA('Part') then Map.InitMap(map) end

end