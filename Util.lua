function has_value (tab, val)
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
