local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ItemsFolder = ReplicatedStorage:WaitForChild('Items')

local SelectEvent = ReplicatedStorage.Events.Select

local player = game:GetService('Players').LocalPlayer

local count = 0

local template = script.Template

wait()

for _, item in ipairs(ItemsFolder:GetChildren()) do
	
	if item:IsA('Model') then
		
		local new = template:Clone()
		new.Parent = script.Parent
		new.Name = item.Name
		new.ItemName.Text = item.Name
		item:Clone().Parent = new.ItemImage
		
		new.LayoutOrder = count
		
		count += 1
		
		local viewport = new.ItemImage
		
		viewport.InputBegan:Connect(function(input)
			
			-- checks if the user has clicked inside of the viewport. if yes, this counts as selecting item (same as )
			if input.UserInputType == Enum.UserInputType.MouseButton1 then SelectEvent:FireServer(item.Name) end
			
		end)
		
		new.ItemName.MouseButton1Down:Connect(function() SelectEvent:FireServer(item.Name) end)
	end
	
end

