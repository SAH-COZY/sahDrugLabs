function InitDrugLab(LabId, Owner, Co_Owners, BusinessType, ProductionState, PercentOfStock, PercentOfSupplies, PlyCanResuply, PreparationMade, ResupplyButtonState, Stats, Upgrades, Entry, Bought)
    self = {}
    self.LabId = LabId
    self.Owner = Owner
    self.Co_Owners = Co_Owners
    self.BusinessType = BusinessType
    self.ProductionState = ProductionState
    self.PercentOfStock = PercentOfStock
    self.PercentOfSupplies = PercentOfSupplies
    self.PlyCanResuply = PlyCanResuply
    self.PreparationMade = PreparationMade
    self.ResupplyButtonState = ResupplyButtonState
    self.Stats = Stats
    self.Upgrades = Upgrades
    self.Entry = Entry
    self.Bought = Bought

    self.returnMinLabData = function()
        return {
            LabId = self.LabId,
            Owner = self.Owner,
            Co_Owners = self.Co_Owners,
            BusinessType = self.BusinessType,
            ProductionState = self.ProductionState,
            PercentOfStock = self.PercentOfStock,
            PercentOfSupplies = self.PercentOfSupplies,
            PlyCanResuply = self.PlyCanResuply,
            PreparationMade = self.PreparationMade,
            ResupplyButtonState = self.ResupplyButtonState,
            Stats = self.Stats,
            Upgrades = self.Upgrades,
            Entry = self.Entry,
            Bought = self.Bought,
        }
    end

    self.setLabOwned = function(plyId)
        if plyId then
            self.Owner = GetIdentifierFromId(plyId)
            self.Bought = true
            self.saveLab()
            TriggerEvent("sahDrugLabs:GetMyLabs", plyId)
        end
    end

    self.addCoOwner = function(src, targetId)
        local targetIdentifier = GetIdentifierFromId(targetId)
        if ValueInTable(targetIdentifier, self.Co_Owners) then return end
        if GetIdentifierFromId(src) == self.Owner then
            table.insert(self.Co_Owners, targetIdentifier)
            TriggerEvent("sahDrugLabs:GetMyLabs", targetId)
            TriggerClientEvent("sahDrugLabs:sendNotificationToPlayer", targetId, "You have now access to a new lab. Check on your map to have the location !")
        end
    end

    self.removeCoOwner = function(src, targetId)
        local targetIdentifier = GetIdentifierFromId(targetId)
        if not ValueInTable(targetIdentifier, self.Co_Owners) then return end
        if GetIdentifierFromId(src) == self.Owner then
            for k,v in pairs(self.Co_Owners) do
                if v == targetIdentifier then
                    table.remove(k)
                    TriggerEvent("sahDrugLabs:GetMyLabs", targetId)
                end
            end
        end
    end

    self.setProductionState = function(newProductionState)
        if newProductionState and newProductionState >= 0 and newProductionState <= 4 then
            self.ProductionState = newProductionState
            -- Update owner labs list and infos
        end
    end

    self.addPercentOfStock = function(percent)
        if self.PercentOfStock+percent <= 100 then
            self.PercentOfStock = self.PercentOfStock+percent
        end
    end

    self.removePercentOfStock = function(percent)
        if self.PercentOfStock-percent >= 0 then
            self.PercentOfStock = self.PercentOfStock-percent
        end
    end

    self.setPercentOfStock = function(percent)
        self.PercentOfStock = percent
    end

    self.addPercentOfSupplies = function(percent)
        if self.PercentOfSupplies+percent <= 100 then
            self.PercentOfSupplies = self.PercentOfSupplies+percent
        end
    end

    self.removePercentOfSupplies = function(percent)
        if self.PercentOfSupplies-percent >= 0 then
            self.PercentOfSupplies = self.PercentOfSupplies-percent
        end
    end

    self.setPercentOfSupplies = function(percent)
        self.PercentOfSupplies = percent
    end

    self.addUpgrade = function(upgradeid)
        if upgradeid == 1 then
            self.Upgrades.Upgrade1 = true
        elseif upgradeid == 2 then
            self.Upgrades.Upgrade2 = true
        end
    end

    self.saveLab = function()
        MySQL.Async.execute("UPDATE druglabs_list SET Owner = @a, Co_Owners = @m, ProductionState = @b, PercentOfStock = @c, PercentOfSupplies = @d, PlyCanResuply = @e, PreparationMade = @f, ResupplyButtonState = @g, Stats = @h, Upgrades = @i, Entry = @j, Bought = @k WHERE LabId = @l", {
            ["@a"] = self.Owner,
            ["@m"] = json.encode(self.Co_Owners),
            ["@b"] = self.ProductionState,
            ["@c"] = self.PercentOfStock,
            ["@d"] = self.PercentOfSupplies,
            ["@e"] = tostring(self.PlyCanResuply),
            ["@f"] = tostring(self.PreparationMade),
            ["@g"] = tostring(self.ResupplyButtonState),
            ["@h"] = json.encode(self.Stats),
            ["@i"] = json.encode(self.Upgrades),
            ["@j"] = json.encode(self.Entry),
            ["@k"] = tostring(self.Bought),
            ["@l"] = self.LabId
        })
    end

    self.saleDrug = function(LSorBC, success, amount)
        if LSorBC == "LS" then
            if success then
                self.Stats.SellsInLS.success = self.Stats.SellsInLS.success+1
                self.Stats.SuccessfulSales = self.Stats.SuccessfulSales+1
                self.Stats.TotalSalesPrice = self.Stats.TotalSalesPrice+amount
            else
                self.Stats.SellsInLS.failed = self.Stats.SellsInLS.failed+1
            end
        elseif LSorBC == "BC" then
            if success then
                self.Stats.SellsInBC.success = self.Stats.SellsInBC.success+1
                self.Stats.SuccessfulSales = self.Stats.SuccessfulSales+1
                self.Stats.TotalSalesPrice = self.Stats.TotalSalesPrice+amount
            else
                self.Stats.SellsInBC.failed = self.Stats.SellsInBC.failed+1
            end
        end
        self.saveLab()
    end

    self.resuppliedLab = function(success)
        if success then
            self.Stats.Resupplies.success = self.Stats.Resupplies.success+1
        else
            self.Stats.Resupplies.failed = self.Stats.Resupplies.failed+1
        end
        self.saveLab()
    end

    self.prepareLab = function(success)
        if success then
            self.ProductionState = 1
            self.PercentOfSupplies = 100
            self.PlyCanResuply = true
            self.PreparationMade = true
            self.saveLab()
        end
    end

    return self
end