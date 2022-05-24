local AiControlSystem = Concord.system({
    enemy_pool = {"ai_controlled", "speed", "position", "sprite", "layer"},
    player_pool = {"player_controlled", "speed", "position", "sprite", "layer"}
})

function AiControlSystem:init()
    self.cog_image = love.graphics.newImage("assets/images/cog.png")
end

function AiControlSystem:update(dt)
    for _, e in ipairs(self.enemy_pool) do
        for _, p in ipairs(self.player_pool) do
            -- get enemy and player centers
            local ex = e.position.x + e.sprite.image:getWidth() / (2 * e.sprite.total_frames)
            local ey = e.position.y + e.sprite.image:getHeight() / (2 * e.sprite.total_frames)
            local px = p.position.x + 2 - p.sprite.image:getWidth() / (2 * p.sprite.total_frames)
            local py = p.position.y + 3 + p.sprite.image:getHeight() / (2 * p.sprite.total_frames)
            local angle = math.atan2(py - ey, px - ex)
            local speed = e.speed.value
            if e.ai_controlled.has_item then
                angle = math.atan2(ey - py, ex - px)
                speed = speed * 0.8 -- slow down a bit to make it easier to catch
            end
            e.knockback.x = MathUtils.lerp(e.knockback.x, 0, dt * 4)
            e.knockback.y = MathUtils.lerp(e.knockback.y, 0, dt * 4)
            e.position.x = e.position.x + e.knockback.x + math.cos(angle) * speed * dt
            e.position.y = e.position.y + e.knockback.y + math.sin(angle) * speed * dt
        end
    end
end

function AiControlSystem:draw()
    for _, e in ipairs(self.enemy_pool) do
        if e.ai_controlled.has_item then
            love.graphics.setCanvas(e.layer.canvas)
            love.graphics.draw(self.cog_image, e.position.x + 12, e.position.y + 12)
            love.graphics.setCanvas()
        end
    end
end

return AiControlSystem