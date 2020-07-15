shell.run("delete", "live")
shell.run("delete", "htmlparser.lua")
shell.run("delete", "htmlparser/ElementNode.lua")
shell.run("delete", "htmlparser/voidelements.lua")

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser.lua", "htmlparser.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/ElementNode.lua", "htmlparser/ElementNode.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/voidelements.lua", "htmlparser/voidelements.lua")

local htmlparser = require("htmlparser")

shell.run("wget", "https://github.com/TheKingElessar/CC-Programs/blob/master/Live.lua", "live")

local live_file = fs.open("live", "r")

local full_html = live_file.readAll()

live_file.close()

local root = htmlparser.parse(full_html)

local table_element = root:select(".js-file-line-container")[1]

local line_array = {}


for _,e in ipairs(table_element.nodes) do
	for q = 1, #e.classes do
		if e.classes[q] == "js-file-line" then
			table.insert(line_array, e:getcontent())
		end
	end
end

shell.run("delete", "live")

local live_file = fs.open("live", "a")

for i = 1, #line_array do
	print(line_array[i])
	live_file.append(line_arry[i])
end