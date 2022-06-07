local AiControlSystem = Concord.system({
    enemy_pool = {"ai_controlled", "speed", "position", "sprite", "layer", "active"},
    player_pool = {"player_controlled", "speed", "position", "sprite", "layer"}
})

function AiControlSystem:init()
    self.cog_image = love.graphics.newImage("assets/images/cog.png")
end

function AiControlSystem:update(dt)
    for _, e in ipairs(self.enemy_pool) do
        if e.active then
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
        else -- dead but we keep the attached splat particles alive for some time
            e.dead_since = (e.dead_since or 0) + dt
            if e.dead_since > e.ai_controlled.keep_splat_time then
                local alpha = MathUtils.clamp(e.layer.color.a - dt / 3, 0, 1)
                e.layer.color = {r=1,g=1,b=1,a=alpha}
                if alpha <= 0 then
                    e:destroy()
                end
            end
        end
    end
end

function AiControlSystem:draw()
    for _, e in ipairs(self.enemy_pool) do
        if e.ai_controlled.has_item and e.active then
            love.graphics.setCanvas(e.layer.canvas)
            love.graphics.draw(self.cog_image, e.position.x + 12, e.position.y + 12)
            love.graphics.setCanvas()
        end
    end
end

return AiControlSystem