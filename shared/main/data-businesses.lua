BusinessTypeInfos = {
    ["0"] = {
        CustomBusinessName = nil,
        DefaultBusinessName = "Document Forgery Office",
        BusinessNameHash = 0x1FD5DA04,
        AddonBusinessType = false,
        AddonBusinessTypeBasedOn = nil,
        Load = function()
            BikerDocumentForgery.LoadDefault()
            BikerDocumentForgery.Style.Set(BikerDocumentForgery.Style.basic)
            BikerDocumentForgery.Equipment.Clear()
            BikerDocumentForgery.Security.Set(BikerDocumentForgery.Security.basic)
            BikerDocumentForgery.Details.Enable({
                BikerDocumentForgery.Details.production,
                BikerDocumentForgery.Details.furnitures,
                BikerDocumentForgery.Details.clutter,
                BikerDocumentForgery.Details.Chairs.A,
                BikerDocumentForgery.Details.Chairs.B,
                BikerDocumentForgery.Details.Chairs.C,
                BikerDocumentForgery.Details.Chairs.D,
                BikerDocumentForgery.Details.Chairs.E,
                BikerDocumentForgery.Details.Chairs.F,
                BikerDocumentForgery.Details.Chairs.G
            }, false)
        end,
        LoadAfterPrepare = function()
            BikerDocumentForgery.Style.Set(BikerDocumentForgery.Style.basic)
            BikerDocumentForgery.Equipment.Set(BikerDocumentForgery.Equipment.basic)
            BikerDocumentForgery.Security.Set(BikerDocumentForgery.Security.basic)
            BikerDocumentForgery.Details.Enable({
                BikerDocumentForgery.Details.production,
                BikerDocumentForgery.Details.furnitures,
                BikerDocumentForgery.Details.clutter,
                BikerDocumentForgery.Details.Chairs.A,
                BikerDocumentForgery.Details.Chairs.B,
                BikerDocumentForgery.Details.Chairs.C,
                BikerDocumentForgery.Details.Chairs.D,
                BikerDocumentForgery.Details.Chairs.E,
                BikerDocumentForgery.Details.Chairs.F,
                BikerDocumentForgery.Details.Chairs.G
            }, true)
        end,
        PricePerPercent = {min = 200, max = 300},
        Update1 = {
            Index = 1,
            Desc = "OR_UPG_0",
            Price = 20000,
            Txd = "fake_id_upg_0",
            Enabled = true
        },
        Update2 = {
            Index = 2,
            Desc = "OR_UPG_1",
            Price = 45000,
            Txd = "fake_id_upg_2",
            Enabled = true
        },
        Coords = {
            Manage = vector3(1160.311, -3192.19, -39.00798)
        },
        Position = vector3(1173.688, -3196.566, -39.00798),
        Heading = 93.139312744141
    },
    ["1"] = {
        CustomBusinessName = nil,
        DefaultBusinessName = "Weed Farm",
        BusinessNameHash = 0xEBE9A168,
        AddonBusinessType = false,
        AddonBusinessTypeBasedOn = nil,
        Load = function()
            BikerWeedFarm.LoadDefault()
            BikerWeedFarm.Style.Clear()
            BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic)

            BikerWeedFarm.Plant1.Clear()
            BikerWeedFarm.Plant2.Clear()
            BikerWeedFarm.Plant3.Clear()
            BikerWeedFarm.Plant4.Clear()
            BikerWeedFarm.Plant5.Clear()
            BikerWeedFarm.Plant6.Clear()
            BikerWeedFarm.Plant7.Clear()
            BikerWeedFarm.Plant8.Clear()
            BikerWeedFarm.Plant9.Clear()

            BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.fans, BikerWeedFarm.Details.drying, BikerWeedFarm.Details.chairs}, false)
        end,
        LoadAfterPrepare = function()
            BikerWeedFarm.LoadDefault()
            BikerWeedFarm.Plant1.Set(BikerWeedFarm.Plant1.Stage.medium, BikerWeedFarm.Plant1.Light.basic, true)
            BikerWeedFarm.Plant2.Set(BikerWeedFarm.Plant2.Stage.medium, BikerWeedFarm.Plant2.Light.basic, true)
            BikerWeedFarm.Plant3.Set(BikerWeedFarm.Plant3.Stage.medium, BikerWeedFarm.Plant3.Light.basic, true)
            BikerWeedFarm.Plant4.Set(BikerWeedFarm.Plant4.Stage.medium, BikerWeedFarm.Plant4.Light.basic, true)
            BikerWeedFarm.Plant5.Set(BikerWeedFarm.Plant5.Stage.medium, BikerWeedFarm.Plant5.Light.basic, true)
            BikerWeedFarm.Plant6.Set(BikerWeedFarm.Plant6.Stage.medium, BikerWeedFarm.Plant6.Light.basic, true)
            BikerWeedFarm.Plant7.Clear()
            BikerWeedFarm.Plant8.Clear()
            BikerWeedFarm.Plant9.Clear()
            BikerWeedFarm.Security.Set(BikerWeedFarm.Security.basic, true)

            BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.fans, BikerWeedFarm.Details.drying, BikerWeedFarm.Details.chairs}, true)
        end,
        PricePerPercent = {min = 200, max = 300},
        Update1 = {
            Index = 1,
            Desc = "OR_UPG_0",
            Price = 20000,
            Txd = "weed_upg_0",
            Enabled = true
        },
        Update2 = {
            Index = 2,
            Desc = "OR_UPG_1",
            Price = 45000,
            Txd = "weed_upg_2",
            Enabled = true
        },
        Coords = {
            Manage = vector3(1044.345, -3194.897, -38.15845)
        },
        Position = vector3(1066.012, -3183.457, -39.16352),
        Heading = 84.350593566895
    },
    ["2"] = {
        CustomBusinessName = nil,
        DefaultBusinessName = "Counterfeit Cash Factory",
        BusinessNameHash = 0x6A5A379B,
        AddonBusinessType = false,
        AddonBusinessTypeBasedOn = nil,
        PricePerPercent = {min = 200, max = 300},
        Load = function()
            BikerCounterfeit.LoadDefault()
            BikerCounterfeit.Printer.Set({BikerCounterfeit.Printer.none})
            BikerCounterfeit.Security.Clear()
            BikerCounterfeit.Dryer1.Set(BikerCounterfeit.Dryer1.none)
            BikerCounterfeit.Dryer2.Set(BikerCounterfeit.Dryer2.none)
            BikerCounterfeit.Dryer3.Set(BikerCounterfeit.Dryer3.none)
            BikerCounterfeit.Dryer4.Set(BikerCounterfeit.Dryer4.none)
            BikerCounterfeit.Details.Enable({BikerCounterfeit.Details.chairs, BikerCounterfeit.Details.furnitures, BikerCounterfeit.Details.cutter, BikerCounterfeit.Details.Cash10.A, BikerCounterfeit.Details.Cash10.B, BikerCounterfeit.Details.Cash10.C, BikerCounterfeit.Details.Cash10.D, BikerCounterfeit.Details.Cash20.A, BikerCounterfeit.Details.Cash20.B, BikerCounterfeit.Details.Cash20.C, BikerCounterfeit.Details.Cash20.D, BikerCounterfeit.Details.Cash100.A, BikerCounterfeit.Details.Cash100.B, BikerCounterfeit.Details.Cash100.C, BikerCounterfeit.Details.Cash100.D}, false)
        end,
        LoadAfterPrepare = function()
            BikerCounterfeit.LoadDefault()
            BikerCounterfeit.Printer.Set({BikerCounterfeit.Printer.basicProd}, true)
            BikerCounterfeit.Security.Set(BikerCounterfeit.Security.basic, true)
            BikerCounterfeit.Dryer1.Set(BikerCounterfeit.Dryer1.open)
            BikerCounterfeit.Dryer2.Set(BikerCounterfeit.Dryer2.open)
            BikerCounterfeit.Dryer3.Set(BikerCounterfeit.Dryer3.none)
            BikerCounterfeit.Dryer4.Set(BikerCounterfeit.Dryer4.none)
        end,
        Update1 = {
            Index = 1,
            Desc = "OR_UPG_0",
            Price = 20000,
            Txd = "fakecash_upg_0",
            Enabled = true
        },
        Update2 = {
            Index = 2,
            Desc = "OR_UPG_1",
            Price = 45000,
            Txd = "fakecash_upg_2",
            Enabled = true
        },
        Coords = {
            Manage = vector3(1129.538, -3194.225, -40.397)
        },
        Position = vector3(1137.901, -3198.877, -39.66574),
        Heading = 10.07
    },
    ["3"] = {
        CustomBusinessName = nil,
        DefaultBusinessName = "Methamphetamine Lab",
        BusinessNameHash = 0x0B3E74AE,
        AddonBusinessType = false,
        AddonBusinessTypeBasedOn = nil,
        PricePerPercent = {min = 200, max = 300},
        Load = function()
            BikerMethLab.LoadDefault()
            BikerMethLab.Style.Set(BikerMethLab.Style.empty, true)
        end,
        LoadAfterPrepare = function()
            BikerMethLab.LoadDefault()
            BikerMethLab.Style.Set(BikerMethLab.Style.basic, true)
        end,
        Update1 = {
            Index = 1,
            Desc = "OR_UPG_0",
            Price = 20000,
            Txd = "meth_upg_0",
            Enabled = true,
            SetInIPL = function()
                BikerMethLab.Style.Set(BikerMethLab.Style.upgrade, true)
            end
        },
        Update2 = {
            Index = 2,
            Desc = "OR_UPG_1",
            Price = 45000,
            Txd = "meth_upg_2",
            Enabled = true,
            SetInIPL = function()
                BikerMethLab.Security.Set(BikerMethLab.Security.upgrade, true)
            end
        },
        Coords = {
            Manage = vector3(1001.937, -3194.937, -38.99313)
        },
        Position = vector3(997.2639, -3200.603, -36.39372),
        Heading = 269.33056640625
    },
    ["4"] = {
        CustomBusinessName = nil,
        DefaultBusinessName = "Cocaine Lockup",
        BusinessNameHash = 0xC29562E3,
        AddonBusinessType = false,
        AddonBusinessTypeBasedOn = nil,
        PricePerPercent = {min = 200, max = 300},
        Load = function()
            BikerCocaine.Style.Set(BikerCocaine.Style.basic, true)
            BikerCocaine.Security.Set(BikerCocaine.Security.none)
            BikerCocaine.Details.Enable({
                BikerCocaine.Details.cokeBasic1,
                BikerCocaine.Details.cokeBasic2,
                BikerCocaine.Details.cokeBasic3,
                BikerCocaine.Details.cokeUpgrade1,
                BikerCocaine.Details.cokeUpgrade2,
            }, false, false)
        end,
        LoadAfterPrepare = function()
            BikerCocaine.Style.Set(BikerCocaine.Style.basic, true)
            BikerCocaine.Security.Set(BikerCocaine.Security.basic, true)
            BikerCocaine.Details.Enable({
                BikerCocaine.Details.cokeBasic1,
                BikerCocaine.Details.cokeBasic2,
                BikerCocaine.Details.cokeBasic3,
            }, true, true)
            BikerCocaine.Details.Enable({
                BikerCocaine.Details.cokeUpgrade1,
                BikerCocaine.Details.cokeUpgrade2
            }, false)
        end,
        Update1 = {
            Index = 1,
            Desc = "OR_UPG_0",
            Price = 20000,
            Txd = "coke_upg_0",
            Enabled = true,
            SetInIPL = function()
                BikerCocaine.LoadDefault()
                BikerCocaine.Style.Set(BikerCocaine.Style.upgrade, true)
            end
        },
        Update2 = {
            Index = 2,
            Desc = "OR_UPG_1",
            Price = 45000,
            Txd = "coke_upg_2",
            Enabled = true,
            SetInIPL = function()
                BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
            end
        },
        Coords = {
            Manage = vector3(1087.445, -3194.247, -38.99348)
        },
        Position = vector3(1088.655, -3187.725, -38.99347),
        Heading = 181.589187762204
    },

--------------------------------------------------------------------------------
--=========================     ADD-ON BUSINESSES    =========================--
--------------------------------------------------------------------------------
    ------------ EXAMPLE ----------
    -- ["5"] = {
    --     CustomBusinessName = nil,
    --     DefaultBusinessName = "Advanced Weed Farm",
    --     BusinessNameHash = 0xEBE9A168,
    --     AddonBusinessType = true,
    --     AddonBusinessTypeBasedOn = 1,
    --     PricePerPercent = {min = 200, max = 300},
    --     Load = function()
            
    --     end,
    --     LoadAfterPrepare = function()
            
    --     end,
    --     Update1 = {
    --         Index = 1,
    --         Desc = "OR_UPG_0",
    --         Price = 20000,
    --         Txd = "advweed_upg_0",
    --         Enabled = true,
    --         SetInIPL = function()
                
    --         end
    --     },
    --     Update2 = {
    --         Index = 2,
    --         Desc = "OR_UPG_1",
    --         Price = 45000,
    --         Txd = "advweed_upg_2",
    --         Enabled = true,
    --         SetInIPL = function()
                
    --         end
    --     },
    --     Coords = {
    --         Manage = vector3(-320.117, -1347.739, 24.90427)
    --     },
    --     Position = vector3(-323.2448, -1356.107, 31.41664),
    --     Heading = 267.84408569336
    -- }
    ------------ ------- ----------
--------------------------------------------------------------------------------
--============================================================================--
--------------------------------------------------------------------------------
}