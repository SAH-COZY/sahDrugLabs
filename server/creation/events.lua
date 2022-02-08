RegisterNetEvent("sahDrugLabs:CreateDrugLab")
AddEventHandler("sahDrugLabs:CreateDrugLab", function(data)
    local LabId = math.random(10000, 999999)
    local stats_default = {
        TotalSalesPrice = 0,
        TimeRaided = 0,
        SuccessfulSales = 0,
        Resupplies = {failed = 0, success = 0},
        SellsInLS = {failed = 0, success = 0},
        SellsInBC = {failed = 0, success = 0},
        CeasedSupplies = 0,
        CeasedCapacity = 0,
    }
    local upgrades_default = {
        Upgrade1 = false,
        Upgrade2 = false
    }
    MySQL.Async.execute("INSERT INTO druglabs_list (LabId, BusinessType, Stats, Upgrades, Entry) VALUES (@a, @b, @c, @d, @e)", {
        ["@a"] = LabId,
        ["@b"] = data.businessType,
        ["@c"] = json.encode(stats_default),
        ["@d"] = json.encode(upgrades_default),
        ["@e"] = json.encode({x = data.entryCoords.x, y = data.entryCoords.y, z = data.entryCoords.z})
    }, function()
        AllDrugLabs[LabId] = InitDrugLab(LabId, data.businessType, 4, 0, 0, false, false, true, stats_default, upgrades_default, {x = data.entryCoords.x, y = data.entryCoords.y, z = data.entryCoords.z}, false)
        print("^2[sahDrugLabs]^7 Created a laboratory at "..os.date("%H:%M"))
    end)
end)

RegisterNetEvent("sahDrugLabs:AttributeLab")
AddEventHandler("sahDrugLabs:AttributeLab", function(labId)
    local _src = source
    local identifier = GetIdentifierFromId(_src)
    local loadContent = LoadResourceFile(GetCurrentResourceName(), flan)
    loadContent = json.decode(loadContent)
    table.insert(loadContent, identifier)
    SaveResourceFile(GetCurrentResourceName(), "admin_list.json", json.encode(loadContent), -1)
end)



-- PlayerLab = {
--     [1] = {
--         LabId = 1,
--         BusinessType = 2,
--         ProductionState = 4,
--         PercentOfStock = 0,
--         PercentOfSupplies = 0,
--         PlyCanResuply = false,
--         ResupplyCost = 75000,
--         PreparationMade = false,
--         ResupplyButtonState = true,
--         Stats = {
--             TotalSalesPrice = 0,
--             TimeRaided = 0,
--             SuccessfulSales = 0,
--             Resupplies = {failed = 0, success = 0},
--             SellsInLS = {failed = 0, success = 0},
--             SellsInBC = {failed = 0, success = 0},
--             CeasedSupplies = 0,
--             CeasedCapacity = 0,
--         },
--         BuyersList = {
--             [1] = 0,
--             [2] = 0
--         },
--         Upgrades = {
--             Upgrade1 = false,
--             Upgrade2 = false
--         }
--     },
-- }