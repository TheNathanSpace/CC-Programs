-- 0.1.0

function pinpointFacing()
  while turtle.detect() do
    turtle.turnLeft()
  end
  
  turtle.forward()
end

return {pinpointFacing = pinpointFacing}