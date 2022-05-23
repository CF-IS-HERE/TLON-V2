local SpriteSystem = Concord.system({
    standard_pool = {"sprite", "position", "scale"},
    canvas_pool = {"sprite", "position", "layer"}
})

function SpriteSystem:drawSprite(e)
    if e.sprite.visible then
        local sx = e.scale and e.scale.x or 1
        local sy = e.scale and e.scale.y or 1
        if e.sprite.flipped then sx = -sx end
        if e.sprite.total_frames > 1 then
            local qw = e.sprite.image:getWidth() / e.sprite.total_frames
            local qh = e.sprite.image:getHeight()
            local qx = qw * (e.sprite.current_frame - 1)
            local qy = 0 -- spritesheets need to all be on a single horizontal row
            local frame_quad = love.graphics.newQuad(qx, qy, qw, qh, e.sprite.image:getDimensions())
            love.graphics.draw(e.sprite.image, frame_quad, e.position.x - e.sprite.offset.x, e.position.y - e.sprite.offset.y, nil, sx, sy, e.sprite.offset.x, e.sprite.offset.y)
        else
            love.graphics.draw(e.sprite.image, e.position.x + e.sprite.offset.x, e.position.y + e.sprite.offset.y, nil, sx, sy)
        end
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