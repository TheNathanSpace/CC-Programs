-- 0.1.5

health = 50
changed = false
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
	local oldBricks = GetInventory("brick")
	
	World.CheckBlacklist()

	if(not World.getFrontBlacklist()) then
		local suckForward = turtle.suck()
	end
	
	if(not World.getTopBlacklist()) then
		local suckUp = turtle.suckUp()
	end

	local newBricks = GetInventory("brick")
	
	if(newBricks > oldBricks) then
		Scream()
		local change = newBricks - oldBricks
		changed = true
		health = health - change
	end
end

function getHealth()
	return health
end

function getChanged()
	return changed
end

function Reset()
	changed = false
end

return {GetInventory = GetInventory, CheckForItems = CheckForItems, getHealth = getHealth, getChanged = getChanged, Reset = Reset}