local PlayerControlSystem = Concord.system({
    pool = {"player_controlled", "speed", "position", "velocity", "sprite", "particles", "active"}
})

local timer = 0

function PlayerControlSystem:update(dt)
    timer = timer + dt
    for _, entity in ipairs(self.pool) do
        if entity.active then
            local left = love.keyboard.isDown("a") and 1 or 0
            local right = love.keyboard.isDown("d") and 1 or 0
            local up = love.keyboard.isDown("w") and 1 or 0
            local down = love.keyboard.isDown("s") and 1 or 0
            entity.velocity.x = MathUtils.lerp(entity.velocity.x, (right - left) * entity.speed.value, dt * 5)
            entity.velocity.y = MathUtils.lerp(entity.velocity.y, (down - up) * entity.speed.value, dt * 5)
            entity.position.x = MathUtils.clamp(entity.position.x + entity.velocity.x, 5, 204)
            entity.position.y = MathUtils.clamp(entity.position.y + entity.velocity.y, -3, 140)
            entity.sprite.flipped = love.mouse.getX() / 4 < entity.position.x + entity.sprite.offset.x
            local is_moving = (math.abs(entity.velocity.x) + math.abs(entity.velocity.y)) / entity.speed.value
            entity.particles.emitters.run.ticks = MathUtils.round(is_moving)
            entity.sprite.rotation = math.sin(timer * 12) * 0.2 * is_moving
        end
    end
end

return PlayerControlSystem