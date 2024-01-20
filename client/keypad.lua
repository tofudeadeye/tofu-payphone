AddEventHandler('tofu-payphone:client:openKeyPad', function(data)
    local ec = GetEntityCoords(data.entity)
    for _, ph in pairs(PayPhones) do
        if ec == ph["Coords"] then
            openKeyPad(true, ph["Number"], false, ph["Brand"])
            return
        end
    end

    -- if phone is not found, consider it "out of order" with generic branding
    print(ec.x, ec.y, ec.z)
    openKeyPad(true, "", true, "RetroLink")
end)

RegisterNUICallback('dial', function(data)
    if soundId == nil then
        soundId = GetSoundId()
    end
    RequestScriptAudioBank("ASSASSINATION_MULTI")
    PlaySoundFrontend(
        soundId,
        'Phone_Ring_Loop',
        'DLC_Security_Payphone_Hits_General_Sounds',
        false
    )


    -- TODO:
    --  - Enter call channel etc, make audio work with pma-voice
end)

RegisterNUICallback('exit', function()
    if soundId ~= nil then
        StopSound(soundId)
        ReleaseSoundId(soundId)
        ReleaseNamedScriptAudioBank("ASSASSINATION_MULTI")
        soundId = nil
    end
    openKeyPad(false)

    -- TODO:
    --  - Close any open/active calls
end)

openKeyPad = function(bool, phNumber, outOfOrder, brand)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
        phNumber = phNumber,
        outOfOrder = outOfOrder,
        brand = brand,
    })
    SetCursorLocation(0.9, 0.75)
end
