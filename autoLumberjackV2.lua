lumber = require("lumberlib")
modem = peripheral.find("modem") or error("Missing Modem",0)
networking = require("networking")
local initial_coords = {gps.locate()}
print("Initial Coords: " .. tostring(initial_coords[1]) .. ", " .. tostring(initial_coords[2]) .. ", " .. tostring(initial_coords[3]))


if isSpruceWood() then

    print("Starting Chopping...")
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

    print("Chopping Finished, going down...")
    while not turtle.detectDown() do
        assert(turtle.down(), "Bloqueo")
    end

    local coords = {gps.locate()}
    print("Waiting Chest Coords in Channel 15")
    local chest_coords = netRecieve(15)
    print("Coords Recieved")

    print("Orientating...")
    orientate()
    print("Oriented")

    print("Going to: " .. tostring(chest_coords[1]) .. ", " .. tostring(chest_coords[2]) .. ", " .. tostring(chest_coords[3]))
    goTo(chest_coords, coords)
    print("Destination Reached")

    print("Depositing items...")
    depositStash()
    print("Items deposited")

    coords = {gps.locate()}
    print("Returning to initial coordinates...")
    assert(turtle.back(),"Bloqueo")
    orientate()
    goTo(initial_coords, coords)
    print("Initial coordinates Reached")

    print("Exit code 0")

else
    print("Not Spruce")
end