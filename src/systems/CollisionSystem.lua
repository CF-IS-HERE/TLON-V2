local CollisionSystem = Concord.system({
    hitpool = {"position", "hitbox", "layer"},
    hurtpool = {"position", "hurtbox", "layer"}
})

function CollisionSystem:update(dt)
    for _, hit_area in ipairs(self.hitpool) do
        for _, hurt_area in ipairs(self.hurtpool) do
            if hit_area.hitbox.layer == hurt_area.hurtbox.layer then
                local r1 = {
                    x=hit_area.position.x + hit_area.hitbox.offset_x,
                    y=hit_area.position.y + hit_area.hitbox.offset_y,
                    w=hit_area.hitbox.width,
                    h=hit_area.hitbox.height
                }
                local r2 = {
                    x=hurt_area.position.x + hurt_area.hurtbox.offset_x,
                    y=hurt_area.position.y + hurt_area.hurtbox.offset_y,
                    w=hurt_area.hurtbox.width,
                    h=hurt_area.hurtbox.height
                }
                if self:isOverlap(r1, r2) then
                    hit_area.hitbox.on_entered()
                    hurt_area.hurtbox.on_enter()
                end
            end
        end
    end
end

function CollisionSystem:isOverlap(rect1, rect2)
    return  rect1.x + rect1.w > rect2.x
        and rect1.x < rect2.x + rect2.w
        and rect1.y + rect1.h > rect2.y
        and rect1.y < rect2.y + rect2.h
end

function CollisionSystem:renderArea(e, x, y, w, h)
    local _r,_g,_b,_a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 0.5)
    love.graphics.setCanvas(e.layer.canvas)
    love.graphics.rectangle("fill", x, y, w, h)
    love.graphics.setCanvas()
    love.graphics.setColor(_r, _g, _b, _a)
end

function CollisionSystem:draw()
    for _, e in ipairs(self.hitpool) do
        if e.hitbox.rendered then
            local x=e.position.x + e.hitbox.offset_x
            local y=e.position.y + e.hitbox.offset_y
            local w=e.hitbox.width
            local h=e.hitbox.height
            self:renderArea(e, x, y, w, h)
        end 
    end
    for _, e in ipairs(self.hurtpool) do
        if e.hurtbox.rendered then
            local x=e.position.x + e.hurtbox.offset_x
            local y=e.position.y + e.hurtbox.offset_y
            local w=e.hurtbox.width
            local h=e.hurtbox.height
            self:renderArea(e, x, y, w, h)
        end 
    end
end

return CollisionSystem