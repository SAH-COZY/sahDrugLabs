StagesTypes = {
    ["0"] = function(cb, stage)
        DisplayHelp("Create a laboratory ?\n~INPUT_FRONTEND_RDOWN~ Yes\n~INPUT_FRONTEND_RRIGHT~ No", nil, {191, 194}, function(key)
            if key == 191 then
                cb(stage+1)
            elseif key == 194 then
                cb(-1)
            end
        end)
    end,
    ["1"] = function(cb, stage)
        DisplayHelp("Select a business type\n1 ~BLIP_496~\n2 ~BLIP_497~\n3 ~BLIP_498~\n4 ~BLIP_499~\n5 ~BLIP_500~\n~INPUT_FRONTEND_RDOWN~ to write it", nil, {157, 158, 160, 164, 165}, function(key)
            local keysInfos = {["157"] = 1, ["158"] = 4, ["160"] = 0, ["164"] = 3, ["165"] = 2}
            local data = {businessType = keysInfos[tostring(key)]}
            cb(stage+1, data)
        end)
    end,
    ["2"] = function(cb, stage)
        DisplayHelp("Choose the entry\nPress ~INPUT_CREATOR_LT~ to set\nPress ~INPUT_FRONTEND_RDOWN~ to validate", nil, {252, 191}, function(key)
            if key == 252 then
                data = {pos = GetEntityCoords(GetPlayerPed(-1))}
                DisplayNotification(string.format("Position was set to\nX = %s\nY = %s\nZ = %s", data.pos.x, data.pos.y, data.pos.z))
            else
                if data then
                    cb(stage+1, data)
                else
                    DisplayNotification("~r~No position was set !")
                end
            end
        end)
    end
}