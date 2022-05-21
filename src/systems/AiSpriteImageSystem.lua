local AiSpriteImageSystem = Concord.system({
    pool = {"sprite", "ai_position", "scale"}
})

function AiSpriteImageSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.sprite.sprite, e.ai_position.x, e.ai_position.y, nil, e.scale.x, e.scale.y)
    end
end

return AiSpriteImageSystem