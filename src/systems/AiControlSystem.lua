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
            e.position.x = e.position.x + (math.cos(angle) * speed * dt)
            e.position.y = e.position.y + (math.sin(angle) * speed * dt)

            -- despawn if out of screen
            if e.ai_controlled.has_item and (e.position.x > 240 or e.position.x < -40 or e.position.y < -40 or e.position.y > 190) then
                e:destroy()
            end
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