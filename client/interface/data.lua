ActionsTable = {
    ["3014"] = function(lab)
        Interface:ShowOverlay("Êtes-vous sûr de vouloir acheter des matières premières ?", 'YES', 'NO', function(selectedButton)
            if selectedButton == 101 then
                DoScreenFadeOut(500)
                Wait(2500)
                Interface:HideScreen()
                lab.PercentOfSupplies = 100
                lab.Stats.Resupplies.success = lab.Stats.Resupplies.success + 1
                DoScreenFadeIn(500)
            else
                Interface:HideOverlay()
            end
        end)
    end,
    ["3005"] = function(lab)
        Interface:ShowOverlay("Êtes-vous sûr de vouloir arrêter la production du laboratoire ?", 'YES', 'NO', function(selectedButton)
            if selectedButton == 101 then
                DoScreenFadeOut(500)
                Wait(2500)
                Interface:HideScreen()
                lab.ProductionState = 2
                lab.PreparationMade = true
                lab.ResupplyButtonState = false
                DoScreenFadeIn(500)
            else
                Interface:HideOverlay()
            end
        end)
    end,
    ["3006"] = function(lab)
        if lab.PlyCanResuply then
            Interface:ShowOverlay("Êtes-vous sûr de vouloir relancer la production du laboratoire ?", 'YES', 'NO', function(selectedButton)
                if selectedButton == 101 then
                    DoScreenFadeOut(500)
                    Wait(2500)
                    Interface:HideScreen()
                    lab.ProductionState = 1
                    lab.ResupplyButtonState = true
                    DoScreenFadeIn(500)
                else
                    Interface:HideOverlay()
                end
            end)
        end
    end,
    ["3003"] = function(lab)
        Interface:ShowOverlay("Êtes-vous sûr de vouloir lancer la préparation du laboratoire ?", 'YES', 'NO', function(selectedButton)
            if selectedButton == 101 then
                DoScreenFadeOut(500)
                Wait(2500)
                Interface:HideScreen()
                Laboratories:InitLabPreparation(lab)
                DoScreenFadeIn(500)
            else
                Interface:HideOverlay()
            end
        end)
    end,
    ["3011"] = function(lab)
        Interface:ShowOverlay("Êtes-vous sûr de vouloir vendre votre stock ?", 'YES', 'NO', function(selectedButton)
            if selectedButton == 101 then
                DoScreenFadeOut(500)
                Wait(2500)
                Interface:HideScreen()
                lab.PercentOfStock = 0
                lab.Stats.TotalSalesPrice = lab.Stats.TotalSalesPrice + lab.BuyersList[1]
                lab.Stats.SuccessfulSales = lab.Stats.SuccessfulSales + 1
                lab.Stats.SellsInLS.success = lab.Stats.SellsInLS.success + 1
                DoScreenFadeIn(500)
            else
                Interface:HideOverlay()
            end
        end)
    end,
    ["3012"] = function(lab)
        Interface:ShowOverlay("Êtes-vous sûr de vouloir vendre votre stock ?", 'YES', 'NO', function(selectedButton)
            if selectedButton == 101 then
                DoScreenFadeOut(500)
                Wait(2500)
                Interface:HideScreen()
                lab.PercentOfStock = 0
                lab.Stats.TotalSalesPrice = lab.Stats.TotalSalesPrice + lab.BuyersList[2]
                lab.Stats.SuccessfulSales = lab.Stats.SuccessfulSales + 1
                lab.Stats.SellsInBC.success = lab.Stats.SellsInBC.success + 1
                DoScreenFadeIn(500)
            else
                Interface:HideOverlay()
            end
        end)
    end,
    ["3008"] = function(lab)
        if not lab.Upgrades.Upgrade1 then
            Interface:ShowOverlay("Êtes-vous sûr de vouloir acheter l'amélioration de matériel ?", 'YES', 'NO', function(selectedButton)
                if selectedButton == 101 then
                    DoScreenFadeOut(500)
                    Wait(2500)
                    Interface:HideScreen()
                    lab.Upgrades.Upgrade1 = true
                    DoScreenFadeIn(500)
                else
                    Interface:HideOverlay()
                end
            end)
        end
    end,
    ["3009"] = function(lab)
        if not lab.Upgrades.Upgrade2 then
            Interface:ShowOverlay("Êtes-vous sûr de vouloir acheter l'amélioration de sécurité ?", 'YES', 'NO', function(selectedButton)
                if selectedButton == 101 then
                    DoScreenFadeOut(500)
                    Wait(2500)
                    Interface:HideScreen()
                    lab.Upgrades.Upgrade2 = true
                    DoScreenFadeIn(500)
                else
                    Interface:HideOverlay()
                end
            end)
        end
    end,
    ["101"] = function()
        Interface:HideOverlay()
    end
}