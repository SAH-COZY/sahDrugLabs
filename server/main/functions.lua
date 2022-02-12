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

function PlayerIsAdmin(identifier)
    if file_exists("./admin_list.json") then
        local loadContent = json.decode(LoadResourceFile(GetCurrentResourceName(), "admin_list.json"))
        if type(loadContent) == "table" then
            if ValueInTable(identifier, loadContent) then
                return true
            end
            return false
        end
        return false
    else
        return false
    end 
end

function MoveLabToRecycleBin(labInfos)
    local content = LoadResourceFile(GetCurrentResourceName(), "./bin/"..labInfos.LabId.."_deleted")
    if not content then
        content = labInfos
    end
    SaveResourceFile(GetCurrentResourceName(), "./bin/"..labInfos.LabId.."_deleted", json.encode(content), -1)
end