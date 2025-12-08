local ReplicatedStorage = game:GetService('ReplicatedStorage')
local ItemsFolder = ReplicatedStorage:WaitForChild('Items')


local Item = {}


-- AllItems is a table containing the string names of all Models within the Item folder
Item.AllItems = {}
for _, item in ipairs(ItemsFolder:GetChildren()) do 
	if item:IsA('Model') then 
		table.insert(Item.AllItems, item.Name) 
		if not item.PrimaryPart then 
			item.PrimaryPart = item:FindFirstChildOfClass('Part') 
		end 
	end
end

	
--// Helper functions

-- check if an item exists
function Item.CheckItemExists(item: string): boolean
	if table.find(Item.AllItems, item) then return true
	else return false end
end

-- get the currently selected Model for the player
function Item.GetCurrentItem(player: Player): Model
	local item = player:GetAttribute('CurrentItem')
	if Item.CheckItemExists(item) then return ItemsFolder:FindFirstChild(item)
	else return nil end
end

-- set the currently selected Model for the player
function Item.SetCurrentItem(player: Player, item: string)
	player:SetAttribute('CurrentItem', item)
end

-- get the Model from a string value
function Item.GetModel(item: string): Model
	if Item.CheckItemExists(item) then return ItemsFolder:FindFirstChild(item)
	else return nil end
end


--// Main functions

function Item.SelectItem(player: Player, item: string): boolean
	if Item.GetCurrentItem(player) and Item.GetCurrentItem(player).Name == item then item = '' end
	Item.SetCurrentItem(player, item)
end


function Item.PlaceItem(player: Player, tile: Part): boolean
	local item = Item.GetCurrentItem(player)
	
	if not item or not item:IsA('Model') then warn('current item is not valid.'); return false end
	if tile:GetAttribute('Item') ~= '' then warn('attempt to place more than one item on a single tile.') ; return false end
	
	local clone = item:Clone()
	clone:PivotTo(CFrame.new(tile.Position + Vector3.new(0, item.PrimaryPart.Size.Y * 0.5, 0)))
	clone.Name = tile.Name
	clone.Parent = workspace:WaitForChild('PlacedItemsFolder')[player.UserId]
	
	tile:SetAttribute('Item', item.Name)
	return true
end


function Item.DeleteItem(player: Player, part): boolean		-- part is either a tile piece or the item to delete

	local mapNum
	for _, map in ipairs(workspace.Maps:GetChildren()) do if map:IsA('Part') and map:GetAttribute('UserId') == player.UserId then mapNum = map.Name end end

	local tile = workspace.TileFolder[mapNum]:FindFirstChild(part.Name)
	
	if not tile then warn('unable to delete, as there is no tile at the mouse position.') ; return false end
	
	local item
	if part:IsDescendantOf(workspace.TileFolder) then 
		item = workspace:WaitForChild('PlacedItemsFolder')[player.UserId]:FindFirstChild(tile.Name)
	else item = part end

	
	if not item or not item:IsA('Model') then warn('item is not valid.'); return false end
	if tile:GetAttribute('Item') == '' then warn('attempt to delete from a tile that has no item.') ; return false end
	
	Item.SetCurrentItem(player, '')
	item:Destroy()
	tile:SetAttribute('Item', '')
	return true
end


return Item
