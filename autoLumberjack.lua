function TurnAndCheck()
    for i = 1, 5, 1 do
        if turtle.detect() then
            return
        end
        turtle.turnLeft()
    end
    if turtle.detectUp() then
        return
    end
    return nil
end

function InspectBlocks()
    local hasBlock, itemTable = turtle.inspect()
    if hasBlock and itemTable["name"] == "minecraft:spruce_log" then
        turtle.dig()
        return true
    end
    hasBlock, itemTable = turtle.inspectUp()
    if hasBlock and itemTable["name"] == "minecraft:spruce_log" then
        turtle.digUp()
        return false
    end
    return nil
end

while true do
    TurnAndCheck()
    if InspectBlocks() then
        assert(turtle.forward(), "Bloqueo en el camino")
    else
        assert(turtle.up(), "Bloqueo en el camino")
    end
end