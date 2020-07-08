health = 50

function Scream()
	local sounds = {"quark:entity.stoneling.die"}
	local key = math.random(1, 1)
	local sound = sounds[key]

    peripheral.find("speaker").playSound(sound, math.random(0, 3), math.random(0, 2))
end

function CheckForItems()
	local oldBricks = GetInventory("brick") -- Count bricks
	
	WorldAPI.CheckBlacklist()

    if(not WorldAPI.blacklistedFront) then -- Picks up items
        local suckForward = turtle.suck()
    end
	
    if(not WorldAPI.blacklistedTop) then
        local suckUp = turtle.suckUp()
    end

	local newBricks = GetInventory("brick") -- Counts bricks
	
    if(newBricks > oldBricks) then -- If picked up bricks
        Scream()
		local change = newBricks - oldBricks -- Difference
		health = health - change
    end
end

function GetInventory(item)
	local itemCount = 0
	
	for i = 1, 16 do
		local isNil = (turtle.getItemDetail(i) == nil)
		if(not isNil) then
			local name = turtle.getItemDetail(i).name
			local count = turtle.getItemDetail(i).count
			if(string.match(name, item)) then
				itemCount = itemCount + count
			end
		end
	end
	
	return itemCount
end

function Reset()
end