modem = peripheral.find("modem")

function netSend(channel, replyChannel, message)

    local netTable
    modem.open(replyChannel)
    repeat
        os.startTimer(1)
        modem.transmit(channel, replyChannel, message)
        netTable = {os.pullEvent()}
    until netTable[1] == "modem_message" and netTable[3] == replyChannel
    modem.close(replyChannel)

end

function netRecieve(channel)

    modem.open(channel)
    local netTable
    repeat
        netTable = {os.pullEvent("modem_message")}
    until netTable[3] == channel
    modem.transmit(netTable[4],channel,1)
    modem.close(channel)

    return netTable[5]

end