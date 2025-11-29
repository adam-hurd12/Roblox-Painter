local TweenService = game:GetService("TweenService")

local frame = script.Parent.LoadingGui.Main
local label = frame.LoadingText
local title = frame.Title

local children = frame.Parent:GetDescendants()

frame.Parent.Enabled = true

frame.Visible = true
title.TextTransparency = 0
wait(3)
TweenService:Create(label, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
wait(2)

for i,v in pairs(children) do
	if children[i]:IsA("TextLabel") then
		TweenService:Create(children[i], TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
	end
end
wait(.5)
TweenService:Create(frame, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {BackgroundTransparency = 1}):Play()
wait(1)

frame.Parent.Parent.InventoryGui.Enabled = true
frame.Parent:Destroy()