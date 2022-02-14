MyDrugLabs = nil
LoadAddedZones = false
AddedZones = {}

Citizen.CreateThread(function()
    TriggerServerEvent("sahDrugLabs:GetMyLabs")
    while not MyDrugLabs do
        Wait(500)
    end
    while true do
        if not Laboratories.PlayerPrepareLab then
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
        else
            if Laboratories.PlayerHoldingPacket then
                local pedPos = GetEntityCoords(GetPlayerPed(-1))
                local dist = GetDistanceBetweenCoords(pedPos, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.x, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.y, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.z, true)
                if dist <= 10.0 then
                    interval = 1
                    DrawMarker(1, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.x, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.y, MyDrugLabs[tostring(Laboratories.LabIdInPrepare)].Entry.z-1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.6, 255, 255, 255, 175, false, false, 2, false, nil, nil, false)
                    if dist <= 1.1 then
                        DisplayHelp("Press ~INPUT_CONTEXT~ to deliver a packet")
                        if IsControlJustReleased(0, 38) then
                            Laboratories.PlayerHoldingPacket = false
                            Laboratories.LabPreparePackets.Delivered = Laboratories.LabPreparePackets.Delivered+1
                            Laboratories.CancelAnim(Laboratories.AnimProp)
                            
                            if Laboratories.LabPreparePackets.Delivered == Config.PreparationTrailersMisc.Packets.NbOfPacketsToDeliver then
                                Laboratories:FinishPreparationMission(MyDrugLabs[Laboratories.LabIdInPrepare])
                            end
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)


RegisterCommand("debug", function()
    DoScreenFadeIn(500)
end, false)