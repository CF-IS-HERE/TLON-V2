local AiControlSystem = Concord.system({
    pool = {"ai_controlled", "speed", "position", "sprite", "layer"},
    pool2 = {"player_controlled", "speed", "position", "sprite", "layer"}
})

function AiControlSystem:init()
    self.cog_image = love.graphics.newImage("assets/images/cog.png")
end

function AiControlSystem:update(dt)
    for _, entity in ipairs(self.pool) do
        for _, player in ipairs(self.pool2) do
            local ex = entity.position.x + entity.sprite.offset.x
            local ey = entity.position.y + entity.sprite.offset.y
            local px = player.position.x + player.sprite.offset.x
            local py = player.position.y + player.sprite.offset.y
            local angle = math.atan2(py - ey, px - ex)
            entity.position.x = entity.position.x + (math.cos(angle) * entity.speed.value * dt)
            entity.position.y = entity.position.y + (math.sin(angle) * entity.speed.value * dt)
        end
    end
end

function AiControlSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.ai_controlled.has_item then
            love.graphics.setCanvas(e.layer.canvas)
            love.graphics.draw(self.cog_image, e.position.x + 12, e.position.y + 12)
            love.graphics.setCanvas()
        end
    end
end

return AiControlSystem