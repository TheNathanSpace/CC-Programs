-- 0.1.6

local Location = require("Location")
local Mapping = require("Mapping")

shell.run("label", "set", "Horton")
rednet.open("left")

function openComms()
	while true do
		local senderId, message, protocol = listenForMessage()		
		if protocol == "start_mapping" then
			rednet.send(senderId, "Mapping started", "start_mapping_response")
      
      Mapping.checkLocations()
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
end

function Reset()
	Location.Reset()
end

function Tick()
	Location.getLocation()
  Location.setDirection()
	writeScreen()
  
end

function MainTick()
  Location.pinpointFacing()
  
  while true do
    Tick()
    Reset()
  end
end

parallel.waitForAll(MainTick, openComms)  