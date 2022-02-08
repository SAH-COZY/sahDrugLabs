RegisterCommand("addAdminToList", function(src, args, raw)
    if src == 0 and args[1] then
        local target_id = tostring(args[1])
        local target_identifier = GetIdentifierFromId(target_id)
        if target_identifier then
            local loadContent = LoadResourceFile(GetCurrentResourceName(), "admin_list.json")
            loadContent = json.decode(loadContent)
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
                print("^1Error - JSON File Corrupted. Repair in progress...^7")
                local timeout = 10000
                while not isFile("./admin_list.json") do
                    print(isFile("./admin_list.json"))
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

RegisterCommand("zebi", function()
    if io.popen("if exist resources/[server]/[little_scripts-DONTCARE]/sahDrugLabs/admin_list.json (echo 1)"):read'*l'=='1' then
        print("oui")
    else
        print("no")
    end
    
end, false)