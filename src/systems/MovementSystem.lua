local MovementSystem = Concord.system({
    pool = {"velocity", "directionIntent", "pos"},
    clearDiectionIntents = { "clearDirectionIntent", "directionIntent"}
})

function MovementSystem:clearDiectionIntent(_)
    for _, e in ipairs(self.clearDiectionIntents) do
        entity.directionIntent.vec.length = 0
    end
end

function MovementSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        local vel = entity.velocity.vec
        local position = entity.pos.vec
        local entitySpeed = entity.speed.value

        vel.x, vel.y = Vector.split(vel + entity.directionIntent.vec * entitySpeed * dt)
        position.x, position.y = Vecotr.split(position + vel * dt)
    end
end

return MovementSystem