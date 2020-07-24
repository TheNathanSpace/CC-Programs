-- 0.3.4

local World = require("World")
local Items = require("Items")

turnTo = 0

speed = 5
moveChance = 0
turnChance = 0
turning = false

function ChangeDirection(isRandom)
	if(isRandom) then
		turnTo = math.random(1, 4)
		while(turnTo == World.getFacing()) do
			turnTo = math.random(1, 4)
		end
	end
	
	turning = true
end

function mapSpeed()
	if Items.getSpeedItems() >= 5 then
		speed = 0
		return
	end
	
	local speedMap = {5, 4, 3, 2, 1}
	speed = speedMap[Items.getSpeedItems() + 1]
end

function DetermineMovement() -- Only running like every 5 ticks or something
	if(turning) then
		if(not (World.getFacing() == turnTo)) then
			turtle.turnRight()
			World.setFacing(World.getFacing() + 1)
			
			if(World.getFacing() == 5) then
				World.setFacing(1)
			end
		else
			turning = false
		end
	end
	
	if(turtle.detect()) then
		turnChance = 101
	end
	
	if speed == 0 then
		speed = 5
	end
	
	if(moveChance >= speed) then
		if(turnChance >= 10) then
			ChangeDirection(true)
			turnChance = 0
		else
			turnChance = turnChance + 1
			turtle.forward()
		end
		
		moveChance = 0
	else
		moveChance = moveChance + 1
	end
end

return {DetermineMovement = DetermineMovement, moveChance = moveChance}