-- 0.1.0

local Util = require("Util")
local Location = require("Location")

local coordinateAdjustments = { {1, 0}, {-1, 0}, {0, 1}, {0, -1} }

function pushDistance(table, key, newDistance)
  
  local oldDistance = table[key]
  
  if (newDistance < oldDistance) then
    table[key] = newDistance
  end
  
end

function findShortestDistance(distancedTable, key)
  local shortestKey = nil
  local shortestDistance = 99999999
  
  for iterator, adjustment in ipairs(coordinateAdjustments) do
    
    local adjacentX = startX + adjustment[1]
    local adjacentZ - startZ + adjustment[2]
    
    local adjacentCoordinate = Util.createLocationKey(adjacentX, adjacentZ)
    local coordinateDistance = distancedTable[adjacentCoordinate]
    
    if (coordinateDistance < shortestDistance) then
      shortestDistance = coordinateDistance
      shortestKey = adjacentCoordinate
    end
    
  end
  
  return shortestKey, shortestDistance

end


-- 1. Set start distance to 0.
-- 2. Set each adjacent node to 1. Add each node to a list.
-- 3. In chronological order, assign 2 to the adjacent nodes for each of the above, popping the 1 list item. Append each 2 node to the list.

function determineDistances(openLocationsTable, startKey, endKey)
  local startX, startZ = Util.parseLocationKey(startKey)
    
  local nodesToProcess = {}  
  local assignedDistancesTable = {}
  
  pushDistance(assignedDistancesTable, startKey, 0)
  
  for iterator, adjustment in ipairs(coordinateAdjustments) do
    
    local adjacentX = startX + adjustment[1]
    local adjacentZ - startZ + adjustment[2]
    
    local adjacentCoordinate = Util.createLocationKey(adjacentX, adjacentZ)
    
    table.insert(nodesToProcess, adjacentCoordinate)
  end
  
  while true do
    
    local currentKey = table.remove(nodesToProcess, 1)
    local currentKeyX, currentKeyZ = Util.parseLocationKey(currentKey)
    
    local shortestKey, shortestDistance = findShortestDistance(assignedDistancesTable, currentKey)
    pushDistance(assignedDistancesTable, currentKey, shortestDistance + 1)
    
    for iterator, adjustment in ipairs(coordinateAdjustments) do
      
      local adjacentX = currentKeyX + adjustment[1]
      local adjacentZ - currentKeyZ + adjustment[2]
      
      local adjacentCoordinate = Util.createLocationKey(adjacentX, adjacentZ)
      
      table.insert(nodesToProcess, adjacentCoordinate)
    end
    
    if (Util.tablelength(nodesToProcess) == 0) then
      break
    end
    
  end
  
  return assignedDistancesTable
  
end


function findPath(assignedDistancesTable, endKey)
  
  local finishedPath = {}
  
  local endKeyX, endKeyZ = Util.parseLocationKey(endKey)
  
  local currentKeyX, currentKeyZ = endKeyX, endKeyZ

  while true do:
    
    local shortestKey = nil
    local shortestDistance = 99999999
    
    for iterator, adjustment in ipairs(coordinateAdjustments) do
      
      local adjacentX = currentKeyX + adjustment[1]
      local adjacentZ - currentKeyZ + adjustment[2]
      
      local adjacentCoordinate = Util.createLocationKey(adjacentX, adjacentZ)
      local coordinateDistance = assignedDistancesTable[adjacentCoordinate]
      
      if (coordinateDistance < shortestDistance) then
        shortestDistance = coordinateDistance
        shortestKey = adjacentCoordinate
      end
    end
    
    table.insert(finishedPath, shortestKey)
    
    currentKeyX, currentKeyZ = Util.parseLocationKey(shortestKey)

    if (shortestDistance == 0) then
      break
    end
    
  end
  
  return reverseTable(finishedPath)

end
