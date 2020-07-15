-- 0.1.0

health = 50
local World = require("World")

function Scream()
	local sounds = {"quark:entity.stoneling.die"}
	local key = math.random(1, 1)
	local sound = sounds[key]

	peripheral.find("speaker").playSound(sound, math.random(0, 3), math.random(0, 2))
end

function GetInventory(itemString)
	local itemCount = 0
	
	for i = 1, 16 do
		if(turtle.getItemDetail(i)) then
			local name = turtle.getItemDetail(i).name
			if(string.find(name, itemString)) then
				local count = turtle.getItemDetail(i).count
				itemCount = itemCount + count
			end
		end
	end
	
	return itemCount
end

function CheckForItems()
	print("CheckForItems")
	local oldBricks = GetInventory("brick") -- Count bricks
	
	World.CheckBlacklist()

	if(not World.blacklistedFront) then -- Picks up items
		local suckForward = turtle.suck()
	end
	
	if(not World.blacklistedTop) then
		local suckUp = turtle.suckUp()
	end

	local newBricks = GetInventory("brick") -- Counts bricks
	
	if(newBricks > oldBricks) then -- If picked up bricks
		Scream()
		local change = newBricks - oldBricks -- Difference
		health = health - change
	end
end

function Reset()
end

return {GetInventory = GetInventory, CheckForItems = CheckForItems, health = health, Reset = Reset}