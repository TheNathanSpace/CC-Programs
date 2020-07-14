local htmlparser = require("htmlparser")

function trim1(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

shell.run("delete", "live")
shell.run("delete", "WorldAPI")
shell.run("delete", "MovementAPI")
shell.run("delete", "ItemsAPI")
shell.run("delete", "Update")
shell.run("delete", "UpdateHTML")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/World.lua", "WorldAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Movement.lua", "MovementAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Items.lua", "ItemsAPI")
shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Update.lua", "Update")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/UpdateHTML.lua", "UpdateHTML")

shell.run("wget", "https://thekingelessar.github.io/CC-Programs/Live.lua", "live")

local liveFile = fs.open("live", "r")
local line = liveFile.readLine()
local version = string.gsub(line, "-", "")
version = trim1(version)

term.clear()

print(version)