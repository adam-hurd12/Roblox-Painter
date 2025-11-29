local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ItemsFolder = ReplicatedStorage:WaitForChild('Items')

local ItemModule = {}

ItemModule.AllItems = {
}

-- add all items from the 'Items' folder to the table for easier access and searching
for i,v in ipairs(ItemsFolder:GetChildren()) do if v:IsA('Part') then table.insert(ItemModule.AllItems, v.Name) end end


function ItemModule.CheckItem(item): boolean
	if table.find(ItemModule.AllItems, item) then return true
	else return false end
end


function ItemModule.SelectItem(plr, name, index): boolean
	
	local stats = plr:WaitForChild('leaderstats')
	
	if not ItemModule.CheckItem(name) then warn(string.format('item \'%s\' is not valid.', name)) ; return false end

	stats.item.Value = index
	stats.name.Value = name
	
	return true
	
end


function ItemModule.SpawnItem(plr, mapPiece: Part): boolean
	
	local item = plr:WaitForChild('leaderstats').name.Value
	
	if not ItemModule.CheckItem(item) then warn(string.format('item \'%s\' is not valid.', item)) ; return false end
	
	local itemClone = ItemsFolder[item]:Clone()

	itemClone.Position = mapPiece.Position
	itemClone.Name = mapPiece.Name
	itemClone.Parent = game.Workspace.PlacedItems[plr.UserId]

	mapPiece:SetAttribute('item', item)
	
	return true

end


function ItemModule.DeleteItem(plr, mapPiece: Part): boolean		-- mapPiece is the part of the Map that holds the item to be deleted
	
	local item = plr:WaitForChild('leaderstats').name.Value
	
	if not ItemModule.CheckItem(item) then warn(string.format('item \'%s\' is not valid.', item)) ; return false end

	game.Workspace.PlacedItems[plr.UserId]:FindFirstChild(mapPiece.Name):Destroy()

	mapPiece:SetAttribute('item', nil)

	return true
	

end

return ItemModule