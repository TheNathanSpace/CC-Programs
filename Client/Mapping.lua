 1. Go in straight lines.
	a. Choose +X. Go in that direction. While doing this, note nodes you've been to. Note nodes that you pass that are open. When you hit a wall, reverse (-X) until you hit a wall. TODO: Update steps for the flipped direction.
	b. Once you can't go any further, choose +Z.
	c. Go that direction until a node in the +X direction is open.
	d. Go back to Step A.
 2. Once you're trapped on all sides by impassable nodes or nodes you've been to, go back to the first open node you recorded. Do Step 1, but go whichever way is open when you hit a wall.

local World = require("World")

currentlyMapping = false -- Note that when you start mapping all of Live.Tick() is stopped. You'll have to remember to call Reset() when needed.

function getCurrentlyMapping()
	return currentlyMapping
end

traversedOpenSpaces = {}
uncheckedOpenSpaces = {}

local startX, startY, startZ = World.returnLocation()
local startFacing = World.returnFacing()
currentlyMapping = true

if startX == nil then
	turtle.forward()
	World.getLocation()
	startX, startY, startZ = World.returnLocation()
	startFacing = World.returnFacing()
end



return {getCurrentlyMapping = getCurrentlyMapping}