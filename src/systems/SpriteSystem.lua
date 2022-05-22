local SpriteSystem = Concord.system({
    pool = {"sprite", "position", "scale"}
})

function SpriteSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.sprite.visible then
            if e.sprite.layer then
                love.graphics.setCanvas(e.sprite.layer)
            end
            love.graphics.draw(e.sprite.image, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if e.sprite.layer then
                love.graphics.setCanvas()
            end
        end
    end
end

return SpriteSystem