local num = 1
local maps = workspace.Maps


local players = {
	-1,
	-1,
	-1,
	-1,
	-1,
	-1,		
}


game.Players.PlayerAdded:Connect(function(plr)
	
	-- find the first available slot
	for i in players do if players[i] == '' then num = i ; return end players[num] = plr.UserId end
	
	-- set up leaderstats for each player
	
	local stats = Instance.new('Folder')
	stats.Name = 'leaderstats'
	stats.Parent = plr
	
	local Item = Instance.new('IntValue')
	Item.Name = 'item'
	Item.Value = 0
	Item.Parent = stats
	
	local Name = Instance.new('StringValue')
	Name.Name = 'name'
	Name.Value = ''
	Name.Parent = stats
	
	local Delete = Instance.new('BoolValue')
	Delete.Name = 'delete'
	Delete.Value = false
	Delete.Parent = stats
	
	
	-- set up the map and player sign for each player
	
	maps[num].Name = plr.UserId
	workspace.PlayerSigns[num].SurfaceGui.TextLabel.Text = plr.Name

	local mapPieces = maps[plr.UserId]:GetChildren()

	for i,v in pairs(mapPieces) do

		if v:IsA('Part') then v:SetAttribute('plr', plr.UserId) end

	end

	local plrFolder = Instance.new('Folder')
	plrFolder.Parent = workspace.PlacedItems
	plrFolder.Name = plr.UserId

	num += 1

end)


game.Players.PlayerRemoving:Connect(function(plr)
	
	local num = table.find(players, plr.UserId)
	
	-- remove all traces of player (always using UserId for better removal)
	
	workspace.PlacedItems:WaitForChild(plr.UserId):Destroy()
	
	local map = maps:WaitForChild(plr.UserId)
	local pieces = map:GetChildren()
	
	map.Name = num
	
	for i, v in ipairs(pieces) do
		
		if v:IsA('Part') then v:SetAttribute('item', nil) ; v:SetAttribute('plr', nil) end
		
	end
	
	workspace.PlayerSigns[num].SurfaceGui.TextLabel.Text = ''
	
	
end)
