local player = game:GetService('Players').LocalPlayer
local mouse = player:GetMouse()

local InventoryUI = player.PlayerGui.Inventory
local Button = script.Parent

local debounce = false

local onIcon = 'http://www.roblox.com/asset/?id=68009966'
local offIcon = ''


function Toggle()
end

Button.MouseButton1Down:Connect(function()
	player:SetAttribute('Delete', not player:GetAttribute('Delete'))
	player:SetAttribute('CurrentItem', '')
end)

player.AttributeChanged:Connect(function(attr)
	if attr == 'Delete' then
		debounce = not debounce

		if debounce then 
			Button.TextColor3 = Color3.fromRGB(255,50,70)
			mouse.Icon = onIcon 
		else 
			Button.TextColor3 = Color3.fromHex('#d6d6d6')
			mouse.Icon = offIcon 
		end

		player:SetAttribute('Delete', debounce)
	end
end)