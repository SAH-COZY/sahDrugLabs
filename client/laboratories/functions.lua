Laboratories = {}
setmetatable(Laboratories, {})

function Laboratories:InitLabPreparation(labData)
    self.LabIdInPrepare = labData.LabId
    self.PlayerPrepareLab = true
    
    
    local choosed_veh = Config.PreparationTrailersModels[math.random(1, GetTableSize(Config.PreparationTrailersModels))]
    local choosed_pos = Config.PreparationTrailersPositions[math.random(1, GetTableSize(Config.PreparationTrailersPositions))]
    local trailer_handle = SpawnVehicle(choosed_veh.model, choosed_pos, choosed_pos.h, choosed_veh.callback)

    TriggerServerEvent("sahDrugLabs:TrailerHandleContainDrug", trailer_handle, self.PlayerPrepareLab)
    
    Laboratories:AddBlip(Config.PreparationTrailersBlipInfos.Sprite, Config.PreparationTrailersBlipInfos.Color, Config.PreparationTrailersBlipInfos.Scale, Config.PreparationTrailersBlipInfos.Name, nil, trailer_handle)
    Laboratories:LabPreparationTrailerManager(trailer_handle)
    Wait(100)
    ExitOutOfLab(labData)
    Wait(100)
    DisplayPictureNotification(Config.PreparationTrailersMisc.Notification.Sender, Config.PreparationTrailersMisc.Notification.Reason, Config.PreparationTrailersMisc.Notification.Text, Config.PreparationTrailersMisc.Notification.TextDict, Config.PreparationTrailersMisc.Notification.Icon)
    
    self.LabPreparePackets = {
        InTrailer = Config.PreparationTrailersMisc.Packets.NbOfPacketsToDeliver,
        Delivered = 0
    }
    -- TriggerServerEvent("sahDrugLabs:PreparationMade", labData.LabId, true) -- for the end
end

function Laboratories:AddBlip(sprite, color, scale, text, coords, entity)
    if not self.Blips then self.Blips = {} end
    if not entity then
        actBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    else
        actBlip = AddBlipForEntity(entity)
    end
    SetBlipSprite(actBlip, sprite)
    SetBlipDisplay(actBlip, 4)
    SetBlipScale(actBlip, scale)
    SetBlipColour(actBlip, color)
    SetBlipAsShortRange(actBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandSetBlipName(actBlip)
    table.insert(self.Blips, actBlip)
    return actBlip
end

function Laboratories:LabPreparationTrailerManager(trailer_handle)
    Citizen.CreateThread(function()
        while self.PlayerPrepareLab do
            local plyVeh = GetVehiclePedIsIn(GetPlayerPed(-1), true)
            local isAttached, plyTruckTrailer = GetVehicleTrailerVehicle(plyVeh)
            local trailer_pos = GetEntityCoords(trailer_handle)
            local newCoords = GetEntityForwardVector(trailer_handle)
            local plyCoords = GetEntityCoords(GetPlayerPed(-1))
	        local x, y, z   = table.unpack(trailer_pos + newCoords * -7.2)
            local _,g_coords = GetGroundZFor_3dCoord(x, y, z, true)
            if plyTruckTrailer ~= trailer_handle then
                DrawMarker(2, trailer_pos.x, trailer_pos.y, trailer_pos.z+2.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.5, 255, 255, 255, 150, true, false, 2, false, nil, nil, false)
            else
                if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                    local dist = GetDistanceBetweenCoords(x, y, g_coords, plyCoords, true)
                    if dist <= 15.0 then
                        DrawMarker(1, x, y, g_coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.5, 255, 255, 255, 150, false, false, 2, false, nil, nil, false)
                        if dist <= 1.35 then
                            if not self.PlayerHoldingPacket then
                                DisplayHelp("Press ~INPUT_CONTEXT~ to get a packet (Remain: ~b~"..self.LabPreparePackets.InTrailer.."~w~)")
                                if IsControlJustPressed(0, 38) then
                                    self.PlayerHoldingPacket = true
                                    self.LabPreparePackets.InTrailer = self.LabPreparePackets.InTrailer-1
                                    Laboratories:PlayAnim("anim@heists@box_carry@", "idle", true, "hei_prop_heist_box", 60309, {0.025, 0.08, 0.255, -145.0, 290.0, 0.0}, true)
                                end
                            else
                                DisplayHelp("Press ~INPUT_CONTEXT~ to deposit the packet in the trailer")
                                if IsControlJustPressed(0, 38) then
                                    self.PlayerHoldingPacket = false
                                    self.LabPreparePackets.InTrailer = self.LabPreparePackets.InTrailer+1
                                    Laboratories:CancelAnim()
                                end
                            end
                        end
                    end
                end
            end

            if self.PlayerHoldingPacket then
                if not IsEntityPlayingAnim(GetPlayerPed(-1), "anim@heists@box_carry@", "idle", 51) then
                    Laboratories:PlayAnim("anim@heists@box_carry@", "idle", true, "hei_prop_heist_box", 60309, {0.025, 0.08, 0.255, -145.0, 290.0, 0.0}, true)
                end
                for _,v in ipairs(Config.PreparationTrailersMisc.InputsToDisableWhenHoldingPacket) do
                    DisableControlAction(0, v, true)
                end
            end
            Wait(1)
        end
    end)
end

function Laboratories:PlayAnim(animDict, animName, haveProp, propName, bone, propPlacement, canMove)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(1)
    end
    if canMove then animOpt = 51 else animOpt = 0 end
    TaskPlayAnim(GetPlayerPed(-1), animDict, animName, 2.0, 2.0, -1, animOpt, 0, false, false, false)
    if haveProp then
        local PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(propPlacement)
        AllProps = Laboratories:__addPropToPlayer(propName, bone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6)
    end
end

function Laboratories:CancelAnim()
    ClearPedTasksImmediately(PlayerPedId())
    if AllProps then
        DeleteEntity(AllProps)
    end
end

function Laboratories:__addPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
  
    RequestModel(prop1)
    while not HasModelLoaded(prop1) do
        Wait(1)
    end
  
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true) 
    SetModelAsNoLongerNeeded(prop1)
    return prop
  end