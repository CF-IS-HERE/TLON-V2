local AiControlSystem = Concord.system({
    pool = {'ai_controlled', 'speed', 'ai_position'},
    pool2 = {'player_controlled', 'speed', 'player_position'}
})

function AiControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        for _, player in ipairs(self.pool2) do
            entity.ai_position.x = entity.ai_position.x + (math.cos( lemonPlayerAngle(entity, player) ) * entity.speed.value * dt)
            entity.ai_position.y = entity.ai_position.y + (math.sin( lemonPlayerAngle(entity, player) ) * entity.speed.value * dt)
        end
    end
end


function lemonPlayerAngle(entity, player)
        local angle = math.atan2( player.player_position.y - entity.ai_position.y, player.player_position.x - entity.ai_position.x )
        return angle
end

return AiControlSystem