local PlayerControlSystem = Concord.system({
    pool = {'player_controlled', 'speed', 'position'}
})

function PlayerControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        if love.keyboard.isDown("d") then 
            entity.position.x = entity.position.x + entity.speed.value * dt
        end
        if love.keyboard.isDown("a") then
            entity.position.x = entity.position.x - entity.speed.value * dt
        end
        if love.keyboard.isDown("w") then
            entity.position.y = entity.position.y - entity.speed.value * dt
        end
        if love.keyboard.isDown("s") then
            entity.position.y = entity.position.y + entity.speed.value * dt
        end
    end
end



return PlayerControlSystem