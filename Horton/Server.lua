-- 0.1.1

function readMessages()
	while true do
		rednet.open("left")
		local senderId, message, protocol = rednet.receive()
		if protocol == "start_mapping_response" then
			print(message)
		end
	end
end

function sendMessages()
	while true do
		local userInput = read()
		if userInput == "start_mapping" then
			rednet.broadcast(" ", "start_mapping")
		end
	end
end

for i = 0, 13 do
	print(" ")
	term.clear()
end

parallel.waitForAll(readMessages, sendMessages)