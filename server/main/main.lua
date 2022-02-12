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