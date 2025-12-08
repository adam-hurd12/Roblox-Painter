local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ServerScriptService = game:GetService('ServerScriptService')

local Item = require(ServerScriptService:WaitForChild('ItemModule'))

local Events = ReplicatedStorage:WaitForChild('Events')
local DeleteEvent = Events.Delete
local SelectEvent = Events.Select
local PlaceEvent = Events.Place


DeleteEvent.OnServerEvent:Connect(Item.DeleteItem)
SelectEvent.OnServerEvent:Connect(Item.SelectItem)
PlaceEvent.OnServerEvent:Connect(Item.PlaceItem)