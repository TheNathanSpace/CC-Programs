-- 0.2.1

local World = require("World")

local messageString = "I'm located at ", x, " ", y, " ", z
local protocalString = "lenny_location"

function openComms()
	while true do
		local senderId, message, protocol = listenForMessage()
		
		broadcastLocation(senderId)
	end
end

function listenForMessage()
	local senderId, message, protocol = rednet.receive(protocalString)
	return senderId, message, protocol
end

function broadcastLocation(targetID)
	local x, y, z = World.getLocation()
	rednet.send(targetID, messageString, "lenny_location_response")
end

return {openComms = openComms}