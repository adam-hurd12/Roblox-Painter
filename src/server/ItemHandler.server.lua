local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')

local mod = require(ServerScriptService:WaitForChild('ItemModule'))

local events = ReplicatedStorage.Events
local SelectEvent = events:WaitForChild('SelectItem')
local SpawnEvent = events:WaitForChild('SpawnItem')
local DeleteEvent = events:WaitForChild('DeleteItem')
local ToggleEvent = events:WaitForChild('ToggleDelete')
local ToggleClient = events:WaitForChild('ToggleClient')

SelectEvent.OnServerEvent:Connect(function(plr, item, name)
	
	mod.SelectItem(plr, item, name)
	
end)

SpawnEvent.OnServerEvent:Connect(function(plr, mapPiece)
	
	mod.SpawnItem(plr, mapPiece)
	
end)

DeleteEvent.OnServerEvent:Connect(function(plr, mapPiece)
	
	mod.DeleteItem(plr, mapPiece)
	
end)

ToggleEvent.OnServerEvent:Connect(function(plr, val)
	
	ToggleClient:FireClient(plr, val)
	
end)