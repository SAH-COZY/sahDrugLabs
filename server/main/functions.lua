function GetDrugLabFromId(id)
    local id = tostring(id)
    if AllDrugLabs[id] then
        return AllDrugLabs[id], true
    end
    return nil, false
end

function DoesPlayerOwnLab(labid, identifier)
    local DrugLab = GetDrugLabFromId(labid)
    if DrugLab.Owner == identifier then
        return true
    end
    return false
end

function GetIdentifierFromId(playerid)
    for k,v in pairs(GetPlayerIdentifiers(playerid)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end    
end