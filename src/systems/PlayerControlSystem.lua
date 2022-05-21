local PlayerControlSystem = Concord.system({
    pool = {'player_controlled', 'speed', 'player_position'}
})

function PlayerControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        if love.keyboard.isDown("d") then 
            entity.player_position.x = entity.player_position.x + entity.speed.value * dt
        end
        if love.keyboard.isDown("a") then
            entity.player_position.x = entity.player_position.x - entity.speed.value * dt
        end
        if love.keyboard.isDown("w") then
            entity.player_position.y = entity.player_position.y - entity.speed.value * dt
        end
        if love.keyboard.isDown("s") then
            entity.player_position.y = entity.player_position.y + entity.speed.value * dt
        end
    end
end



return PlayerControlSystem