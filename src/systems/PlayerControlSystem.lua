local PlayerControlSystem = Concord.system({
    pool = {"player_controlled", "speed", "position", "velocity"}
})

function PlayerControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local left = love.keyboard.isDown("a") and 1 or 0
        local right = love.keyboard.isDown("d") and 1 or 0
        local up = love.keyboard.isDown("w") and 1 or 0
        local down = love.keyboard.isDown("s") and 1 or 0
        entity.velocity.x = MathUtils.lerp(entity.velocity.x, (right - left) * entity.speed.value, dt * 5)
        entity.velocity.y = MathUtils.lerp(entity.velocity.y, (down - up) * entity.speed.value, dt * 5)
        entity.position.x = MathUtils.clamp(entity.position.x + entity.velocity.x, 0, 190)
        entity.position.y = MathUtils.clamp(entity.position.y + entity.velocity.y, 0, 140)
    end
end

return PlayerControlSystem