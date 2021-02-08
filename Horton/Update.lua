-- 0.4.2

local Util = require("Util")

shell.run("delete", "Comms")
os.sleep(.4)
shell.run("delete", "Items")
os.sleep(.4)
shell.run("delete", "live")
os.sleep(.4)
shell.run("delete", "Mapping")
os.sleep(.4)
shell.run("delete", "Movement")
os.sleep(.4)
shell.run("delete", "Pathfinding")
os.sleep(.4)
shell.run("delete", "Update")
os.sleep(.4)
shell.run("delete", "Util")
os.sleep(.4)
shell.run("delete", "World")
os.sleep(.4)

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Comms.lua", "Comms")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Items.lua", "Items")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Live.lua", "live")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Mapping.lua", "Mapping")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Movement.lua", "Movement")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Pathfinding.lua", "Pathfinding")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/Update.lua", "Update")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Util.lua", "Util")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Client/World.lua", "World")
os.sleep(.4)

local fileList = {"Util", "Comms", "Items", "live", "Mapping", "Movement", "Pathfinding", "Update", "World"}

term.clear()

local previousVersionsTable = nil

if fs.exists("VersionHistory.txt") then
	previousVersionsTable = Util.loadTable("VersionHistory.txt")
end

if Util.isEmpty(previousVersionsString) then
	local previousVersionsTable = {Location = "0", Main = "0"}
	Util.saveTable(previousVersionsTable, "VersionHistory.txt")
end

for _,i in ipairs(fileList) do

	local file = fs.open(i, "r")
	local line = file.readLine()
	local version = string.gsub(line, "-", "")
	local version = Util.trimSpaces(version)

	if not (previousVersionsTable[i] == version) then
		print(i, ": ", version, " (prev. ", previousVersionsTable[i], ")")
	else
		print(i, " version: ", version)
	end
	
	previousVersionsTable[i] = version
end

Util.saveTable(previousVersionsTable, "VersionHistory.txt")