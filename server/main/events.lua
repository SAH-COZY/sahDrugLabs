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
            player_labs[tostring(v.LabId)] = v
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

RegisterNetEvent("sahDrugLabs:AttributeLab")
AddEventHandler("sahDrugLabs:AttributeLab", function(labId)
    local _src = source
    
end)