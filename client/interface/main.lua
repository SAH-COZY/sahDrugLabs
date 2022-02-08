show = false
sclfrh = nil

Citizen.CreateThread(function()
    RequestStreamedTextureDict("biker_businesses", true)
    while not HasStreamedTextureDictLoaded("biker_businesses") do
        Wait(1)
    end
    RequestStreamedTextureDict("mp_bwh_generic", true)
    while not HasStreamedTextureDictLoaded("mp_bwh_generic") do
        Wait(1)
    end
    sclfrh = Scaleform:LoadScaleformMovie("BIKER_BUSINESSES")
    AddTextEntry('YES', 'Oui')
    AddTextEntry('NO', 'Non')
end)

function ShowInterface(data)
    if show then
        show = false
        return
    end
    show = true

    Citizen.CreateThread(function()
        if BusinessTypeInfos[tostring(data.BusinessType)].CustomBusinessName then
            AddTextEntryByHash(BusinessTypeInfos[tostring(data.BusinessType)].BusinessNameHash, BusinessTypeInfos[tostring(data.BusinessType)].CustomBusinessName)
        else
            AddTextEntryByHash(BusinessTypeInfos[tostring(data.BusinessType)].BusinessNameHash, BusinessTypeInfos[tostring(data.BusinessType)].DefaultBusinessName)
        end
        Interface:SetConnexionName("Admin")
        if not BusinessTypeInfos[tostring(data.BusinessType)].AddonBusinessType then
            Interface:SetLaboratoryInfos(data.LabId, data.BusinessType, nil, nil, data.ProductionState, 0, 0, data.PercentOfStock, 0, data.PercentOfSupplies, data.PlyCanResuply, data.Stats.TotalSalesPrice, data.Stats.TimeRaided, data.Stats.SuccessfulSales, data.ResupplyButtonState, data.ResupplyCost)
        else
            Interface:SetLaboratoryInfos(data.LabId, BusinessTypeInfos[tostring(data.BusinessType)].AddonBusinessTypeBasedOn, nil, nil, data.ProductionState, 0, 0, data.PercentOfStock, 0, data.PercentOfSupplies, data.PlyCanResuply, data.Stats.TotalSalesPrice, data.Stats.TimeRaided, data.Stats.SuccessfulSales, data.ResupplyButtonState, data.ResupplyCost)
        end
        local resupplyPercent = GetSuccessfulResupplyPercent(data)
        local salesPercentLS, salesPercentBC = GetSalesPercent(data)
        Interface:SetLaboratoryStats(data.LabId, resupplyPercent, salesPercentLS, salesPercentBC, data.Stats.CeasedSupplies, data.Stats.CeasedCapacity)
        if data.ProductionState == 1 then
            Interface:SetLaboratoryUpgrade(data.LabId, BusinessTypeInfos[tostring(data.BusinessType)].Update1.Index, BusinessTypeInfos[tostring(data.BusinessType)].Update1.Desc, BusinessTypeInfos[tostring(data.BusinessType)].Update1.Price, BusinessTypeInfos[tostring(data.BusinessType)].Update1.Txd, (BusinessTypeInfos[tostring(data.BusinessType)].Update1.Enabled ~= data.Upgrades.Upgrade1))
            Interface:SetLaboratoryUpgrade(data.LabId, BusinessTypeInfos[tostring(data.BusinessType)].Update2.Index, BusinessTypeInfos[tostring(data.BusinessType)].Update2.Desc, BusinessTypeInfos[tostring(data.BusinessType)].Update2.Price, BusinessTypeInfos[tostring(data.BusinessType)].Update2.Txd, (BusinessTypeInfos[tostring(data.BusinessType)].Update2.Enabled ~= data.Upgrades.Upgrade2))
            if data.PercentOfStock > 10 then
                if data.BuyersList[1] == 0 then
                    local sellPrice = math.random(BusinessTypeInfos[tostring(data.BusinessType)].PricePerPercent.min, BusinessTypeInfos[tostring(data.BusinessType)].PricePerPercent.max)*data.PercentOfStock
                    Interface:AddBuyer(1, 1, "OR_BYR_DETAILS1", "OR_GOODS_BYR1", sellPrice)
                    data.BuyersList[1] = sellPrice
                else
                    Interface:AddBuyer(1, 2, "OR_BYR_DETAILS2", "OR_GOODS_BYR2", data.BuyersList[1])
                end
                if data.PercentOfStock > 75 then
                    if data.BuyersList[2] == 0 then
                        local sellPrice2 = math.random(BusinessTypeInfos[tostring(data.BusinessType)].PricePerPercent.min, BusinessTypeInfos[tostring(data.BusinessType)].PricePerPercent.max)*data.PercentOfStock
                        data.BuyersList[2] = sellPrice2
                        Interface:AddBuyer(1, 2, "OR_BYR_DETAILS1", "OR_GOODS_BYR1", sellPrice2)
                    else
                        Interface:AddBuyer(1, 2, "OR_BYR_DETAILS2", "OR_GOODS_BYR2", data.BuyersList[2])
                    end
                end
            end
        end
        Interface:SetStartProductionStatus(data.PreparationMade)
        Interface:SetMouseInput(0.5, 0.4)
        Interface:ShowScreen(5)
        Interface:RenderMouse(data)
        while show do
            Interface:BlockInputEvents()
            DrawScaleformMovieFullscreen(sclfrh, 255, 255, 255, 255)
            if not show then
                return
            end
            Wait(1)
        end
    end)
end

RegisterCommand("exit-loading", function()
    DoScreenFadeIn(500)
end, false)