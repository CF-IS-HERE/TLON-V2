local UIButtonSystem = Concord.system({
    pool = {"scale", "position", "button"}
})

function UIButtonSystem:init(world)
    self.sound_hover = love.audio.newSource("assets/sounds/menu-move.mp3", "stream")
end

function UIButtonSystem:draw()
    for _, e in ipairs(self.pool) do
        local mx = love.mouse.getX() - 5
        local my = love.mouse.getY() - 5
        local ex = e.position.x
        local ey = e.position.y
        assert(e.button.image_idle)
        local width = e.button.image_idle:getWidth() * e.scale.x
        local height = e.button.image_idle:getHeight() * e.scale.y

        if mx > ex and mx < ex + width and my > ey and my < ey + height then
            love.graphics.draw(e.button.image_hover or e.button.image_idle, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if not e.is_entered then
                e.is_entered = true
                e.button.on_mouse_enter()
                love.audio.stop(self.sound_hover)
                love.audio.play(self.sound_hover)
                e.is_pressed = love.mouse.isDown(1) -- mouse was pressed outside of button
            end
            if e.is_pressed then
                e.is_pressed = love.mouse.isDown(1)
            elseif love.mouse.isDown(1) then
                e.button.on_click()
            end
        else
            love.graphics.draw(e.button.image_idle, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if e.is_entered then
                e.is_entered = false
                e.button.on_mouse_leave()
            end
        end
    end
end

return UIButtonSystem