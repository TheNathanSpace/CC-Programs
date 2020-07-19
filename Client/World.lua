-- 0.3.0

x = nil
y = nil
z = nil

facingNum = 1 -- 1 = North, 2 = East, 3 = South, 4 = West
facingDirection = "unknown" -- Calculate by checking change in location

previousLocation = {prevX = nil, prevY = nil, prevZ = nil}

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
	
	if not (previousLocation.prevX == nil) then
		getDirection()
	end
end

function getDirection()
	if previousLocation.prevX < x then facingDirection = "east" end
	if previousLocation.prevX > x then facingDirection = "west" end
	if previousLocation.prevZ < z then facingDirection = "south" end
	if previousLocation.prevZ > z then facingDirection = "north" end
end

function returnLocation()
	return x, y, z
end

function returnDirection()
	return facingDirection
end

function returnStatus()
	return x .. " " .. y .. " " .. z .. " (facing " .. facingDirection .. ")"
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
	
	previousLocation.prevX = x
	previousLocation.prevY = y
	previousLocation.prevZ = z
end

return {CheckBlacklist = CheckBlacklist, getFrontBlacklist = getFrontBlacklist, getTopBlacklist = getTopBlacklist, getLocation = getLocation, returnLocation = returnLocation, returnDirection = returnDirection, returnStatus = returnStatus, getFacing = getFacing, setFacing = setFacing, Reset = Reset}