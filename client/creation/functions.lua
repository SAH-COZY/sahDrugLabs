local vein = exports.vein
local labelWidth = 0.1
local types = {
    {type = "Weed", checked = false, businessType = 1},--Business ID (0 = fake docs| 1 = weed | 2 = counterfeit money | 3 = meth lab | 4 = cocain)
    {type = "Meth", checked = false, businessType = 3},
    {type = "Counterfeit Money", checked = false, businessType = 2},
    {type = "Cocain", checked = false, businessType = 4}
}


function drawLabel(text)
	vein:setNextWidgetWidth(labelWidth)
	vein:label(text)
end

function InitLabCreation()
    local actualChecked = nil
	local windowX
	local windowY
	local isWindowOpened = true
    local infosError = false

    local Data = {
        entryCoords = {x = 0.0, y = 0.0, z = 0.0},
        businessType = nil
    }

	while isWindowOpened do
		Citizen.Wait(0)

		vein:beginWindow(windowX, windowY)

		vein:heading('Laboratory Creation')

        if infosError then
            vein:beginRow()
			    drawLabel("~r~Missing args~w~")
		    vein:endRow()
        end

        vein:beginRow()
			vein:separator(0.366)
		vein:endRow()

		vein:beginRow()
			drawLabel('Laboratory Type')
            
            if actualChecked then Data.businessType = types[actualChecked].businessType end
            for k,v in pairs(types) do
                if v.checked and actualChecked ~= k then
                    actualChecked = k
                    for k2,v2 in pairs(types) do
                        if k ~= k2 then v2.checked = false end
                    end
                end
                v.checked = vein:checkBox(v.checked, v.type)
            end
            
		vein:endRow()

        vein:beginRow()
			drawLabel('Laboratory Entry Coords')
            vein:spacing()
            vein:spacing()
            vein:spacing()
            if vein:button('Actual Position') then
                local plyPed = PlayerPedId()
                local plyPedPos = GetEntityCoords(plyPed)
                Data.entryCoords.x = plyPedPos.x
                Data.entryCoords.y = plyPedPos.y
                Data.entryCoords.z = plyPedPos.z
            end
		vein:endRow()


		vein:beginRow()
			vein:separator(0.366)
		vein:endRow()

        vein:beginRow()
            drawLabel("X = "..Data.entryCoords.x.." | ".."Y = "..Data.entryCoords.y.." | ".."Z = "..Data.entryCoords.z)
        vein:endRow()

		vein:spacing()

        vein:beginRow()
            if vein:button('Close') then
                isWindowOpened = false
            end

            if vein:button('Create') then
                if (Data.entryCoords.x+Data.entryCoords.y+Data.entryCoords.z) ~= 0.0 and Data.businessType then
                    RegisterLab(Data)
                    isWindowOpened = false
                else
                    infosError = true
                    SetTimeout(5000, function()
                        infosError = false
                    end)
                end
            end
		vein:endRow()
        

		windowX, windowY = vein:endWindow()
	end
end

function InitLabAttrib()
	local windowX
	local windowY
    local header = 'Laboratory Attribution'
	local isWindowOpened = true

    TriggerServerEvent("sahDrugLabs:GetAllLabsWData")

    while not NotOwnedLabs do
        Wait(1)
    end

    local i_start, i_end, i_max = 1, 5, 5

    Wait(200)

    if i_end > GetTableSize(NotOwnedLabs) then i_end = GetTableSize(NotOwnedLabs) end

	while isWindowOpened do
		Citizen.Wait(0)

		vein:beginWindow(windowX, windowY)
        vein:heading(header)

        if GetTableSize(NotOwnedLabs) > 0 then
            for i = i_start, i_end, 1 do
                vein:beginRow()
                    drawLabel('Laboratory n°'..NotOwnedLabs[i].LabId)
                    print(NotOwnedLabs[i].BusinessType)
                    drawLabel("Business Type: "..GetBusinessNameFromId(NotOwnedLabs[i].BusinessType))
                    for i = 1, 7, 1 do
                        vein:spacing()
                    end
                    if vein:button('Attribute') then
                        TriggerServerEvent("sahDrugLabs:AttribLaboratory")
                    end
                    if vein:button('Delete') then
                        isWindowOpened = false
                        DeleteLab(NotOwnedLabs[i].LabId)
                        InitLabAttrib()
                    end
                vein:endRow()
            end
        else
            drawLabel("~r~No laboratory available")
        end
        vein:beginRow()
            if i_start > i_max then
                if vein:button('← Previous page') then
                    i_end = i_start-1
                    if (i_start - i_max) == 1 then
                        i_start = 1
                    else
                        i_start = i_start-i_max
                    end
                end
            end
            if GetTableSize(NotOwnedLabs) > i_end then
                if vein:button('Next page →') then
                    i_start = i_end+1
                    if GetTableSize(NotOwnedLabs) < i_end+i_max then
                        i_end = GetTableSize(NotOwnedLabs)
                    else
                        i_end = i_end+i_max
                    end
                end
            end
        vein:endRow()
        
        if vein:button('Close') then
            isWindowOpened = false
        end
		windowX, windowY = vein:endWindow()
	end
end

-- function Pop_Up(origin_func, cbyes)
--     local windowX
-- 	local windowY
-- 	local isWindowOpened = true

--     while isWindowOpened do
-- 		Citizen.Wait(0)
--         vein:beginWindow(windowX, windowY)
--         vein:heading("Are you sure ?")

--         vein:beginRow()
--             if vein:button('Yes') then
--                 isWindowOpened = false
--                 cbyes()
--                 origin_func()
--             end
--             if vein:button('No') then
--                 isWindowOpened = false
--                 origin_func()
--             end
--         vein:endRow()
--     end
-- end

function RegisterLab(data)
    local AllData = {entryCoords = data.entryCoords, businessType = data.businessType}
    TriggerServerEvent("sahDrugLabs:CreateDrugLab", AllData)
    DisplayNotification("~g~Laboratory has been created !")
end

function DeleteLab(data)
    TriggerServerEvent("sahDrugLabs:DeleteLab", data)
end

RegisterCommand("su", InitLabAttrib, false)