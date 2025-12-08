--[[
--// Roblox Painter is a Modular Grid-Based Placement System \\--

Created by: @BinceVeef 08/12/2025

--//// INSTRUCTIONS \\\--

-- Main Setup

To implement in your game, place all models within the service it is named as, and ungroup.

Place all in-game placeable items within the 'Items' folder, in ReplicatedStorage. These must be Models only.

Place all player maps/plots in the 'Maps' folder, in Workspace. These must be Parts only.
	Ensure that each map has a unique name.

-- GUI Setup

To correctly set up a GUI to utilise the system,
All GUI buttons referencing placeable items must connect mouse click to the 'Select' event in ReplicatedStorage:

	button.MouseButton1Down:Connect(function()
		ReplicatedStorage.Events.Select:FireServer([placeable item name])
	end)
	
'DeleteScript' should be parented to the delete button you create for the GUI. This will handle switching between placement and deleting, with basic UX notification.

-- Grid Setup

USE EITHER ONLY 'MapTiles' OR 'SizeConstraint' FOR GRID SETUP, UNLESS THEY CORRESPOND WITH EACH OTHER.
You can adjust the number of tiles on a player's grid by changing the 'MapTiles' of the 'Data' table within the 'MapModule' ModuleScript.
If needed, you can set the maximum size of each tile instead by changing the 'SizeConstraint' of the 'Data' table within the 'MapModule' ModuleScript.
	The script will always attempt to use 'MapTiles' over 'SizeConstraint'.
	If not using one of the properties, set it to 'Vector2.zero' for safety.

]]--