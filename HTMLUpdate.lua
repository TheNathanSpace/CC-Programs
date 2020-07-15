-- HTMLUpdate: Version 0.1.0

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

if (not fs.exists("htmlparser.lua")) or (not fs.exists("htmlparser/ElementNode.lua")) or (not fs.exists("htmlparser/voidelements.lua")) then
	shell.run("delete", "htmlparser.lua")
	shell.run("delete", "htmlparser/ElementNode.lua")
	shell.run("delete", "htmlparser/voidelements.lua")

	shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser.lua", "htmlparser.lua")
	shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/ElementNode.lua", "htmlparser/ElementNode.lua")
	shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/voidelements.lua", "htmlparser/voidelements.lua")
end

local htmlparser = require("htmlparser")

shell.run("delete", "live")

shell.run("wget", "https://github.com/TheKingElessar/CC-Programs/blob/master/Live.lua", "live")

local live_file = fs.open("live", "r")

local full_html = live_file.readAll()

live_file.close()

local root = htmlparser.parse(full_html)

local table_element = root:select(".js-file-line-container")[1]

local line_array = {}

for _,e in ipairs(table_element.nodes) do
	
	local td_level = e.nodes
	
	for _,q in ipairs(td_level) do
		if has_value(q.classes, "js-file-line") then
			table.insert(line_array, q:getcontent())
			print(q:getcontent())
		end
	end
	
end

shell.run("delete", "live")

local live_file = fs.open("live", "a")

for i = 1, #line_array do
--	print(line_array[i])
	live_file.writeLine(line_array[i])
end

live_file.close()