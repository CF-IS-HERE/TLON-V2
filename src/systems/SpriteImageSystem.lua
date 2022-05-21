local SpriteImageSystem = Concord.system({
    pool = {"sprite", "player_position", "scale"}
})

function SpriteImageSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.sprite.sprite, e.player_position.x, e.player_position.y, nil, e.scale.x, e.scale.y)
    end
end

return SpriteImageSystem