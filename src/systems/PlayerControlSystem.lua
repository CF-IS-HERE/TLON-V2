local PlayerControlSystem = Concord.system({
    pool = {"player_controlled", "speed", "position", "velocity", "sprite"}
})

function PlayerControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local left = love.keyboard.isDown("a") and 1 or 0
        local right = love.keyboard.isDown("d") and 1 or 0
        local up = love.keyboard.isDown("w") and 1 or 0
        local down = love.keyboard.isDown("s") and 1 or 0
        entity.velocity.x = MathUtils.lerp(entity.velocity.x, (right - left) * entity.speed.value, dt * 5)
        entity.velocity.y = MathUtils.lerp(entity.velocity.y, (down - up) * entity.speed.value, dt * 5)
        entity.position.x = MathUtils.clamp(entity.position.x + entity.velocity.x, 5, 204)
        entity.position.y = MathUtils.clamp(entity.position.y + entity.velocity.y, -3, 140)
        entity.sprite.flipped = love.mouse.getX() / 4 < entity.position.x + entity.sprite.offset.x
    end
end

return PlayerControlSystem