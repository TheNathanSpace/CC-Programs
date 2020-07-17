-- 0.1.19

shell.run("label", "set", "Lenny")

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")

term.clear()

function DrawDisplay()
	if(not (Items.getHealth() <= 0)) then
		print("Health: ", Items.getHealth())
	end
end

function Reset()
	World.Reset()
	Items.Reset()
	term.clear()
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