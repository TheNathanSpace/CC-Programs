-- 0.4.5

function hasValue (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

function hasKey (tab, keyToTry)
	for key, value in pairs(tab) do
		if key == keyToTry then
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

function split(text, delim)
    -- returns an array of fields based on text and delimiter (one character only)
    local result = {}
    local magic = "().%+-*?[]^$"

    if delim == nil then
        delim = "%s"
    elseif string.find(delim, magic, 1, true) then
        -- escape magic
        delim = "%"..delim
    end

    local pattern = "[^"..delim.."]+"
    for w in string.gmatch(text, pattern) do
        table.insert(result, w)
    end
    return result
end

function createLocationKey(x, z)
	return x .. "/" .. z
end

function parseLocationKey(stringKey)
	local parsedTable = split(stringKey, "/")
	return parsedTable[1], parsedTable[2]
end

function getFirstKey(tablex)
	print(textutils.serialize(tablex))
	for key, value in tablex do
		return key
	end
end

function removeKey(t, k)
	local i = 0
	local keys, values = {},{}
	for k,v in pairs(t) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end

	while i>0 do
		if keys[i] == k then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end

	local a = {}
	for i = 1,#keys do
		a[keys[i]] = values[i]
	end

	return a
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function reverseTable(t)
  local newTable = {}
  local n = #t
  local i = 1
  while i < n do
    newTable[i],newTable[n] = t[n],t[i]
    i = i + 1
    n = n - 1
  end
  
  return newTable
end

return {hasValue = hasValue, hasKey = hasKey, trimSpaces = trimSpaces, isEmpty = isEmpty, saveTable = saveTable, loadTable = loadTable, printTable = printTable, split = split, createLocationKey = createLocationKey, parseLocationKey = parseLocationKey, getFirstKey = getFirstKey, removeKey = removeKey, deepcopy = deepcopy, tablelength = tablelength, reverseTable = reverseTable}
