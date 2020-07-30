-- 0.4.0

local Util = require("Util")
local World = require("World")
local Movement = require("Movement")

openLocations = {} -- Have to scan the room to fill this up when the server goes online. openLocations["-1034/582"] = ""
distancedLocations = openLocations -- Add distances as you get them.
locationsToTry = openLocations -- Add locations that still need to be tried. Remove the locations that have been tried and don't need to be retried.
finalPath = {}

currentlyPathfinding = false

function getCurrentlyPathfinding()
	return currentlyPathfinding
end

function processLocations(keyStart, keyEnd, mappings)
	currentlyPathfinding = true
	
	if not (mappings == nil) then
		distancedLocations = mappings
	else
		distancedLocations = openLocations
	end
	
	if distancedLocations == nil then 
		distancedLocations = openLocations
		distancedLocations = distancedLocations
		useDistancedLocations = true
	end
	
	if (Util.hasKey(distancedLocations, keyStart)) then
		distancedLocations[keyStart] = 0
		
		local neighborAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }

		for key, blankDistance in pairs(locationsToTry) do -- Don't use blankDistance! Use distancedLocation's distance!
			local currentDistance = distancedLocations[key]
			local newDistance = currentDistance + 1
			
			local currentX, currentZ = Util.parseLocationKey(key)
			local neighborKeys = {}
						
			for iterator, neighbor in ipairs(neighborAdjustments) do
				local newX = currentX + neighbor[1]
				local newZ = currentZ + neighbor[2]
				
				local neighborKey = Util.createLocationKey(newX, newZ)
				
				neighborKeys[neighborKey] = distance + 1
		--		table.insert(neighborKeys, neighborKey, distance + 1)
			end
			
			for neighborKey, newDistance in pairs(neighborKeys) do
				local result = updateLocation(neighborKey, newDistance)
			end
		end
		
		local result = findPath(keyEnd, keyStart)
		return result
	else
		return false
	end
end

function updateLocation(key, newDistance)
	local distanceEmpty = (distancedLocations[key] == "")
	
	local removeKey = nil
	
	if (Util.hasKey(distancedLocations, key)) then
		removeKey = true
		
		if (not distanceEmpty) and (distancedLocations[key] > newDistance) then
			distancedLocations[key] = newDistance
			removeKey = false
		end
		
		if distanceEmpty then
			distancedLocations[key] = newDistance
			removeKey = false
		end
	end
	
	if removeKey then
		table.remove(locationsToTry, key)
	end
	
	return true
end

function determineMovement(keyToMoveTo)
	local moveToX, moveToZ = Util.parseLocationKey(keyToMoveTo)
	local currentX, currentY, currentZ = World.returnLocation()
	
	if currentX < moveToX then -- 1 = North, 2 = East, 3 = South, 4 = West
		facingNum = 2
	end
	if currentX > moveToX then 
		facingNum = 4
	end
	if currentZ < moveToZ then 
		facingNum = 3
	end
	if currentZ > moveToZ then 
		facingNum = 1
	end
	
	while not (World.getFacing() == facingNum) do 
		Movement.turnRight()
	end
	
	turtle.forward()
	
	return true
end

function followPath(startLocation, endLocation)
	while true do
		local x, y, z = World.returnLocation()
		if Util.createLocationKey(x, z) == endLocation then break end
		
		local neighborAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }

		local neighborKeys = {}
		
		for iterator, neighbor in ipairs(neighborAdjustments) do
			local newX = currentX + neighbor[1]
			local newZ = currentZ + neighbor[2]

			local neighborKey = Util.createLocationKey(newX, newZ)
			neighborKeys[neighborKey] = ""
		end

		local keyToMoveTo = nil
		for key, fakeDistance in neighborKeys do
			if Util.hasKey(finalPath, key) then
				keyToMoveTo = key
				break
			end
		end

		local done = determineMovement(keyToMoveTo, startLocation)
	end
	
	currentlyPathfinding = false
	
	return true
end

function findPath(endLocation, startLocation) -- Parameters here are named based on the overarching goal. So, you start from the end location.
	local endLocationX, endLocationZ = Util.parseLocationKey(endLocation)
	local currentX = endLocationX
	local currentZ = endLocationZ
	local currentDistance = distancedLocations[endLocation]
	
	if not (Util.isEmpty(currentDistance)) then

		local neighborAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }
		
		while true do
			local neighborKeys = {}

			for iterator, neighbor in ipairs(neighborAdjustments) do
				local newX = currentX + neighbor[1]
				local newZ = currentZ + neighbor[2]

				local neighborKey = Util.createLocationKey(newX, newZ)

				neighborKeys[neighborKey] = ""
		--		table.insert(neighborKeys, neighborKey, "")
			end

			local lowestDistanceKey = nil
			local lowestDistance = 999999999
			
			for neighborKey, blankDistance in pairs(neighborKeys) do
				local neighborDistance = distancedLocations[neighborKey]
				
				if neighborDistance < lowestDistance then
					lowestDistanceKey = neighborKey
					lowestDistance = neighborDistance
				end
			end
			
			table.insert(finalPath, lowestDistanceKey)
			
			currentX, currentZ = Util.parseLocationKey(lowestDistanceKey)

			if lowestDistance == 0 then
				break			
			end
		end
		
		local result = followPath(startLocation, endLocation)
		return result
	else
		print("Can't navigate this")
	end
end

function Reset()
	distancedLocation = {}
	locationsToTry = {}
	finalPath = {}
end

return {getCurrentlyPathfinding = getCurrentlyPathfinding, Reset = Reset}