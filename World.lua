-- 0.1.8

blacklistedTop = false
blacklistedFront = false

function CheckBlacklist()
	local blacklistedBlocks = {"chest", "barrel", "storage"}
	
	local inspectSuccess, inspectData = turtle.inspect()
	if(inspectSuccess) then
		for i = 1, 3 do
			if(string.find(inspectData.name, blacklistedBlocks[i])) then
				blacklistedFront = true
			end
		end
	end
	
	local inspectSuccess, inspectData = turtle.inspectUp()
	if(inspectSuccess) then
		for i = 1, 3 do
			if(string.find(inspectData.name, blacklistedBlocks[i])) then
				blacklistedTop = true
			end
		end
	end
end

function getFrontBlacklist()
	return blacklistedFront
end

function getTopBlacklist()
	return blacklistedTop
end

function Reset()
	blacklistedFront = false
	blacklistedTop = false
end

return {CheckBlacklist = CheckBlacklist, getFrontBlacklist = getFrontBlacklist, getTopBlacklist = getTopBlacklist, Reset = Reset}