local ToggleEvent = game:GetService('ReplicatedStorage').Events:WaitForChild('ToggleDelete')

script.Parent.InventoryGui.Main.ToggleDelete.MouseButton1Down:Connect(function()
	
	local plr = game.Players.LocalPlayer
	
	ToggleEvent:FireServer(plr, plr.leaderstats.delete.Value)
end)