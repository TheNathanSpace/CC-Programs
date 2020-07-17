-- 0.2.4

local World = require("World")

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

function formResponse(x, y, z)
	local messageString = "I'm located at " .. x .. " " .. y .. " " .. z
	print(messageString)
	return messageString
end

function broadcastLocation(targetID)
	local x, y, z = World.getLocation()
	rednet.send(targetID, formResponse(x, y, z), "lenny_location_response")
end

return {openComms = openComms}