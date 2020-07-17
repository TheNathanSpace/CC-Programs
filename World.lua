-- 0.2.2

x = nil
y = nil
z = nil

facing = 1 -- 1 = North, 2 = East, 3 = South, 4 = West

blacklistedTop = false
blacklistedFront = false

storageBlocks = {}
-- Sample: {Type = "minecraft:chest", x = 1180, y = 49, z = 1570}

function CheckBlacklist()
	local blacklistedBlocks = {"chest", "barrel", "storage"}
	
	local inspectSuccess, inspectData = turtle.inspect()
	if(inspectSuccess) then
		for i = 1, 3 do
			if(string.find(inspectData.name, blacklistedBlocks[i])) then
		--		local singleBlock = 
		--		table.insert(storageBlocks, --Thing)
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

function getLocation()
	x, y, z = gps.locate()
	return x, y, z
end

function getFacing()
	return facing
end

function setFacing(newFacing)
	facing = newFacing
end

function Reset()
	blacklistedFront = false
	blacklistedTop = false
end

return {CheckBlacklist = CheckBlacklist, getFrontBlacklist = getFrontBlacklist, getTopBlacklist = getTopBlacklist, getLocation = getLocation, getFacing = getFacing, setFacing = setFacing, Reset = Reset}