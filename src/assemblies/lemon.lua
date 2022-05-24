local images = {}
for i=1,3 do
    local filename = "lemon"..i..".png"
    images[i] = love.graphics.newImage("assets/images/"..filename)
end

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
        image = images[math.random(1, 3)],
    })
    entity:give("layer", options.canvas)
    entity:give("ai_controlled")
    entity:give("out_of_screen_despawn")
    entity:give("position", x, y)
    entity:give("health", {max = 10})
    entity:give("speed", 50)
    entity:give("knockback")
    entity:give("hurtbox", {
        center = Vector(8, 6),
        radius = 3,
        layer = "player",
    })
    entity:give("hitbox", {
        center = Vector(8, 6),
        radius = 6,
        layer = "enemy",
        on_entered = function(lemon, bullet)
            if lemon.health.current > 0 then
                lemon.health.current = lemon.health.current - 1
                local knockback_angle = Vector(bullet.position.x - lemon.position.x, bullet.position.y - lemon.position.y):angleTo() + 1.57 -- PI/2
                local knockback = Vector(2, 0):rotated(knockback_angle)
                lemon.knockback.x = knockback.x
                lemon.knockback.y = knockback.y
            else
                lemon:destroy()
            end
            bullet:destroy()
        end
    })
end