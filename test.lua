local hasBlock, itemTable = turtle.inspect()
if hasBlock and itemTable["name"] == "minecraft:spruce_wood" then
    print(true)
else
    print(false)
end