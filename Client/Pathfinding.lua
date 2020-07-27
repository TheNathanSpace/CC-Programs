-- 0.4.0

local Util = require("Util")

openLocations = {} -- Have to scan the room to fill this up when the server goes online. openLocations["-1034/582"] = ""
distancedLocations = openLocations -- Add distances as you get them.
locationsToTry = openLocations -- Add locations that still need to be tried. Remove the locations that have been tried and don't need to be retried.
finalPath = {}

function createKey(x, z)
	return x .. "/" .. z
end

function parseKey(stringKey)
	local parsedTable = Util.split(stringKey, "/")
	return parsedTable[1], parsedTable[2]
end

function processLocations(keyStart)
	if (Util.hasKey(distancedLocations, keyStart)) then
		distancedLocations[keyStart] = 0
		
		local neighborAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }

		for key, blankDistance in pairs(locationsToTry) do -- Don't use blankDistance! Use distancedLocation's distance!
			local currentDistance = distancedLocations[key]
			local newDistance = currentDistance + 1
			
			local currentX, currentZ = parseKey(key)
			local neighborKeys = {}
						
			for iterator, neighbor in ipairs(neighborAdjustments) do
				local newX = currentX + neighbor[1]
				local newZ = currentZ + neighbor[2]
				
				local neighborKey = createKey(newX, newZ)
				
				neighborKeys[neighborKey] = distance + 1
		--		table.insert(neighborKeys, neighborKey, distance + 1)
			end
			
			for neighborKey, newDistance in pairs(neighborKeys) do
				updateLocation(neighborKey, newDistance)
			end
		end
	else
		print("Not a valid start location!")
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
end

function findPath(endLocation, startLocation) -- Parameters here are named based on the overarching goal. So, you start from the end location.
	local endLocationX, endLocationZ = parseKey(endLocation)
	local currentX = endLocationX
	local currentZ = endLocationZ

	local neighborAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }
	
	while true do
		local neighborKeys = {}

		for iterator, neighbor in ipairs(neighborAdjustments) do
			local newX = currentX + neighbor[1]
			local newZ = currentZ + neighbor[2]

			local neighborKey = createKey(newX, newZ)

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
		
		currentX, currentZ = parseKey(lowestDistanceKey)

		if lowestDistance == 0 then
			break			
		end
	end
end

return {createKey = createKey, parseKey = parseKey}