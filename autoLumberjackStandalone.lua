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

    local turnDirection
    if isRight then
        turnDirection = turtle.turnRight
    else
        turnDirection = turtle.turnLeft
    end

    turtle.dig()
    assert(turtle.forward(), "Bloqueo")
    turnDirection()
    turtle.dig()
    assert(turtle.forward(), "Bloqueo")

    if turtle.detectUp() then
        turtle.digUp()
        assert(turtle.up(), "Bloqueo")
        turnDirection()
        turtle.dig()
        assert(turtle.forward(), "Bloqueo")
        turnDirection()
        return true
    end
    return false

end

if isSpruceWood() then

    turtle.dig()
    assert(turtle.forward(), "Bloqueo")
    turtle.dig()
    assert(turtle.forward(), "Bloqueo")
    turtle.turnRight()

    local isBlockAbove, isRight

    if isSpruceWood() then
        isRight = true
    else
        turtle.turnLeft()
        turtle.turnLeft()
        isRight = false
    end

    repeat
        isBlockAbove = spiralPattern(isRight)
    until not isBlockAbove

    print("Final del arbol")

    while not turtle.detectDown() do
        assert(turtle.down(), "Bloqueo")
    end

else
    print("Not Spruce")
end