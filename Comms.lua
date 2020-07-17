-- 0.2.2

local World = require("World")

local messageString = "I'm located at ", x, " ", y, " ", z
local protocalString = "lenny_location"

function openComms()
	while true do
		print("Listening for messsage")
		local senderId, message, protocol = listenForMessage()
		print("Message recieved")
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
	print("Response sent")
end

return {openComms = openComms}