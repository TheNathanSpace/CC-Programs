-- 0.1.14

shell.run("label", "set", "Lenny")

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")

term.clear()

function DrawDisplay()
--	term.clear()
--	print("Mood: ", "Bad go away dexter")
--	if(not (Items.health <= 0)) then
--		print("Health: ", Items.health)
--	end
end

function Reset()
	World.Reset()
    Items.Reset()
end

function Tick()
	term.clear()
	print("------")
	print("Tick")
    Items.CheckForItems()
	Movement.DetermineMovement()
	DrawDisplay()
	print(Movement.moveChance)
	print("------")
    Reset()
end

while true do
    Tick()
	
	if(Items.health <= 0) then
		print("He has killed me, mother")
		break
	end
end