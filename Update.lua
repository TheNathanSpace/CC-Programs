-- Update: Version 0.1.0

local Util = require("Util")

shell.run("delete", "live")
shell.run("delete", "World")
shell.run("delete", "Movement")
shell.run("delete", "Items")
shell.run("delete", "Update")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/World.lua", "World")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Movement.lua", "Movement")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Items.lua", "Items")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Update.lua", "Update")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Util.lua", "Util")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Live.lua", "live")

local fileList = {"live", "World", "Movement", "Items", "Update", "Util"}

term.clear()

for _,i in ipairs(fileList) do

	local file = fs.open(i, "r")
	local line = file.readLine()
	local version = string.gsub(line, "-", "")
	local version = trimSpaces(version)

	print(version)
	
end