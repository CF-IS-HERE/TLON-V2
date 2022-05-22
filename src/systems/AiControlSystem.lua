local AiControlSystem = Concord.system({
    pool = {'ai_controlled', 'speed', 'position'},
    pool2 = {'player_controlled', 'speed', 'position'}
})

function AiControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        for _, player in ipairs(self.pool2) do
            entity.position.x = entity.position.x + (math.cos( lemonPlayerAngle(entity, player) ) * entity.speed.value * dt)
            entity.position.y = entity.position.y + (math.sin( lemonPlayerAngle(entity, player) ) * entity.speed.value * dt)
        end
    end
end


function lemonPlayerAngle(entity, player)
        local angle = math.atan2( player.position.y - entity.position.y, player.position.x - entity.position.x )
        return angle
end

return AiControlSystem