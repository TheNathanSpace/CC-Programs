-- 0.3.1

local World = require("World")
local Items = require("Items")

local protocolString = "lenny_location"

function openComms()
	while true do
		local senderId, message, protocol = listenForMessage()
		if protocol == protocolString then
			broadcastLocation(senderId)
		end
	end
end

function listenForMessage()
	local senderId, message, protocol = rednet.receive()
	return senderId, message, protocol
end

function formLocation(x, y, z)
	local messageString = "I'm located at " .. x .. " " .. y .. " " .. z
	return messageString
end

function broadcastLocation(targetID)
	local x, y, z = World.returnLocation() -- If this is added as variables to the World file, don't re-get it here
	rednet.send(targetID, formLocation(x, y, z), "lenny_location_response")
end

function pickUp()
	if (Items.getHealth() < 35) then
		local pickUpMessage = "Mom pick me up I'm scared\n" .. "My health is at " .. Items.getHealth()
		rednet.broadcast("Mom pick me up I'm scared", "lenny_scared")
	end
end

return {openComms = openComms, pickUp = pickUp}