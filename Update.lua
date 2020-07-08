shell.run("delete", "live")
shell.run("delete", "WorldAPI")
shell.run("delete", "MovementAPI")
shell.run("delete", "ItemsAPI")
shell.run("delete", "Update")

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/World.lua", "WorldAPI")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Movement.lua", "MovementAPI")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Items.lua", "ItemsAPI")
shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Update.lua", "Update")

shell.run("wget", "https://raw.githubusercontent.com/TheKingElessar/CC-Programs/master/Live.lua", "live")