IncomingMessageFromNPWD = function(ctx)
    -- TriggerEvent("QBCore:DebugSomething", ctx, 0, GetCurrentResourceName())
    local brand = 'RetroLink'
    for _, ph in pairs(PayPhones) do
        if ctx.data.tgtPhoneNumber == ph['Number'] then
            brand = ph['Brand']
            break
        end
    end

    -- Send an automated reply to the playe
    exports['npwd']:emitMessage({
        senderNumber = ctx.data.tgtPhoneNumber,
        targetNumber = ctx.data.sourcePhoneNumber,
        message = brand .. ' Telecommunications. This is an automated response, messages to ' ..
            ctx.data.tgtPhoneNumber .. ' are not monitored.',
    })
end
