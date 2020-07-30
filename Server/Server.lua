-- 0.2.1

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
		if protocol == "start_mapping_response" then
			print(message)
		end
	end
end

function sendMessages()
	while true do
		local userInput = read()
		if userInput == "call lenny" then
			rednet.broadcast(" ", "lenny_location")
		end
		
		if userInput == "start mapping" then
			rednet.broadcast(" ", "start_mapping")
	end
end

term.clear()

parallel.waitForAll(readMessages, sendMessages)