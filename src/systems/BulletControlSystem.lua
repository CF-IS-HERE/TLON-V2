local BulletControlSystem = Concord.system({
    pool = {"cruise_controlled", "position", "velocity"}
})

function BulletControlSystem:update(dt)
    for _, b in ipairs(self.pool) do
        b.position.x = b.position.x + b.velocity.x * dt
        b.position.y = b.position.y + b.velocity.y * dt
    end
end

return BulletControlSystem