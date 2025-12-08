local Map = require(game:GetService('ServerScriptService').MapModule)


game.Players.PlayerAdded:Connect(function(player: Player)
	
	player:SetAttribute('CurrentItem', '')
	player:SetAttribute('Delete', false)
	
	local maps = Map.Data.MapFolderPath:GetChildren()
	
	local mapToInit
	for _, map in ipairs(maps) do

		if map:IsA('Part') and map:GetAttribute('UserId') == -1 then
			
			local folder = Instance.new('Folder')
			folder.Parent = workspace:WaitForChild('PlacedItemsFolder')
			folder.Name = player.UserId
			map:SetAttribute('UserId', player.UserId)
			mapToInit = map
			break
		end

	end
	
	--Map.InitMap(mapToInit, player)
end)


game.Players.PlayerRemoving:Connect(function(player: Player)

	local maps = Map.Data.MapFolderPath:GetChildren()

	-- remove all traces of the player, using their UserId
	
	-- destroy their placed item folder
	workspace:WaitForChild('PlacedItemsFolder')[player.UserId]:Destroy()
	
	-- remove the map's UserId attribute
	for _, map in ipairs(maps) do
		
		if map:IsA('Part') and map:GetAttribute('UserId') == player.UserId then
			map:SetAttribute('UserId', -1)
		end
	end
	
end)