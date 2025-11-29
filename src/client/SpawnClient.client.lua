local ReplicatedStorage = game:GetService("ReplicatedStorage")

local event = ReplicatedStorage.Events:WaitForChild("SpawnItem")

local plr = game:GetService("Players").LocalPlayer
local stats = plr:WaitForChild('leaderstats')
local item = stats.item
local name = stats.name
local mouse = plr:GetMouse()

mouse.Button1Down:Connect(function()
	
	if mouse.Target == nil then return end	-- there is no mouse target, player has clicked on nothing
	
	local plrMap = workspace.Maps[plr.UserId]
	local target = mouse.Target

	if target.Parent == plrMap and target:IsA('Part') then	-- the target is a map piece and parented to the players map folder 

		if target:GetAttribute("item") == nil and target:GetAttribute("plr") == plr.UserId and item.Value ~= 0 and name.Value ~= "" then

			event:FireServer(target)

		end

	end
	
end)