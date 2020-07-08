blacklistedTop = false
blacklistedFront = false

function CheckBlacklist()
	local blacklistedBlocks = {"chest", "barrel", "storage"}
	
    local inspectSuccess, inspectData = turtle.inspect()
    if(inspectSuccess) then
		for i = 1, 2 do
			if(string.match(inspectData.name, blacklistedBlocks[i])) then
				blacklistedFront = true
			end
		end
    end
	
	local inspectSuccess, inspectData = turtle.inspectUp()
    if(inspectSuccess) then
		for i = 1, 2 do
			if(string.match(inspectData.name, blacklistedBlocks[i])) then
				blacklistedTop = true
			end
		end
    end
end

function Reset()
	blacklistedFront = false
	blacklistedTop = false
end