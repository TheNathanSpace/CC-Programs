-- 0.4.0

local World = require("World")
local Movement = require("Movement")

currentlyMapping = false -- Note that when you start mapping all of Live.Tick() is stopped. You'll have to remember to call Reset() when needed.

function getCurrentlyMapping()
	return currentlyMapping
end

function turnRight()
	currentFacing = Movement.turnRight()
end

function turnLeft()
	currentFacing = Movement.turnLeft()
end

function addCurrentLocation()
	currentX, startY, currentZ = World.returnLocation()
	local currentLocationKey = Util.createLocationKey(currentX, currentZ)
	traversedOpenSpaces[currentLocationKey] = ""
end

traversedOpenSpaces = {} -- This is the big list that everyone will reference. traversedOpenSpaces["-1034/582"] = ""
uncheckedOpenSpaces = {}

local currentX, startY, currentZ = World.returnLocation()
local currentFacing = World.getFacing()
currentlyMapping = true

if currentX == nil then
	turtle.forward()
	World.getLocation()
	currentX, startY, currentZ = World.returnLocation()
	currentFacing = World.getFacing()
end

while not (currentFacing == 4) do
	turnRight()
end

while true do
	addCurrentLocation()
	
	-- Check left
	turnLeft()
	local leftClear = not turtle.detect()
	if leftClear then
		local facingX, facingY, facingZ = World.getFacingBlock()
		local facingLocationKey = Util.createLocationKey(facingX, facingZ)
		uncheckedOpenSpaces[facingLocationKey] = ""
	end
	
	-- Check right
	turnRight()
	turnRight()
	local rightClear = not turtle.detect()
	if rightClear then
		local facingX, facingY, facingZ = World.getFacingBlock()
		local facingLocationKey = Util.createLocationKey(facingX, facingZ)
		uncheckedOpenSpaces[facingLocationKey] = ""
	end
	
	turnLeft() -- Reset to straight
	
	-- Check front
	local frontClear = not turtle.detect()
	
	if not frontClear then
		if leftClear then
			turnLeft()
			turtle.forward()
			turnLeft()
			addCurrentLocation()
		else if rightClear then
			turnRight()
			turtle.forward()
			turnRight()
			addCurrentLocation()
		else
			-- Gotta go an open spot. Pathfind with the existing map? There should be enough nodes to get there.
		end
	end
	
	turtle.forward()
end

return {getCurrentlyMapping = getCurrentlyMapping}