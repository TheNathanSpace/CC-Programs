-- 0.2.0

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")
local Comms = require("Comms")

shell.run("label", "set", "Lenny")
Comms.openComms()

term.clear()
shell.run("clear")

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
	Movement.DetermineMovement()
	DrawDisplay()
	Reset()
end

while true do
	Tick()
	
	if(Items.getHealth() <= 0) then
		print("He has killed me, mother")
		break
	end
end