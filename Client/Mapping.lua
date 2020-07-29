-- 0.4.0

local Util = require("Util")
local World = require("World")
local Movement = require("Movement")
local Pathfinding = require("Pathfinding")

currentlyMapping = false -- Note that when you start mapping all of Live.Tick() is stopped. You'll have to remember to call Reset() when needed.

currentX = nil
currentY = nil
currentZ = nil
currentFacing = nil

traversedOpenSpaces = {} -- This is the big list that everyone will reference. traversedOpenSpaces["-1034/582"] = ""
uncheckedOpenSpaces = {}

function getCurrentlyMapping()
	return currentlyMapping
end

function setCurrentFacing(newCurrentFacing)
	currentFacing = newCurrentFacing
end

function turnRight()
	Movement.turnRight()
end

function turnLeft()
	Movement.turnLeft()
end

function addCurrentLocation()
	currentX, startY, currentZ = World.returnLocation()
	local currentLocationKey = Util.createLocationKey(currentX, currentZ)
	traversedOpenSpaces[currentLocationKey] = ""
end

-- Start loop

currentX, startY, currentZ = World.returnLocation()
currentFacing = World.getFacing()
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
			local currentLocationKey = Util.createLocationKey(currentX, currentZ)
			Pathfinding.processLocations(currentLocationKey, Util.getFirstKey(uncheckedOpenSpaces), traversedOpenSpaces) -- Wait for this to finish
		end
	end
	
	turtle.forward()
end

return {getCurrentlyMapping = getCurrentlyMapping, setCurrentFacing = setCurrentFacing}