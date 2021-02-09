-- 0.1.4

local Util = require("Util")
local Location = require("Location")

local clearSpots = {}
local uncheckedClearSpots = {}

function addSpot(x, z)
  local key = Util.createLocationKey(x, z)
  if(not Util.hasKey(clearSpots, key)) then
    clearSpots[key] = ""
  end
  
  rednet.broadcast(key .. " is clear", "start_mapping_response")
end

function checkRight()
  Location.turnRight()
  
  if (not turtle.detect()) then
    local x, y, z = Location.getFacingBlock()
    addSpot(x, z)
  end
  
  Location.turnLeft()
end

function checkLeft()
  Location.turnLeft()
  
  if (not turtle.detect()) then
    local x, y, z = Location.getFacingBlock()
    addSpot(x, z)
  end

  Location.turnRight()
end

function checkFront()
  if (not turtle.detect()) then
    local x, y, z = Location.getFacingBlock()
    addSpot(x, z)
  end
end

function checkLocations()
  checkRight()
  checkLeft()
  checkFront()
end

return {checkLocations = checkLocations, checkLeft = checkLeft, checkRight = checkRight, checkFront = checkFront}