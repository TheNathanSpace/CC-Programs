-- 0.4.1

local Util = require("Util")
local World = require("World")
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
	local Movement = require("Movement")
	Movement.turnRight()
end

function turnLeft()
	local Movement = require("Movement")
	Movement.turnLeft()
end

function addCurrentLocation()
	currentX, startY, currentZ = World.returnLocation()
	local currentLocationKey = Util.createLocationKey(currentX, currentZ)
	traversedOpenSpaces[currentLocationKey] = ""
end

function doMapping()
	-- Start loop. Still gotta figure this out

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
				local keyExists = Util.getFirstKey(uncheckedOpenSpaces)
				
				if not (keyExists == nil) then
					local result = Pathfinding.processLocations(currentLocationKey, keyExists, traversedOpenSpaces)
				
					while not (currentFacing == 4) do
						turnRight()
					end
				else
					break
				end
			end
		end
		-- Should make sure aligned to where you wanna go
		
		turtle.forward()
	end
	print("Yay")
	currentlyMapping = false
	
end

return {getCurrentlyMapping = getCurrentlyMapping, setCurrentFacing = setCurrentFacing, doMapping = doMapping}