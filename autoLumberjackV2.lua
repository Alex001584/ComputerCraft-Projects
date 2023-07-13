function isSpruceWood()
    local hasBlock, itemTable = turtle.inspect()
    block = itemTable["name"]
    if hasBlock and block == "minecraft:spruce_log" then
        return true
    else
        return false
    end
end

function spiralPattern(isRight)
    if isRight then
        turtle.dig()
        assert(turtle.forward(), "Bloqueo")
        turtle.turnRight()
        turtle.dig()
        assert(turtle.forward(), "Bloqueo")

        if turtle.detectUp() then
            turtle.digUp()
            assert(turtle.up(), "Bloqueo")
            turtle.turnRight()
            turtle.dig()
            assert(turtle.forward(), "Bloqueo")
            turtle.turnRight()
            return true
        end
        return false
    else
        turtle.dig()
        assert(turtle.forward(), "Bloqueo")
        turtle.turnLeft()
        turtle.dig()
        assert(turtle.forward(), "Bloqueo")

        if turtle.detectUp() then
            turtle.digUp()
            assert(turtle.up(), "Bloqueo")
            turtle.turnLeft()
            turtle.dig()
            assert(turtle.forward(), "Bloqueo")
            turtle.turnLeft()
            return true
        end
        return false
    end
end

if isSpruceWood() then
    turtle.dig()
    assert(turtle.forward(), "Bloqueo")
    turtle.dig()
    assert(turtle.forward(), "Bloqueo")
    turtle.turnRight()

    local isBlockAbove
    local height = 0
    if isSpruceWood() then
        repeat
            isBlockAbove = spiralPattern(true)
            height = height + 1
        until not isBlockAbove
    else
        turtle.turnLeft()
        turtle.turnLeft()
        repeat
            isBlockAbove = spiralPattern(false)
        until not isBlockAbove
    end
    print("Final del arbol")
else
    print("Not Spruce")
end