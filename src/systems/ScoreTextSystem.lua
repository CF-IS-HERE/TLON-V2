local ScoreTextSystem = Concord.system({
    pool = {"lifetime", "position", "layer", "label"}
})

function ScoreTextSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if not e.started then
            e.started = true
            e.total_lifetime = e.lifetime.value
        end
        e.lifetime.value = e.lifetime.value - dt
        if e.lifetime.value < 0 then
            e:destroy()
        end
        e.position.y = e.position.y - (e.total_lifetime - e.lifetime.value) / e.total_lifetime
        e.label.color.a = e.lifetime.value
    end
end

return ScoreTextSystem