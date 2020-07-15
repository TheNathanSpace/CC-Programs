-- 0.1.15

shell.run("label", "set", "Lenny")

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")

term.clear()

function DrawDisplay()
--	print("Mood: ", "Bad go away dexter")
--	if(not (Items.health <= 0)) then
--		print("Health: ", Items.health)
--	end
end

function Reset()
	World.Reset()
	Items.Reset()
--	term.clear()
end

function Tick()
	Items.CheckForItems()
	Movement.DetermineMovement()
	print(World.blacklistedTop)
	print(World.blacklistedFront)
	DrawDisplay()
	Reset()
end

while true do
	Tick()
	
	if(Items.health <= 0) then
		print("He has killed me, mother")
		break
	end
end