local WeaponSystem = Concord.system({
    pool = {"position", "weapon"}
})

function WeaponSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        Timer.update(dt)
        if entity.weapon.can_shoot and love.mouse.isDown(1) then
            entity.weapon.on_shoot()
            entity.weapon.can_shoot = false
            Timer.after(entity.weapon.latency, function()
                entity.weapon.can_shoot = true
            end)
        end
    end
end

return WeaponSystem