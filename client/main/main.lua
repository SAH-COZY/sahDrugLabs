MyDrugLabs = nil
LoadAddedZones = false
AddedZones = {}

Citizen.CreateThread(function()
    TriggerServerEvent("sahDrugLabs:GetMyLabs")
    while not MyDrugLabs do
        Wait(500)
    end
    while true do
        local interval = 300
        for k,v in pairs(MyDrugLabs) do
            local pedPos = GetEntityCoords(GetPlayerPed(-1))
            local dist = GetDistanceBetweenCoords(pedPos, v.Entry.x, v.Entry.y, v.Entry.z, true)
            if dist <= 10.0 then
                interval = 1
                DrawMarker(1, v.Entry.x, v.Entry.y, v.Entry.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.6, 255, 255, 255, 175, false, false, 2, false, nil, nil, false)
                if dist <= 1.6 then
                    DisplayHelp("Press ~INPUT_CONTEXT~ to enter in your lab")
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("sahDrugLabs:GetMyLabs")
                        EnterInLab(v)
                    end
                end
            end
        end
        if GetTableSize(AddedZones) > 0 then
            interval = 1
            for k,v in pairs(AddedZones) do
                local pedPos = GetEntityCoords(GetPlayerPed(-1))
                local dist = GetDistanceBetweenCoords(pedPos, v.coords.x, v.coords.y, v.coords.z, true)
                DrawMarker(1, v.coords.x, v.coords.y, v.coords.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.8, 255, 255, 255, 120, false, false, 2, false, nil, nil, false)
                if dist <= 1.1 then
                    DisplayHelp("Press ~INPUT_CONTEXT~ to interact")
                    if IsControlJustReleased(0, 38) then
                        v.action()
                    end
                end
            end
        end
        Wait(interval)
    end
end)

RegisterCommand("getco", function()
    print(GetEntityCoords(GetPlayerPed(-1)))
    print(GetEntityHeading(GetPlayerPed(-1)))
end, false)

RegisterCommand("hidehud", function()
    local hidehudtime = 1000
    Citizen.CreateThread(function()
        while hidehudtime > 0 do
            DisplayRadar(false)
            Wait(1)
        end
        
    end)
end, false)