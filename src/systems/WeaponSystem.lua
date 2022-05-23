local WeaponSystem = Concord.system({
    pool = {"position", "weapon", "layer"}
})

function WeaponSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if e.weapon.can_shoot and love.mouse.isDown(1) then
            e.weapon.on_shoot()
            e.weapon.can_shoot = false
            Timer.after(e.weapon.latency, function()
                e.weapon.can_shoot = true
            end)
        end
    end
end

function WeaponSystem:draw()
    for _, e in ipairs(self.pool) do
        local offset = Vector(2, -4) -- weapon offset, might be better within the component itself?
        local center = Vector(e.position.x - 5, e.position.y + 9) -- center of player, used for rotation
        local rotation = Vector(love.mouse.getX() - center.x * 4, love.mouse.getY() - center.y * 4)
        local angle = rotation:angleTo()
        offset:rotateInplace(angle)
        love.graphics.setCanvas(e.layer.canvas)
        love.graphics.draw(e.weapon.image, center.x + offset.x, center.y + offset.y, angle, 1, 1)
        love.graphics.setCanvas()
    end
end

return WeaponSystem