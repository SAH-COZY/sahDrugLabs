function GetTableSize(t)
    local c = 0
    for k,v in pairs(t) do
        c = c+1
    end
    return c
end

function tobool(str)
    if str == "true" then
        return true
    elseif str == "false" then
        return false
    end
end

function ValueInTable(val, tab)
    for k,v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end