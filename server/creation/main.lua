RegisterCommand("create-lab", function(src, args)
    if src ~= 0 then
        TriggerClientEvent("sahDrugLabs:InitLabCreation", src)
    end
end, false)