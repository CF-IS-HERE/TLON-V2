local MovementSystem = Concord.system({
    pool = {"velocity", "directionIntent", "position"},
})

function MovementSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local vel = entity.velocity.ved
        local pos = entity.position.vec
        local entitySpeed = entity.speed.value

        vel.x, vel.y = Vector.split(vel + entity.directionIntent.vec * entitySpeed * dt)
        pos.x, pos.y = Vecotr.split(pos + vel * dt)
    end
end

return MovementSystem