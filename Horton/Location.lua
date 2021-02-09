-- 0.1.6

x = nil
y = nil
z = nil

facingNum = nil -- 0 = North, 1 = East, 2 = South, 3 = West

previousLocation = {prevX = nil, prevY = nil, prevZ = nil}


function getLocation()	
	x, y, z = gps.locate()
	
	if (facingNum == nil) and (not (previousLocation.prevX == nil)) then
		setDirection()
	end
end

function turnRight()
  facingNum = facingNum + 1
  
  if (facingNum == 4) then
    facingNum = 0
  end
  
  turtle.turnRight()
  
end

function turnLeft()
  facingNum = facingNum - 1
  
  if (facingNum == -1) then
    facingNum = 3
  end

  turtle.turnLeft()
end


function setDirection()
  if (previousLocation.prevX == nil) or (previousLocation.prevY == nil) or (previousLocation.prevZ == nil) then
    return
  end
  
	if previousLocation.prevX < x then 
		facingNum = 1
	end
	if previousLocation.prevX > x then 
		facingNum = 3
	end
	if previousLocation.prevZ < z then 
		facingNum = 2
	end
	if previousLocation.prevZ > z then 
		facingNum = 0
	end
end

function returnLocation()
	getLocation()
	return x, y, z
end

function getFacingDirection()
	return facingNum
end

function getFacingBlock()
	local facingX, facingY, facingZ = x, y, z
	
	if not (facingX == nil) then
		if facingNum == 0 then facingZ = facingZ - 1 end
		if facingNum == 1 then facingX = facingX + 1 end
		if facingNum == 2 then facingZ = facingZ + 1 end
		if facingNum == 3 then facingX = facingX - 1 end
		
		return facingX, facingY, facingZ
	end
	
	return nil
end

function pinpointFacing()
  while turtle.detect() do
    turtle.turnLeft()
  end
  
  turtle.forward()
end

function Reset()
	previousLocation.prevX = x
	previousLocation.prevY = y
	previousLocation.prevZ = z
end

return {Reset = Reset, getFacingBlock = getFacingBlock, getFacingDirection = getFacingDirection, returnLocation = returnLocation, setDirection = setDirection, getLocation = getLocation, pinpointFacing = pinpointFacing, turnRight = turnRight, turnLeft = turnLeft}