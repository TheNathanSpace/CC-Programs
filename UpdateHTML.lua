shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser.lua", "htmlparser.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/ElementNode.lua", "htmlparser/ElementNode.lua")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/lua-htmlparser/htmlparser/voidelements.lua", "htmlparser/voidelements.lua")

local htmlparser = require("htmlparser")

shell.run("wget", "https://github.com/TheKingElessar/CC-Programs/blob/master/Live.lua", "live")

local full_html = fs.open("live", "r").readAll()

local root = htmlparser.parse(full_html)

local table_element = root:select("tbody")

local nodes = table_element.nodes

for i = 1, #nodes, 1 do 
   print(nodes[i].name) 
end