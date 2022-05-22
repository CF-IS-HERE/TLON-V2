local SpriteSystem = Concord.system({
    pool = {"sprite", "position", "scale"}
})

function SpriteSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.sprite.visible then
            if e.sprite.layer then
                love.graphics.setCanvas(e.sprite.layer)
            end
            if e.sprite.total_frames > 1 then
                local qw = e.sprite.image:getWidth() / e.sprite.total_frames
                local qh = e.sprite.image:getHeight()
                local qx = qw * (e.sprite.current_frame - 1)
                local qy = 0 -- spritesheets need to all be on a single horizontal row
                local frame_quad = love.graphics.newQuad(qx, qy, qw, qh, e.sprite.image:getDimensions())
                love.graphics.draw(e.sprite.image, frame_quad, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            else
                love.graphics.draw(e.sprite.image, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            end
            if e.sprite.layer then
                love.graphics.setCanvas()
            end
        end
    end
end

return SpriteSystem