RegisterNetEvent('sahDrugLabs:InitLabCreation')
AddEventHandler('sahDrugLabs:InitLabCreation', function()
    InitLabCreation()
end)

RegisterNetEvent('sahDrugLabs:InitLabAttribution')
AddEventHandler('sahDrugLabs:InitLabAttribution', function()
    InitLabAttrib()
end)

RegisterNetEvent("sahDrugLabs:ReturnAllLabsWData")
AddEventHandler("sahDrugLabs:ReturnAllLabsWData", function(data)
    NotOwnedLabs = data
end)