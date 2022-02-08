function DoesActionExist(action)
    if ActionsTable[action] then
        return true
    else
        return false
    end
end

function ExecuteAction(action, lab)
    ActionsTable[action](lab)
end

function GetSalesPercent(lab)
    local sellsPercentInLS = 0
    local sellsPercentInBC = 0
    if lab.Stats.SellsInLS.success == 0 and lab.Stats.SellsInLS.failed == 0 then
        sellsPercentInLS = 0
    else
        sellsPercentInLS = math.floor(100*lab.Stats.SellsInLS.success/(lab.Stats.SellsInLS.success+lab.Stats.SellsInLS.failed))
    end
    if lab.Stats.SellsInBC.success == 0 and lab.Stats.SellsInLS.failed == 0 then
        sellsPercentInBC = 0
    else
        sellsPercentInBC = math.floor(100*lab.Stats.SellsInBC.success/(lab.Stats.SellsInBC.success+lab.Stats.SellsInBC.failed))
    end
    return sellsPercentInLS, sellsPercentInBC
end

function GetSuccessfulResupplyPercent(lab)
    local successfulResupplies = 0
    if lab.Stats.Resupplies.success == 0 and lab.Stats.Resupplies.failed == 0 then
        successfulResupplies = 0
    else
        successfulResupplies = math.floor(100*lab.Stats.Resupplies.success/(lab.Stats.Resupplies.success+lab.Stats.Resupplies.failed))
    end
    return successfulResupplies
end