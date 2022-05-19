local ClickableButtonSystem = Concord.system({
    pool = {"hover", "scale", "position"}
})

function ClickableButtonSystem:init()
    self.hover_sound = love.audio.newSource("assets/sounds/menu-move.mp3", "stream")
    self.has_entered = false
end

function ClickableButtonSystem:draw()
    for _, e in ipairs(self.pool) do
        local mx = love.mouse.getX() - 5
        local my = love.mouse.getY() - 5
        local ex = e.position.x
        local ey = e.position.y
        local width = e.hover.img_idle:getWidth() * e.scale.x
        local height = e.hover.img_idle:getHeight() * e.scale.y

        if mx > ex and mx < ex + width and my > ey and my < ey + height then
            love.graphics.draw(e.hover.img_hover, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if not e.is_entered then
                e.is_entered = true
                love.audio.stop(self.hover_sound)
                love.audio.play(self.hover_sound)
            end
        else
            love.graphics.draw(e.hover.img_idle, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if e.is_entered then
                e.is_entered = false
            end
        end
    end
end

return ClickableButtonSystem