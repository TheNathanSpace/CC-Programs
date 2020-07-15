-- 0.1.0

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

return {has_value = has_value, trimSpaces = trimSpaces, isEmpty = isEmpty}