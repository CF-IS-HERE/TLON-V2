local AiControlSystem = Concord.system({
    pool = {'ai_controlled', 'speed', 'position', 'sprite'},
    pool2 = {'player_controlled', 'speed', 'position', 'sprite'}
})

function AiControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        for _, player in ipairs(self.pool2) do
            local ex = entity.position.x + entity.sprite.offset.x
            local ey = entity.position.y + entity.sprite.offset.y
            local px = player.position.x + player.sprite.offset.x
            local py = player.position.y + player.sprite.offset.y
            local angle = math.atan2(py - ey, px - ex)
            entity.position.x = entity.position.x + (math.cos(angle) * entity.speed.value * dt)
            entity.position.y = entity.position.y + (math.sin(angle) * entity.speed.value * dt)
        end
    end
end

return AiControlSystem