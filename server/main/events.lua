RegisterNetEvent("sahDrugLabs:GetMyLabs")
AddEventHandler("sahDrugLabs:GetMyLabs", function(newsrc)
    local _src
    if newsrc then _src = newsrc else _src = source end 
    local plyIdentifier = GetIdentifierFromId(_src)
    local player_labs = {}
    while not AllDrugLabsLoaded do
        Wait(20)
    end
    for k,v in pairs(AllDrugLabs) do
        if (v.Owner == plyIdentifier and v.Bought) or ValueInTable(plyIdentifier, v.Co_Owners) then
            player_labs[tostring(v.LabId)] = v.returnMinLabData()
        end
    end
    TriggerClientEvent("sahDrugLabs:ReturnMyLabs", _src, player_labs)
end)

RegisterNetEvent("sahDrugLabs:PreparationMade")
AddEventHandler("sahDrugLabs:PreparationMade", function(labid, success)
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    local DrugLab, ValidDrugLab = GetDrugLabFromId(labid)
    if DrugLab.Owner == identifier then
        DrugLab.prepareLab(success)
    end
    local player_labs = {}
    for k,v in pairs(AllDrugLabs) do
        if (v.Owner == plyIdentifier and v.Bought) or ValueInTable(plyIdentifier, v.Co_Owners) then
            player_labs[tostring(v.LabId)] = v
        end
    end
    TriggerClientEvent("sahDrugLabs:ReturnMyLabs", _src, player_labs)
end)

RegisterNetEvent("sahDrugLabs:GetAllLabsWData")
AddEventHandler("sahDrugLabs:GetAllLabsWData", function(all_clients)
    local _src = source
    local all_labs = {}
    for k,v in pairs(AllDrugLabs) do
        if (not v.Bought) then
            print(v.BusinessType)
            table.insert(all_labs, {BusinessType = v.BusinessType, LabId = v.LabId})
        end
    end
    if not all_clients then
        TriggerClientEvent("sahDrugLabs:ReturnAllLabsWData", _src, all_labs)
    else
        TriggerClientEvent("sahDrugLabs:ReturnAllLabsWData", -1, all_labs)
    end
end)

RegisterNetEvent("sahDrugLabs:DeleteLab")
AddEventHandler("sahDrugLabs:DeleteLab", function(labId)
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    if PlayerIsAdmin(identifier) then
        local DrugLab, IsValid = GetDrugLabFromId(labId)
        print(json.encode(DrugLab.returnMinLabData()))
        if IsValid then
            MySQL.Async.execute("DELETE FROM `druglabs_list` WHERE LabId = @a", {
                ["@a"] = labId
            }, function(result)
                if result == 1 then
                    print("Successfully deleted lab n°"..labId)
                else
                    print("Lab n°"..labId.." was not deleted")
                end
                local DrugLab = GetDrugLabFromId(labId)
                MoveLabToRecycleBin(DrugLab.returnMinLabData())
                AllDrugLabs[tostring(labId)] = nil
                TriggerEvent("sahDrugLabs:GetAllLabsWData", true)
            end)
        end
    end
end)