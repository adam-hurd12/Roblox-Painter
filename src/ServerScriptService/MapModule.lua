local Map = {}


Map.Data = {
	['MapFolderPath'] = workspace.Maps;
	--['sizeConstraint'] = Vector2.new(5,5);
	['mapTiles'] = Vector2.new(10,10);
}


function Map.InitMap(map: Part)
	
	if not workspace:FindFirstChild('TileFolder') then Map.InitGame() end
	
	local sizeConstraint = Map.Data.sizeConstraint or Vector2.zero				-- sizeConstraint.X = max width, sizeConstraint.Y = max height
	local mapTiles = Map.Data.mapTiles or Vector2.zero							-- mapTiles.X = num of horizontal tiles, mapTiles.Y = num of vertical tiles

	local mapSize = Vector2.new(map.Size.X, map.Size.Z)
	local sizeX = mapSize.X ; local sizeY = mapSize.Y
	
	local mapPos = Vector2.new(map.Position.X, map.Position.Z)
	
	if mapTiles ~= Vector2.zero then	-- number of tiles has been given, need to calculate size constraint
		
		local tilesX = mapTiles.X
		local tilesY = mapTiles.Y
		
		sizeConstraint = Vector2.new(sizeX / tilesX, sizeY / tilesY)
	
	elseif sizeConstraint ~= Vector2.zero then	-- max tile size has been given, need to calculate num of tiles
		
		local constraintX = sizeConstraint.X
		local constraintY = sizeConstraint.Y
		
		mapTiles = Vector2.new(sizeX / constraintX, sizeY / constraintY)
		
	end
	
	local counter = 1
	
	-- place tiles on the given map
	for y = 1, mapTiles.Y do
		
		for x = 1, mapTiles.X do
			
			-- create tile
			local tile = script:WaitForChild('Tile'):Clone()
	
			tile.Parent = workspace:WaitForChild('TileFolder')[map.Name]
			tile.Name = counter ; counter += 1
			print(counter)
			tile.Size = Vector3.new(sizeConstraint.X, 0.1, sizeConstraint.Y)
			
			-- place tile in correct position
			tile.Position = Vector3.new(
				mapPos.X - (mapSize.X * 0.5) + (sizeConstraint.X * (0.5 + x-1)),
				map.Size.Y + (tile.Size.Y),
				mapPos.Y - (mapSize.Y * 0.5) + (sizeConstraint.Y * (0.5 + y-1))
			)
			
		end
	end
	
	
end


function Map.InitGame()
	
	local maps = Map.Data.MapFolderPath:GetChildren()
	
	-- set up all folders needed for gameplay
	
	-- set up the tile folders, with names mirroring the maps
	local tileFolder = Instance.new('Folder')
	tileFolder.Parent = workspace
	tileFolder.Name = 'TileFolder'
	
	for _, map in ipairs(maps) do
		
		if map:IsA('Part') then

			-- set UserId attribute as -1 for each map
			map:SetAttribute('UserId', -1)
			
			-- create a tile folder for each map
			local folder = Instance.new('Folder')
			folder.Parent = tileFolder
			folder.Name = map.Name
		end
		
	end	
	
	-- set up the placed items folder, where child folders are set up when players are added to the game
	local placedFolder = Instance.new('Folder')
	placedFolder.Parent = workspace
	placedFolder.Name = 'PlacedItemsFolder'
	
	
	-- set up the tile template
	local tile = script:WaitForChild('Tile')
	tile:SetAttribute('Item', '')
end


return Map
