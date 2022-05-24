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
        local player_center = Vector(e.position.x - 5, e.position.y + 9)
        local mouse_center = Vector(love.mouse.getX() + 14, love.mouse.getY() + 14)
        local aim_angle = (mouse_center / 4 - player_center):angleTo() -- account for scale
        local position = player_center + e.weapon.offset:rotated(aim_angle)
        love.graphics.setCanvas(e.layer.canvas)
        love.graphics.draw(e.weapon.image, position.x, position.y, aim_angle, 1, 1)
        love.graphics.setCanvas()
    end
end

return WeaponSystem