RegisterCommand("addAdminToList", function(src, args, raw)
    if src == 0 and args[1] then
        local target_id = tostring(args[1])
        local target_identifier = GetIdentifierFromId(target_id)
        if target_identifier then
            local loadContent = json.decode(LoadResourceFile(GetCurrentResourceName(), "admin_list.json"))
            if loadContent then
                if not ValueInTable(target_identifier, loadContent) then
                    table.insert(loadContent, target_identifier)
                else
                    print("^1Error - Player is already set as admin^7")
                end
            else
                loadContent = {}
                table.insert(loadContent, target_identifier)
                needToRepair = true
            end
            SaveResourceFile(GetCurrentResourceName(), "admin_list.json", json.encode(loadContent), -1)
            if needToRepair then
                print("^1Error - JSON File Doesn't exists. Creation in progress...^7")
                local timeout = 10000
                while not file_exists("./admin_list.json") do
                    timeout = timeout - 500
                    if timeout <= 0 then
                        print("^1File was not repaired, try to create the file manually^3 (Right Click → New File → admin_list.json)^7")
                        return
                    end
                    Wait(500)
                end
                print("^2File was repaired successfully !^7")
            end
        end
    end
end, false)

RegisterCommand("attribute-lab", function(src, args)
    if src ~= 0 and PlayerIsAdmin(GetIdentifierFromId(src)) then
        TriggerClientEvent("sahDrugLabs:InitLabAttribution", src)
    end
end, false)

RegisterCommand("create-lab", function(src, args)
    if src ~= 0 and PlayerIsAdmin(GetIdentifierFromId(src)) then
        TriggerClientEvent("sahDrugLabs:InitLabCreation", src)
    end
end, false)