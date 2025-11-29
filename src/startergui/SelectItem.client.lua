local ReplicatedStorage = game:GetService('ReplicatedStorage')

local plr = game:GetService('Players').LocalPlayer
local mouse = plr:GetMouse()

local events = ReplicatedStorage.Events
local SelectEvent = events:WaitForChild('SelectItem')
local ToggleDeleteEvent = events:WaitForChild('ToggleDelete')

local Main = plr.PlayerGui.InventoryGui.Main
local delButton = Main.ToggleDelete


for _, Button in ipairs(Main.ItemContainer:GetChildren()) do
	
	if Button:IsA('UIGridLayout') then continue end

	Button.MouseButton1Down:Connect(function()
		
		local stats = plr.leaderstats
		
		if stats.delete.Value then 
			ToggleDeleteEvent:FireServer(stats.delete.Value) 
		end

		Button.BackgroundColor3 = Color3.fromRGB(153, 128, 51)
		
		local prevItem = stats.name
		if prevItem.Value ~= '' then
			Button.Parent:FindFirstChild(prevItem.Value).BackgroundColor3 = Color3.fromRGB(175, 176, 255)
			if prevItem.Value == Button.Name then
				Button.BackgroundColor3 = Color3.fromRGB(175, 176, 255)
				stats.name.Value = ''
				stats.item.Value = 0
			end
		end
		
		SelectEvent:FireServer(Button.Name, Button.LayoutOrder)
		
	end)
	
end