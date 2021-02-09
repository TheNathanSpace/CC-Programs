-- 0.1.4

local Location = require("Location")
local Movement = require("Movement")

shell.run("label", "set", "Horton")
rednet.open("left")

function openComms()
	while true do
		local senderId, message, protocol = listenForMessage()		
		if protocol == "start_mapping" then
			rednet.send(senderId, "Mapping started", "start_mapping_response")
		end
	end
end

function listenForMessage()
	local senderId, message, protocol = rednet.receive()
	return senderId, message, protocol
end

term.clear()
shell.run("clear")

for i = 0, 13 do
	print(" ")
	term.clear()
end

function writeScreen()
  local x, y, z = Location.returnLocation()
  print(x .. " " .. y .. " " .. z .. " facing " .. Location.getFacingDirection())
end

function Reset()
	Location.Reset()
end

function Tick()
	Location.getLocation()
	writeScreen()
end

function MainTick()
  Movement.pinpointFacing()
  
  while true do
    Tick()
    Reset()
  end
end

parallel.waitForAll(MainTick, openComms)  