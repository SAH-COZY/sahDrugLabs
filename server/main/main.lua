AllDrugLabs = {}
AllDrugLabsLoaded = false

Citizen.CreateThread(function()
    MySQL.ready(function()
        MySQL.Async.fetchAll("SELECT * FROM druglabs_list", {}, function(result)
            for k,v in pairs(result) do
                AllDrugLabs[tostring(v.LabId)] = InitDrugLab(v.LabId, v.Owner, json.decode(v.Co_Owners), v.BusinessType, v.ProductionState, v.PercentOfStock, v.PercentOfSupplies, tobool(v.PlyCanResuply), tobool(v.PreparationMade), tobool(v.ResupplyButtonState), json.decode(v.Stats), json.decode(v.Upgrades), json.decode(v.Entry), tobool(v.Bought))
            end
            AllDrugLabsLoaded = true
        end)
    end)
end)

RegisterCommand("attrib_lab", function(src, args)
    if src ~= 0 and args[1] and args[2] then
        local DrugLab = GetDrugLabFromId(args[1])
        DrugLab.setLabOwned(GetIdentifierFromId(src))
    end
end, false)