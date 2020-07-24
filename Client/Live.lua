-- 0.3.2

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")
local Comms = require("Comms")

shell.run("label", "set", "Lenny")
rednet.open("left")

term.clear()
shell.run("clear")

peripheral.find("speaker").playSound("quark:entity.stoneling.michael", 3, 3)

for i = 0, 13 do
	print(" ")
	term.clear()
end

print("Health: ", Items.getHealth())

function DrawDisplay()
	if (not (Items.getHealth() <= 0)) and (Items.getChanged() == true) then
		term.clear()
		print("Health: ", Items.getHealth())
	end
end

function Reset()
	World.Reset()
	Items.Reset()
end

function Tick()
	Items.CheckForItems()
	World.getLocation()
	Movement.DetermineMovement()
	Comms.pickUp()
	DrawDisplay()
	Reset()
end

function main_live()
	while true do
		Tick()
		
		if(Items.getHealth() <= 0) then
			print("No one's ever really gone.")
			break
		end
	end
end

parallel.waitForAll(main_live, Comms.openComms)  