local Util = require("Util")

shell.run("delete", "live")
shell.run("delete", "WorldAPI")
shell.run("delete", "MovementAPI")
shell.run("delete", "ItemsAPI")
shell.run("delete", "Update")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/World.lua", "WorldAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Movement.lua", "MovementAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Items.lua", "ItemsAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Update.lua", "Update")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Util.lua", "Util")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Live.lua", "live")

term.clear()

local file = fs.open("live", "r")
local line = file.readLine()
local version = string.gsub(line, "-", "")
local versionLive = trimSpaces(version)

print(versionLive)