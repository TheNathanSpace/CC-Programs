-- 0.2.0

local World = require("World")

local messageString = "I'm located at ", x, " ", y, " ", z
local protocalString = "lenny_location"

function openComms()
	while true do
		local c = coroutine.create(listenForMessage)
		
		local ok, recievedMessage = coroutine.resume(c)
		
		broadcastLocation(recievedMessage[1])
	end
end

function listenForMessage()
	local senderId, message, protocol = rednet.receive(protocalString)
	coroutine.yield({senderId, message, protocal})
end

function broadcastLocation(targetID)
	local x, y, z = World.getLocation()
	rednet.send(targetID, messageString, protocalString)
end

return {openComms = openComms}