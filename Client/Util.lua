-- 0.2.0

function hasValue (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function trimSpaces(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function isEmpty(s)
	return s == nil or s == ''
end

function saveTable(tableObject, fileName)
	local file = fs.open(fileName,"w")
	file.write(textutils.serialize(tableObject))
	file.close()
end

function loadTable(fileName)
	local file = fs.open(fileName,"r")
	local data = file.readAll()
	file.close()
	return textutils.unserialize(data)
end

function printTable(tableObject)
	return textutils.serialize(tableObject)
end

return {has_value = has_value, trimSpaces = trimSpaces, isEmpty = isEmpty, saveTable = saveTable, loadTable = loadTable, printTable = printTable}
