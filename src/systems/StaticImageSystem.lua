local StaticImageSystem = Concord.system({
    pool = {"image", "position", "scale"}
})

function StaticImageSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.draw(e.image.img, e.position.x, e.position.y, nil, e.scale.sx, e.scale.sy)
    end
end

return StaticImageSystem