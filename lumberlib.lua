modem = peripheral.find("modem") or error("Missing Modem",0)
networking = require("networking")

function depositStash()
    local cont = 1
    while not peripheral.isPresent("front") and not (cont == 5) do
        turtle.turnRight()
        cont = cont + 1
    end
    if cont == 5 then
        error("Invalid Coords, no chest",69)
    end

    for slot=1,16,1 do
        local item = turtle.getItemDetail(slot) or false
        if item then
            turtle.select(slot)
            turtle.drop()
        end
    end

    turtle.select(1)
end

function goTo(destination_coords, coords)
    -- 1 = x, 2 = y, 3 = z
    while not (destination_coords[2] == coords[2]) do
        coords = {gps.locate()}
        if (destination_coords[2] > coords[2]) then
            assert(turtle.up(),"Bloqueo")
        elseif (destination_coords[2] < coords[2]) then
            assert(turtle.down(),"Bloqueo")
        end
    end

    local facing
    if (destination_coords[1] > coords[1]) then
        turtle.turnRight()
        facing = "right"
    elseif (destination_coords[1] < coords[1]) then
        turtle.turnLeft()
        facing = "left"
    end

    while not (destination_coords[1] == coords[1]) do
        coords = {gps.locate()}
        if not (destination_coords[1] == coords[1]) then
            assert(turtle.forward(),"Bloqueo")
        end
    end

    if facing == "left" then
        turtle.turnRight()
    elseif facing == "right" then
        turtle.turnLeft()
    else
        error("k wea", 5)
    end

    while not (destination_coords[3] == coords[3]) do
        coords = {gps.locate()}
        if (destination_coords[3] > coords[3]) then
            assert(turtle.back(),"Bloqueo")
        elseif (destination_coords[3] < coords[3]) then
            assert(turtle.forward(),"Bloqueo")
        end
    end

end

function getOrientation()

    local x,y,z = gps.locate()
    assert(turtle.forward(),"Bloqueo")
    local x2,y2,z2 = gps.locate()

    if z > z2 then
        return "north"
    elseif z < z2 then
        return "south"
    end

    if x > x2 then
        return "west"
    elseif x < x2 then
        return "east"
    end

end

function orientate()
    local orientation = getOrientation()
    if orientation == "south" then
        turtle.turnLeft()
        turtle.turnLeft()
    end
    if orientation == "west" then
        turtle.turnRight()
    end
    if orientation == "east" then
        turtle.turnLeft()
    end
end

function returnLogCount()

    local itemCount = 0

    for slot=1,16,1 do
        local item = turtle.getItemDetail(slot) or false
        if item and item["name"] == "minecraft:spruce_log" then
            local cont = turtle.getItemCount(slot)
            itemCount = itemCount + cont
        elseif item then
            turtle.select(slot)
            turtle.drop()
        end
    end

    turtle.select(1)
    return itemCount
end

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