local OutOfScreenDespawnSystem = Concord.system({
    pool = {"position", "out_of_screen_despawn"}
})

function OutOfScreenDespawnSystem:update()
    for _, e in ipairs(self.pool) do
        if e.position.x > 240 or e.position.x < -40 or e.position.y < -40 or e.position.y > 190 then
            e:destroy()
        end
    end
end

return OutOfScreenDespawnSystem