local CollisionSystem = Concord.system({
    hitpool = {"position", "hitbox", "layer", "active"},
    hurtpool = {"position", "hurtbox", "layer", "active"}
})

function CollisionSystem:update(dt)
    for _, hit_area in ipairs(self.hitpool) do
        for _, hurt_area in ipairs(self.hurtpool) do
            if hit_area.active and hurt_area.active then
                if hit_area.hitbox.layer == hurt_area.hurtbox.layer then
                    local c1 = {
                        x=hit_area.position.x + hit_area.hitbox.center.x,
                        y=hit_area.position.y + hit_area.hitbox.center.y,
                        r=hit_area.hitbox.radius
                    }
                    local c2 = {
                        x=hurt_area.position.x + hurt_area.hurtbox.center.x,
                        y=hurt_area.position.y + hurt_area.hurtbox.center.y,
                        r=hurt_area.hurtbox.radius
                    }
                    if self:isOverlap(c1, c2) then
                        hit_area.hitbox.on_entered(hit_area, hurt_area)
                        hurt_area.hurtbox.on_enter(hurt_area, hit_area)
                    end
                end
            end
        end
    end
end

function CollisionSystem:isOverlap(circ1, circ2)
    return  Vector(circ1.x - circ2.x, circ1.y - circ2.y):len() < circ1.r + circ2.r
end

function CollisionSystem:renderArea(e, x, y, r)
    local _r,_g,_b,_a = love.graphics.getColor()
    love.graphics.setColor(1, 0, 0, 0.5)
    love.graphics.setCanvas(e.layer.canvas)
    love.graphics.circle("fill", x, y, r)
    love.graphics.setCanvas()
    love.graphics.setColor(_r, _g, _b, _a)
end

function CollisionSystem:draw()
    for _, e in ipairs(self.hitpool) do
        if e.hitbox.rendered then
            local x=e.position.x + e.hitbox.center.x
            local y=e.position.y + e.hitbox.center.y
            local r=e.hitbox.radius
            self:renderArea(e, x, y, r)
        end
    end
    for _, e in ipairs(self.hurtpool) do
        if e.hurtbox.rendered then
            local x=e.position.x + e.hurtbox.center.x
            local y=e.position.y + e.hurtbox.center.y
            local r=e.hurtbox.radius
            self:renderArea(e, x, y, r)
        end
    end
end

return CollisionSystem