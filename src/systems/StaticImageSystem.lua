local StaticImageSystem = Concord.system({
    pool = {"image", "position", "scale"}
})

function StaticImageSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.image.visible then
            love.graphics.draw(e.image.img, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
        end
    end
end

return StaticImageSystem