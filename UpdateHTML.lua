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

local line_arry = {}


for _,e in ipairs(table_element.nodes) do
	table.insert(line_arry, e:getcontent())
end

shell.run("delete", "live")

local live_file = fs.open("live", "a")

for i = 0, #line_arry do
	live_file.append(line_arry[i])
end