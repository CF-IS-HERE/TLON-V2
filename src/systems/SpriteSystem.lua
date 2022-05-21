local SpriteSystem = Concord.system({
    pool = {"position", "scale", "sprite"}
})

function SpriteSystem:draw() 
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.sprite.value, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
    end
end

return SpriteSystem