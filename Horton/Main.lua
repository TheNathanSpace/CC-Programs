-- 0.1.0

local Location = require("Location")

shell.run("label", "set", "Horton")
rednet.open("left")

term.clear()
shell.run("clear")

for i = 0, 13 do
	print(" ")
	term.clear()
end

function writeScreen()
  for i = 0, 13 do
    print(" ")
    term.clear()
  end
  local x, y, z = Location.returnLocation()
  print(x .. " " .. y .. " " .. z)
end

function Reset()
	Location.Reset()
end

function Tick()
	Location.getLocation()
	Reset()
end
