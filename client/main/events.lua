RegisterNetEvent("sahDrugLabs:ReturnMyLabs")
AddEventHandler("sahDrugLabs:ReturnMyLabs", function(labs_list)
    MyDrugLabs = labs_list
end)

RegisterNetEvent("sahDrugLabs:sendNotificationToPlayer")
AddEventHandler("sahDrugLabs:sendNotificationToPlayer", function(msg)
    DisplayNotification(msg)
end)