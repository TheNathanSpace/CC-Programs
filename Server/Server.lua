-- 0.1.1

function readMessages()
	while true do
		rednet.open("top")
		local senderId, message, protocol = rednet.receive()
		if protocol == "lenny_location_response" then
			print(message)
		end
		if protocol == "lenny_scared" then
			print(message)
		end
	end
end

function sendMessages()
	while true do
		local userInput = read()
		if read == "call lenny" then
			rednet.broadcast(" ", "lenny_location")
		end
	end
end

parallel.waitForAll(readMessages, sendMessages)