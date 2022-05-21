local AiSpawnSystem = Concord.system({
    pool = {'ai_controlled', 'speed', 'ai_position'}
})

function AiSpawnSystem:setPosition()
    for _, entity in ipairs(self.pool) do
        local side = math.random(1, 4)
        if side == 1 then
            entity.ai_position.x = -30
            entity.ai_position.y = math.random(0, love.graphics.getHeight())
        elseif side == 2 then
            entity.ai_position.x = (love.graphics.getWidth() + 30)
            entity.ai_position.y = math.random(0, love.graphics.getHeight())
        elseif side == 3 then
            entity.ai_position.x = math.random(0, love.graphics.getWidth())
            entity.ai_position.y = -30
        elseif side == 4 then
            entity.ai_position.x = math.random(0, love.graphics.getWidth())
            entity.ai_position.y = (love.graphics.getHeight() + 30)
        end
    end
end

return AiSpawnSystem