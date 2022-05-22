local PlayerSpriteImageSystem = Concord.system({
    pool = {"sprite", "position", "scale"}
})

function PlayerSpriteImageSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.sprite.sprite, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
    end
end

return PlayerSpriteImageSystem