local Items = game:GetService('ReplicatedStorage'):WaitForChild('Items')
local b = Instance.new('TextButton')
b.BackgroundColor3 = Color3.fromRGB(175, 176, 255)
b.Position = UDim2.new{0,0,0,0}
b.Size = UDim2.new{0.3,0,.1,0}
b.Font = Enum.Font.SourceSans
b.Text = 'Button'
b.TextColor3 = Color3.new(0)
b.TextSize = 14
b.TextStrokeTransparency = 1
b.TextXAlignment = Enum.TextXAlignment.Center
b.TextYAlignment = Enum.TextYAlignment.Center
b.Parent = script

local listLayout = Instance.new('UIListLayout')
listLayout.Padding = UDim.new(0.002,0)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Parent = b

local sizeConstraint = Instance.new('UISizeConstraint')
sizeConstraint.MaxSize = Vector2.new(70,70)
sizeConstraint.Parent = b


local items = Items:GetChildren()

for i,v in items do
	
	local button = b:Clone()
	button.Text = v.Name
	button.Name = v.Name
	button.LayoutOrder = i
	button.Parent = script.Parent.InventoryGui.Main.ItemContainer
	
end