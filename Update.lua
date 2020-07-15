-- 0.1.3

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

if fs.exists("VersionHistory.txt") then
	local versionHistory = fs.open("VersionHistory.txt", "r")
	local previousVersionsString = versionHistory.readLine()
else
	local versionHistory = fs.open("VersionHistory.txt", "w")
	local previousVersionsString = "{World = "0", Movement = "0", Items = "0", Update = "0", Util = "0", live = "0"}
	versionHistory.write(previousVersionsString)
	versionHistory.close()
	
	local versionHistory = fs.open("VersionHistory.txt", "r")
	local previousVersionsString = versionHistory.readLine()
end

local previousVersionsTable = load(previousVersionsString)()

versionHistory.close()

for _,i in ipairs(fileList) do

	local file = fs.open(i, "r")
	local line = file.readLine()
	local version = string.gsub(line, "-", "")
	local version = Util.trimSpaces(version)


	if not (previousVersionsTable[i] == version) then
		print(i, " Version: ", version, " (previously ", previousVersionsTable[i])
	else
		print(i, " Version: ", version)
	end
	
	previousVersionsTable[i] = version
end

local versionHistory = fs.open("VersionHistory.txt", "w")

versionHistory.write(table.tostring(previousVersionsTable))
versionHistory.close()