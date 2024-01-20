local QBCore = exports['qb-core']:GetCoreObject()

AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    exports['qb-target']:AddTargetModel(PayPhoneModels, {
        options = {
            {
                type = "client",
                event = "tofu-payphone:client:openKeyPad",
                icon = "fas fa-phone",
                label = "Use PayPhone",
                price = 0,
                -- canInteract = function(entity)
                --     check if phone is not ringing
                -- end,
            },
            {
                type = "client",
                event = "tofu-payphone:client:pickupIncomingCall",
                icon = "fas fa-phone",
                label = "Pick Up",
                price = 0,
                -- canInteract = function(entity)
                --     check if phone is ringing
                -- end,
            },
        },
        distance = 2.5,
    })
end)

PayPhoneState = {}
PayPhoneState.IsRinging = false
PayPhoneState.IsInUse = false
PayPhoneState.IncomingNumber = nil

local soundId = nil
local incomingNumber = nil
RegisterNetEvent('tofu-payphone:client:incomingCall')
AddEventHandler('tofu-payphone:client:incomingCall', function(phCoords, incNumber)
    -- TODO: if number is set, it means phone is in-use in which case don't continue..
    -- incomingNumber = incNumber
    local phEntity, _ = QBCore.Functions.GetClosestObject(phCoords)
    local entityCoord = GetEntityCoords(phEntity)

    -- print('------------')
    -- print('req coords: ' .. phCoords, 'coord match: ' .. tostring((entityCoord == phCoords)))
    -- print('entity: ' .. phEntity, 'coords: ' .. entityCoord, 'incomingPh: ' .. incNumber)

    if entityCoord == phCoords and DoesEntityExist(phEntity) then
        if soundId == nil then
            soundId = GetSoundId()
        end
        RequestScriptAudioBank("ASSASSINATION_MULTI")
        -- TODO: Update Flags within SoundSet to make Variables accessible.
        -- 0x00000004 - Volume
        -- 0x00200000 - DistanceAttentuation
        -- TODO: Figure out decent values to use here.
        SetVariableOnSound(soundId, "Volume", 5)
        SetVariableOnSound(soundId, "DistanceAttentuation", 10)
        -- CodeWalker, Audio Explorer, Filter by SoundSets to find what can be used.
        PlaySoundFromEntity(soundId, 'Phone_Ring_Loop', phEntity, 'DLC_Security_Payphone_Hits_General_Sounds', true)
    end

    -- NPWD defaults to 15000ms to answer phone before it gives up... wait the same time, then stop ringing sounds
    -- todo: make this configurable
    Citizen.Wait(15000)

    -- todo, simplify this.. reduce code duplicatioin elsewhere
    StopSound(soundId)
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank("ASSASSINATION_MULTI")
    soundId = nil
    PayPhoneState.IsInUse = true
end)

AddEventHandler('tofu-payphone:client:pickupIncomingCall', function(data)
    StopSound(soundId)
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank("ASSASSINATION_MULTI")
    soundId = nil
    PayPhoneState.IsInUse = true

    -- TODO:
    --  - Show KeyPad with calling number
    --  - Enter call channel etc, make audio work with pma-voice
end)
