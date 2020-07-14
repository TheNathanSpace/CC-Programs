shell.run("delete", "live")
shell.run("delete", "htmlparser.lua")
shell.run("delete", "htmlparser/ElementNode.lua")
shell.run("delete", "htmlparser/voidelements.lua")

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser.lua", "htmlparser.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/ElementNode.lua", "htmlparser/ElementNode.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/voidelements.lua", "htmlparser/voidelements.lua")

local htmlparser = require("htmlparser")

shell.run("wget", "https://github.com/TheKingElessar/CC-Programs/blob/master/Live.lua", "live")

local full_html = fs.open("live", "r").readAll()

local root = htmlparser.parse(full_html)

local table_element = root:select("tbody")

for _,e in ipairs(table_element) do
	print(e.name)
	-- local subs = e(subselectorstring)
	-- for _,sub in ipairs(subs) do
		-- print("", sub.name)
	-- end
end

local nodes = table_element.nodes

--for i = 1, #nodes, 1 do 
--   print(nodes[i].name) 
--end