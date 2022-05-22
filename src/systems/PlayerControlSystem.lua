local PlayerControlSystem = Concord.system({
    pool = {"player_controlled", "speed", "position", "velocity"}
})

function PlayerControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local left = love.keyboard.isDown("a") and 1 or 0
        local right = love.keyboard.isDown("d") and 1 or 0
        local up = love.keyboard.isDown("w") and 1 or 0
        local down = love.keyboard.isDown("s") and 1 or 0
        local input_vector = Vector(right - left, down - up):normalized()
        entity.velocity.x = input_vector.x * dt * entity.speed.value
        entity.velocity.y = input_vector.y * dt * entity.speed.value
        entity.position.x = entity.position.x + entity.velocity.x
        entity.position.y = entity.position.y + entity.velocity.y
        -- if love.keyboard.isDown("d") then 
        --     entity.position.x = entity.position.x + entity.speed.value * dt
        -- end
        -- if love.keyboard.isDown("a") then
        --     entity.position.x = entity.position.x - entity.speed.value * dt
        -- end
        -- if love.keyboard.isDown("w") then
        --     entity.position.y = entity.position.y - entity.speed.value * dt
        -- end
        -- if love.keyboard.isDown("s") then
        --     entity.position.y = entity.position.y + entity.speed.value * dt
        -- end
    end
end



return PlayerControlSystem