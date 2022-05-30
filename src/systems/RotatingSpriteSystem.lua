local RotatingSpriteSystem = Concord.system({
    pool = {"rotation", "sprite"}
})

function RotatingSpriteSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if e.rotation.next == nil then -- initialize
            e.rotation.next = 0
        end
        if e.rotation.rotating then
            if e.sprite.rotation < e.rotation.next then
                e.sprite.rotation = e.sprite.rotation + dt * e.rotation.speed
            else
                e.sprite.rotation = e.rotation.next
                e.rotation.rotating = false
            end
        end
        if e.rotation.ticks > 0 and not e.rotation.rotating then
            e.rotation.ticks = e.rotation.ticks - 1
            e.rotation.next = e.rotation.next + math.pi/2
            e.rotation.rotating = true
        end
    end
end

return RotatingSpriteSystem