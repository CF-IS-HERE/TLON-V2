local AiSpawnSystem = Concord.system({
    pool = {'ai_controlled', 'speed', 'position'}
})

function AiSpawnSystem:setPosition()
    for _, entity in ipairs(self.pool) do
        local side = math.random(1, 4)
        if side == 1 then
            entity.position.x = -30
            entity.position.y = math.random(0, love.graphics.getHeight())
        elseif side == 2 then
            entity.position.x = (love.graphics.getWidth() + 30)
            entity.position.y = math.random(0, love.graphics.getHeight())
        elseif side == 3 then
            entity.position.x = math.random(0, love.graphics.getWidth())
            entity.position.y = -30
        elseif side == 4 then
            entity.position.x = math.random(0, love.graphics.getWidth())
            entity.position.y = (love.graphics.getHeight() + 30)
        end
    end
end

return AiSpawnSystem