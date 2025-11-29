local ReplicatedStorage = game:GetService('ReplicatedStorage')

local ToggleDeleteEvent = ReplicatedStorage.Events:WaitForChild('ToggleClient')
local DeleteEvent = ReplicatedStorage.Events:WaitForChild('DeleteItem')

local plr = game.Players.LocalPlayer

local stats = plr:WaitForChild('leaderstats')
local delete = stats.delete
local item = stats.item
local name = stats.name

local mouse = plr:GetMouse()

ToggleDeleteEvent.OnClientEvent:Connect(function(val)

	local container = plr.PlayerGui.InventoryGui.Main.ItemContainer
	local button = container.Parent.ToggleDelete
	
	delete.Value = not delete.Value
	
	if delete.Value then 
		button.Text = "press to stop deleting" 
		button.TextStrokeTransparency = 0.78
		mouse.Icon = "http://www.roblox.com/asset/?id=68009966"
		
		if name.Value ~= "" then
			container:FindFirstChild(name.Value).BackgroundColor3 = Color3.fromRGB(175, 176, 255)
		end
		
		item.Value = 0
		name.Value = ""
	else 
		button.Text = "press to delete stuff"
		button.TextStrokeTransparency = 1 
		mouse.Icon = ""
	end


	
end)


mouse.Button1Down:Connect(function()

	if mouse.Target == nil then return end	-- there is no mouse target, player has clicked on nothing
	
	local plrMap = workspace.Maps[plr.UserId]
	local target = mouse.Target
	
	if target.Parent == plrMap and target:IsA('Part') then	-- the target is a map piece and parented to the players map folder 

		if target:GetAttribute('item') == nil or target:GetAttribute('plr') ~= plr.UserId or not delete.Value then return end	-- the map piece has no item or the player is not deleting

		DeleteEvent:FireServer(target)

	end

end)