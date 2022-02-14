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

function DisplayHelp(text, fontid)
	SetTextFont(fontid or 1)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(text)
	return EndTextCommandDisplayHelp(0, false, true, 150)
end

function DisplayNotification(text)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(text)
    return EndTextCommandThefeedPostTicker(false, true)
end

function DisplayPictureNotification(sender, reason, text, textDict, icon)
	AddTextEntry('PICTURE_NOTIFICATION', text)
	BeginTextCommandThefeedPost('PICTURE_NOTIFICATION')
	return EndTextCommandThefeedPostMessagetext(textDict, textDict, false, icon, sender, reason)
end

function SpawnVehicle(model, coords, heading, callback)
    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
    return CreateVehicle(model, coords.x, coords.y, coords.z, heading or 90.0, true, false)
end