-- 0.4.4

local World = require("World")
local Movement = require("Movement")
local Items = require("Items")
local Comms = require("Comms")
local Mapping = require("Mapping")
local Pathfinding = require("Pathfinding")

shell.run("label", "set", "Lenny")
rednet.open("left")

term.clear()
shell.run("clear")

peripheral.find("speaker").playSound("quark:entity.stoneling.michael", 3, 1)

for i = 0, 13 do
	print(" ")
	term.clear()
end

print("Health: ", Items.getHealth())

function getDeathMessage()
	local deathMessages = {"No one's ever really gone.", "I will burn like the heathen kings of old!", "The Lenny that dances twice as hard dances half as long.", "Why is fuel set to DOUBLE TRUUUUUEEEEEEEEE", "I gave you all I had... I did..."}
	return deathMessages[math.random(1, #deathMessages)]
end

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
	World.getLocation()
	Items.CheckForItems()
	Comms.pickUp()
	Movement.DetermineMovement()
	DrawDisplay()
	Reset()
end

function main_live()
	while true do
		if Mapping.getCurrentlyMapping() or Pathfinding.getCurrentlyPathfinding() then
			sleep(20)
		end
		
		if (not Mapping.getCurrentlyMapping()) and (not Pathfinding.getCurrentlyPathfinding()) then
			Tick()
			
			if(Items.getHealth() <= 0) then
				print("Health: ", Items.getHealth())
				print(getDeathMessage())
				break
			end
		end

	end
end

parallel.waitForAll(main_live, Comms.openComms)  