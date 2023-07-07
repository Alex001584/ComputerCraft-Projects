function InspectBlocks()
    local hasBlock, itemTable = turtle.inspect()
    if hasBlock and itemTable["name"] == "minecraft:spruce_log" then
        turtle.dig()
        return "front"
    end
    hasBlock, itemTable = turtle.inspectUp()
    if hasBlock and itemTable["name"] == "minecraft:spruce_log"  or itemTable["name"] == "minecraft:spruce_leaves" then
        turtle.digUp()
        return "up"
    end
    hasBlock, itemTable = turtle.inspectDown()
    if hasBlock and itemTable["name"] == "minecraft:spruce_log" then
        turtle.digDown()
        return "down"
    end
    return nil
end

function Turn()
    for i = 1, 4, 1 do
        local hasBlock, itemTable = turtle.inspect()
        if hasBlock and itemTable["name"] == "minecraft:spruce_log" then
            return
        end
        turtle.turnLeft()
    end
end

while true do
    Turn()
    local block = InspectBlocks()
    if block == "front" then
        assert(turtle.forward(), "Bloqueo en el camino")
    elseif block == "up" then
        assert(turtle.up(), "Bloqueo en el camino")
    elseif block == "down" then
        assert(turtle.down(), "Bloqueo en el camino")
    elseif block == nil then
        print("Final Del Arbol")
        return
    end
end
