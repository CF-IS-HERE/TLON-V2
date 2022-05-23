local BulletControlSystem = Concord.system({
    pool = {"cruise_controlled", "position", "velocity", "hurtbox", "sprite", "layer"}
})

function BulletControlSystem:update(dt)
    for _, b in ipairs(self.pool) do
        b.position.x = b.position.x + b.velocity.x * dt
        b.position.y = b.position.y + b.velocity.y * dt
    end
end

function BulletControlSystem:draw()
    for _, b in ipairs(self.pool) do
        love.graphics.setCanvas(b.layer.canvas)
        love.graphics.draw(b.sprite.image, b.position.x, b.position.y)
        love.graphics.setCanvas()
    end
end

return BulletControlSystem