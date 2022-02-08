function EnterInLab(labInfos)
    local shorter = BusinessTypeInfos[tostring(labInfos.BusinessType)]
    if labInfos.PreparationMade then
        shorter.LoadAfterPrepare()
        if labInfos.Upgrades.Upgrade1 then
            shorter.Update1.SetInIPL()
        end
        if labInfos.Upgrades.Upgrade2 then
            shorter.Update2.SetInIPL()
        end
    else
        shorter.Load()
    end

    Wait(50)
    AddMultZones({
        {
            zoneName = "go-out", 
            coords = shorter.Position,
            key = {keyid = 51, keyname = "INPUT_CONTEXT"}, 
            action = function()
                ExitOutOfLab(labInfos)
            end
        },
        {
            zoneName = "manage", 
            coords = BusinessTypeInfos[tostring(labInfos.BusinessType)].Coords.Manage, 
            key = {keyid = 51, keyname = "INPUT_CONTEXT"}, 
            action = function()
                ShowInterface(labInfos)
            end
        },
    })
    SetEntityCoords(GetPlayerPed(-1), shorter.Position.x, shorter.Position.y, shorter.Position.z)
    SetEntityHeading(GetPlayerPed(-1), shorter.Heading)
end

function ExitOutOfLab(inf)
    -- set player bucket to 0
    AddedZones = {}
    TriggerServerEvent("sahDrugLabs:GetMyLabs")
    SetEntityCoords(GetPlayerPed(-1), inf.Entry.x, inf.Entry.y, inf.Entry.z)
end

function AddMultZones(table)
    for k,v in pairs(table) do
        AddZone(v.zoneName, v.coords, v.key, v.action)
    end
end

function AddZone(zoneName, position, key, cb)
    AddedZones[tostring(zoneName)] = {
        coords = position,
        key = key,
        action = cb
    }
end

function DisplayHelp(text, fontid, keys, cb)
	SetTextFont(fontid or 1)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayHelp(0, false, true, 150)
    if cb then
        for _,v in ipairs(keys) do
            DisableControlAction(0, v, true)
            if IsDisabledControlJustReleased(0, v) then
                cb(v)
            end
        end
    end
end

function DisplayNotification(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(false, true)
end