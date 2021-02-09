-- 0.1.0

local Util = require("Util")

local clearSpots = {}
local uncheckedClearSpots = {}

function addSpot(x, z)
  clearSpots[Util.createLocationKey(x, z)] = ""
end

