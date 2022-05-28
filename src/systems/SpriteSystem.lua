local SpriteSystem = Concord.system({
    standard_pool = {"sprite", "position", "scale"},
    canvas_pool = {"sprite", "position", "layer"}
})

function SpriteSystem:drawSprite(e)
    if e.sprite.visible then
        local sx = e.scale and e.scale.x or 1
        local sy = e.scale and e.scale.y or 1
        local ex = e.position.x - e.sprite.offset.x
        local ey = e.position.y - e.sprite.offset.y
        if e.sprite.flipped then sx = -sx end
        if e.sprite.flash_intensity > 0.5 then
            love.graphics.setShader(FlashShader)
            FlashShader:send("intensity", e.sprite.flash_intensity)
        end
        if e.sprite.total_frames > 1 then
            local qw = e.sprite.image:getWidth() / e.sprite.total_frames
            local qh = e.sprite.image:getHeight()
            local qx = qw * (e.sprite.current_frame - 1)
            local qy = 0 -- spritesheets need to all be on a single horizontal row
            local frame_quad = love.graphics.newQuad(qx, qy, qw, qh, e.sprite.image:getDimensions())
            love.graphics.draw(e.sprite.image, frame_quad, ex, ey, e.sprite.rotation, sx, sy, e.sprite.offset.x, e.sprite.offset.y)
        else
            love.graphics.draw(e.sprite.image, ex, ey, e.sprite.rotation, sx, sy)
        end
        love.graphics.setShader()
    end
end

function SpriteSystem:updateSprite(e, dt)
    if e.sprite.flash_intensity > 0 then
        e.sprite.flash_intensity = MathUtils.clamp(e.sprite.flash_intensity - dt, 0.5, 1)
    end
end

function SpriteSystem:update(dt)
    for _, e in ipairs(self.standard_pool) do
        self:updateSprite(e, dt)
    end
    for _, e in ipairs(self.canvas_pool) do
        self:updateSprite(e, dt)
    end
end

function SpriteSystem:draw()
    for _, e in ipairs(self.standard_pool) do
        self:drawSprite(e)
    end
    for _, e in ipairs(self.canvas_pool) do
        love.graphics.setCanvas(e.layer.canvas)
        self:drawSprite(e)
        love.graphics.setCanvas()
    end

end

return SpriteSystem