IncomingCallFromNPWD = function(ctx)
    -- TriggerEvent("QBCore:DebugSomething", ctx, 0, GetCurrentResourceName())
    -- Note: We don't need to check if the number exists, if this code is executed it implies that the phone number
    -- for the payphone has been registered within nwpd.

    local phoneIdx = nil
    for idx, ph in pairs(PayPhones) do
        if ctx.receiverNumber == ph['Number'] then
            phoneIdx = idx
            break
        end
    end

    -- Send ClientEvent to all players, make payphone entity "ring" with 3d sounds if they are nearby
    TriggerClientEvent("tofu-payphone:client:incomingCall", -1, PayPhones[phoneIdx]['Coords'], ctx.incomingCaller.number)
end
