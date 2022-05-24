local getRandomPosition = function()
    local side = math.random(1, 4)
    local x , y = nil, nil
    if side == 1 then
        x = -15
        y = math.random(0, love.graphics.getHeight() / 4)
    elseif side == 2 then
        x = (love.graphics.getWidth() + 15)
        y = math.random(0, love.graphics.getHeight() / 4)
    elseif side == 3 then
        x = math.random(0, love.graphics.getWidth() / 4)
        y = -15
    elseif side == 4 then
        x = math.random(0, love.graphics.getWidth() / 4)
        y = (love.graphics.getHeight() + 15)
    end
    return x, y
end

return function(entity, options)
    local filename = "lemon"..math.random(1, 3)..".png"
    local x, y = getRandomPosition()
    entity:give("sprite", {
        image = love.graphics.newImage("assets/images/"..filename),
    })
    entity:give("layer", options.canvas)
    entity:give("ai_controlled")
    entity:give("out_of_screen_despawn")
    entity:give("position", x, y)
    entity:give("speed", 50)
    entity:give("hurtbox", {
        center = Vector(8, 6),
        radius = 3,
        layer = "player",
    })
end