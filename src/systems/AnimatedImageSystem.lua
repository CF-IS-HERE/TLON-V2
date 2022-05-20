-- system that supports animation for a horizontal spritesheet

local AnimatedImageSystem = Concord.system({
    pool = {"animation", "image", "position", "scale"}
})

function AnimatedImageSystem:update(dt)
    for _, e in ipairs(self.pool) do
        if not e.anim then
            local frame_width = e.image.img:getWidth() / e.animation.total_frames
            e.grid = Anim8.newGrid(frame_width, e.image.img:getHeight(), e.image.img:getWidth(), e.image.img:getHeight())
            local loop_fn = function(anim, loops)
                if not e.animation.is_loop then
                    anim:pauseAtEnd()
                end
            end
            e.anim = Anim8.newAnimation(e.grid('1-'..e.animation.total_frames,1), e.animation.speed, loop_fn)
            -- reverse playing isn't supported, using a separate animation instead
            e.anim_reverse = Anim8.newAnimation(e.grid(tostring(e.animation.total_frames) ..'-1',1), e.animation.speed, loop_fn)
        end
        local anim = e.animation.is_reverse and e.anim_reverse or e.anim
        if e.animation.is_playing then
            anim:resume()
        else
            anim:pause()
        end
        anim:update(dt)
    end
end

function AnimatedImageSystem:draw()
    for _, e in ipairs(self.pool) do
        local anim = e.animation.is_reverse and e.anim_reverse or e.anim
        anim:draw(e.image.img, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
    end
end

return AnimatedImageSystem