local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')

local PlaceEvent = ReplicatedStorage.Events:WaitForChild('Place')
local DeleteEvent = ReplicatedStorage.Events:WaitForChild('Delete')

local player = game:GetService('Players').LocalPlayer
local mouse = player:GetMouse()

local function OnMouseClick()
	if mouse.Target == nil then return end	-- there is no mouse target, player has clicked on nothing

	local plrMap
	for _, map in ipairs(workspace.Maps:GetChildren()) do if map:GetAttribute('UserId') == player.UserId then plrMap = map break end end
	local tileMap = workspace.TileFolder[plrMap.Name]
	local PlacedItems = workspace.PlacedItemsFolder:FindFirstChild(player.UserId)
	local target = mouse.Target

	if target.Parent:IsA('Model') then target = target.Parent end

	if player:GetAttribute('Delete') then DeleteEvent:FireServer(target)
	else PlaceEvent:FireServer(target) end	-- target could be either a tile or an item
end

-- connect dragging + mouse click
mouse.Move:Connect(function()

	if not UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then return end

	OnMouseClick()
end)

-- connect mouse click
mouse.Button1Down:Connect(OnMouseClick)

player.AttributeChanged:Connect(function(attr: string)
	if attr == 'CurrentItem' then

		if player:GetAttribute(attr) ~= '' then player:SetAttribute('Delete', false) end

		for _, button in ipairs(player.PlayerGui.Inventory.ItemContainer:GetChildren()) do

			if button:IsA('TextButton') then

				button.TextColor3 = Color3.fromHex('#d6d6d6')	-- this color is the standard text color for unselected buttons
				if button.Text == player:GetAttribute(attr) then button.TextColor3 = Color3.fromRGB(0, 170, 127) end		-- this color is the color of the selected item button
			end
		end
	end
end)

