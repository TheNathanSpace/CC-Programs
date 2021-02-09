-- 0.1.0

local Util = require("Util")

shell.run("delete", "Main")
os.sleep(.4)
shell.run("delete", "Location")
os.sleep(.4)
shell.run("delete", "Update")
os.sleep(.4)
shell.run("delete", "Util")
os.sleep(.4)

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/horton/Horton/Main.lua", "Main")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/horton/Horton/Location.lua", "Location")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/horton/Horton/Update.lua", "Update")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Util.lua", "Util")
os.sleep(.4)
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/horton/Horton/Mapping.lua", "Mapping")
os.sleep(.4)

local fileList = {"Util", "Main", "Location", "Update", "Mapping"}

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