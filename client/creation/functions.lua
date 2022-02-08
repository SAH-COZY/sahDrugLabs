function InitLabCreation()
    local stage = 0
    local all_data = {}
    Citizen.CreateThread(function()
        while true do
            if stage < GetTableSize(StagesTypes) then
                StagesTypes[tostring(stage)](function(newstage, dat)
                    if dat then
                        all_data[tostring(stage)] = dat
                    end
                    stage = newstage
                end, stage)
            else
                RegisterLab(all_data)
                return
            end
            

            if stage == -1 then
                return
            end
            Wait(1)
        end
    end)
end

function RegisterLab(data)
    local AllData = {entryCoords = data["2"].pos, businessType = data["1"].businessType}
    TriggerServerEvent("sahDrugLabs:CreateDrugLab", AllData)
    DisplayNotification("~g~Laboratory has been created !")
end