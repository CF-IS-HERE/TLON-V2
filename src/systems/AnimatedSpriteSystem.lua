-- system that supports animation for a horizontal spritesheet

local AnimatedSpriteSystem = Concord.system({
    pool = {"animation", "sprite", "position", "layer"}
})

function AnimatedSpriteSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if not e.anim then -- initialize internals
            local frame_width = e.sprite.image:getWidth() / e.animation.total_frames
            e.grid = Anim8.newGrid(frame_width, e.sprite.image:getHeight(), e.sprite.image:getWidth(), e.sprite.image:getHeight())
            local loop_fn = function(anim, loops)
                if not e.animation.looped then
                    e.animation.playing = false
                    e.animation.on_complete()
                    anim:pauseAtEnd()
                end
            end
            e.anim = Anim8.newAnimation(e.grid('1-'..e.animation.total_frames,1), e.animation.speed, loop_fn)
            -- reverse playing isn't supported, using a separate animation instead
            e.anim_reverse = Anim8.newAnimation(e.grid(tostring(e.animation.total_frames) ..'-1',1), e.animation.speed, loop_fn)
        end
        local anim = e.animation.reversed and e.anim_reverse or e.anim
        if e.animation.playing then
            anim:resume()
        else
            anim:pause()
        end
        anim:update(dt)
    end
end

function AnimatedSpriteSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.sprite.visible then
            love.graphics.setCanvas(e.layer.canvas)
            local anim = e.animation.reversed and e.anim_reverse or e.anim
            anim:draw(e.sprite.image, e.position.x, e.position.y, nil, 1, 1)
            love.graphics.setCanvas()
        end

    end
end

return AnimatedSpriteSystem