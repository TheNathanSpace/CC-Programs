-- 0.1.0

x = 1672
y = 42
z = -4115

facing = 0 -- 1 = North, 2 = East, 3 = South, 4 = West
turnTo = 0

moveChance = 0
turnChance = 0
turning = false

function ChangeDirection(isRandom)
	if(isRandom) then
		turnTo = math.random(1, 4)
	end
	
	turning = true
end

function DetermineMovement() -- Only running like every 5 ticks or something
	print("DetermineMovement")
	if(turning) then
		if(not (facing == turnTo)) then
			turtle.turnRight()
			facing = facing + 1
			
			if(facing == 5) then
				facing = 1
			end
		else
			turning = false
		end
	end
	
	if(turtle.detect()) then
		turnChance = 101
	end
	
	if(moveChance >= 5) then
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