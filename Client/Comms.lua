-- 0.4.2

local World = require("World")
local Items = require("Items")
local Mapping = require("Mapping")

function openComms()
	while true do
		local senderId, message, protocol = listenForMessage()
		if protocol == "lenny_location" then
			broadcastLocation(senderId)
		end
		
		if protocol == "start_mapping" then
			rednet.send(senderId, "Mapping started", "start_mapping_response")
			Mapping.doMapping()
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

local sentPickUp = false
function pickUp()
	if (Items.getHealth() < 35) and (not sentPickUp) then
		local pickUpMessage = "Mom pick me up I'm scared\n" .. "My health is at " .. Items.getHealth()
		rednet.broadcast("Mom pick me up I'm scared", "lenny_scared")
		sentPickUp = true
	end
end

return {openComms = openComms, pickUp = pickUp}