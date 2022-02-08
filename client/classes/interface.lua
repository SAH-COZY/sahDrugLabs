Interface = {}
setmetatable(Interface, {})

-------------------------------
-- @param Name string
-- @public
-- @return void
-------------------------------
function Interface:SetConnexionName(Name)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_PLAYER_DATA", {
        {type = "string", value = Name},
        {type = "bool", value = true},
    })
end

-------------------------------
-- @param IdLab string
-- @param BusinessType number
-- @param BusinessImage string
-- @param BusinessImage2 string
-- @param BusinessState number
-- @param Price number
-- @param SellPrice number
-- @param StockLevel number
-- @param StockValue number
-- @param SuppliesLevel number
-- @param PlayerCanResuply bool
-- @param AllMoneyEarnedwithBusiness number
-- @param NbOfStoppedProductionsDueToEnnemy number
-- @param TotalSales number
-- @param ResupplyButtonState bool
-- @param ResuplyCost number
-- @public
-- @return void
-------------------------------
function Interface:SetLaboratoryInfos(IdLab, BusinessType, BusinessImage, BusinessImage2, BusinessState, Price, SellPrice, StockLevel, StockValue, SuppliesLevel, PlayerCanResuply, AllMoneyEarnedwithBusiness, NbOfStoppedProductionsDueToEnnemy, TotalSales, ResupplyButtonState, ResuplyCost)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "ADD_BUSINESS", {
        {type = "int", value = IdLab}, -- ID du labo
        {type = "int", value = BusinessType}, -- Business ID (0 = fake docs| 1 = weed | 2 = counterfeit money | 3 = meth lab | 4 = cocain)

        {type = "txt_string", value = BusinessImage},

        {type = "string", value = BusinessImage2},
        {type = "string", value = BusinessImage2},
        {type = "int", value = BusinessState}, -- Status (1 = active, 2 = relaunch in progress, 3 = stopping activity, 4 = Preparation required)

        {type = "int", value = Price},
        {type = "int", value = SellPrice},

        {type = "int", value = StockLevel},-- Stock level (0 - 100%)
        {type = "int", value = StockValue},

        {type = "int", value = SuppliesLevel}, -- Supplies level (0 - 100%)
        {type = "bool", value = PlayerCanResuply},

        {type = "int", value = AllMoneyEarnedwithBusiness},
        {type = "int", value = NbOfStoppedProductionsDueToEnnemy},
        
        {type = "int", value = TotalSales},
        {type = "bool", value = ResupplyButtonState},

        {type = "int", value = ResuplyCost},
    })
end

-------------------------------
-- @param IdLab number
-- @param ProcurementSuccess number
-- @param ProcurementSuccessInLS number
-- @param ProcurementSuccessInBC number
-- @param StoppedProductionRaw number
-- @param StoppedProductionCapacity number
-- @public
-- @return void
-------------------------------
function Interface:SetLaboratoryStats(IdLab, ProcurementSuccess, ProcurementSuccessInLS, ProcurementSuccessInBC, StoppedProductionRaw, StoppedProductionCapacity)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "ADD_BUSINESS_STATS", {
        {type = "int", value = IdLab},
        {type = "int", value = ProcurementSuccess},
        {type = "int", value = ProcurementSuccessInLS},
        {type = "int", value = ProcurementSuccessInBC},
        {type = "int", value = StoppedProductionRaw},
        {type = "int", value = StoppedProductionCapacity},
    })
end

-------------------------------
-- @param IdLab number
-- @param UpgIdx number
-- @param DescName string
-- @param Price number
-- @param TextureDict string
-- @param UpgIdxState number
-- @param isEnable bool
-- @public
-- @return void
-------------------------------
function Interface:SetLaboratoryUpgrade(IdLab, UpgIdx, DescName, Price, TextureDict, isEnable)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "ADD_BUSINESS_UPGRADE", {
        {type = "int", value = IdLab},
        {type = "int", value = UpgIdx},
        {type = "string", value = DescName},
        {type = "int", value = Price},
        {type = "string", value = TextureDict}
    })
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_BUSINESS_UPGRADE_STATUS", {
        {type = "int", value = IdLab},
        {type = "int", value = UpgIdx},
        {type = "bool", value = isEnable},
    })
end

-------------------------------
-- @param isEnable bool
-- @public
-- @return void
-------------------------------
function Interface:SetStartProductionStatus(isEnable)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_START_PRODUCTION_STATUS", {
        {type = "bool", value = isEnable}
    })
end

-------------------------------
-- @param IdLab number
-- @param UpgIdx number
-- @param BuyerName string
-- @param Amount string
-- @param Price number
-- @public
-- @return void
-------------------------------
function Interface:AddBuyer(IdLab, UpgIdx, BuyerName, Amount, Price)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "ADD_BUSINESS_BUYER", {
        {type = "int", value = IdLab},
        {type = "int", value = UpgIdx},
        {type = "string", value = BuyerName},
        {type = "string", value = Amount},
        {type = "int", value = Price},
    })
end

-------------------------------
-- @param x number
-- @param y number
-- @public
-- @return void
-------------------------------
function Interface:SetMouseInput(x, y)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_MOUSE_INPUT", {
        {type = "int", value = x},
        {type = "int", value = y}
    })
end

function Interface:ShowOverlay(message, acceptButtonLabel, cancelButtonLabel, callback)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SHOW_OVERLAY", {
        {type = "string", value = message},
        {type = "string", value = acceptButtonLabel},
        {type = "string", value = cancelButtonLabel},
    })
    Citizen.CreateThread(function()
        local safetime = 2000
        while not buttonSelected do
            if IsControlJustPressed(0, 237) then
                local btn = Scaleform:ExecFunctionWithReturn(sclfrh, "GET_CURRENT_SELECTION")
                if btn == 101 or btn == 102 then
                    callback(btn)
                    return
                end
            end
            safetime = safetime-1
            if safetime <= 0 then
                Interface:HideOverlay()
                return
            end
            Wait(1)
        end
    end)
end

-------------------------------
-- @public
-- @return void
-------------------------------
function Interface:HideOverlay()
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "HIDE_OVERLAY", {})
end

-------------------------------
-- @param screenInt number
-- @public
-- @return void
-------------------------------
function Interface:ShowScreen(screenInt)
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_MOUSE_INPUT", {
        {type = "int", value = screenInt},
    })
end

function Interface:HideScreen()
    Scaleform:ExecFunctionWithVoidReturn(sclfrh, "quit", {})
    show = false
end

-------------------------------
-- @public
-- @return void
-------------------------------
function Interface:RenderMouse(lab)
    Citizen.CreateThread(function()
        while true do
            if not show then
                return
            end

            Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_MOUSE_INPUT", {
                {type = "float", value = GetDisabledControlNormal(2, 239)},
                {type = "float", value = GetDisabledControlNormal(2, 240)},
                {type = "int", value = -1},
            })

            --Mouse left click		
            if IsControlJustPressed(1, 237) then
                Scaleform:ExecFunctionWithVoidReturn(sclfrh, "SET_INPUT_EVENT", {
                    {type = "int", value = 237},
                })
                local buttonId = Scaleform:ExecFunctionWithReturn(sclfrh, "GET_CURRENT_SELECTION")
                if DoesActionExist(tostring(buttonId)) then
                    ExecuteAction(tostring(buttonId), lab)
                end
            end
            Wait(1)
        end
    end)
end

-------------------------------
-- @public
-- @return void
-------------------------------
function Interface:BlockInputEvents()
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 1, true)
    DisableControlAction(0, 2, true)
    DisableControlAction(0, 200, true)
    DisableControlAction(2, 242, true)
    DisableControlAction(2, 241, true)
    DisableControlAction(2, 257, true)

    DisableControlAction(0, 14, true)
    DisableControlAction(0, 15, true)
    DisableControlAction(0, 16, true)
    DisableControlAction(0, 17, true)

    if IsDisabledControlJustReleased(0, 200) then
        Scaleform:ExecFunctionWithVoidReturn(sclfrh, "quit", {})

        show = false
    end
end