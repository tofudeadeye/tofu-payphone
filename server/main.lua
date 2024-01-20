AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    -- Load all PayPhone numbers within npwd with our custom callback
    for _, ph in pairs(PayPhones) do
        exports['npwd']:onCall(ph['Number'], IncomingCallFromNPWD)
        exports['npwd']:onMessage(ph['Number'], IncomingMessageFromNPWD)
    end
end)
