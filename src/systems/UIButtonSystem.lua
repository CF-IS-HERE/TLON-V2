local UIButtonSystem = Concord.system({
    pool = {"position", "button", "layer"}
})

function UIButtonSystem:init(world)
    self.sound_click = love.audio.newSource("assets/sounds/menu-accept.mp3", "stream")
    self.sound_click:setVolume(0.1)
    self.sound_hover = love.audio.newSource("assets/sounds/menu-move.mp3", "stream")
    self.sound_hover:setVolume(0.1)
end

function UIButtonSystem:draw()
    for _, e in ipairs(self.pool) do
        if e.button.visible then
            love.graphics.setCanvas(e.layer.canvas)
            local mx = love.mouse.getX() / PixelRatio
            local my = love.mouse.getY() / PixelRatio
            local ex = e.position.x
            local ey = e.position.y
            assert(e.button.image_idle)
            local width = e.button.image_idle:getWidth()
            local height = e.button.image_idle:getHeight()

            if e.button.disabled then
                love.graphics.draw(e.button.image_disabled, e.position.x, e.position.y)
            else
                if mx > ex and mx < ex + width and my > ey and my < ey + height then
                    if not e.entered then
                        e.entered = true
                        e.button.on_mouse_enter()
                        if e.button.image_idle ~= e.button.image_hover then
                            love.audio.stop(self.sound_hover)
                            love.audio.play(self.sound_hover)
                        end
                        e.pressed = love.mouse.isDown(1) -- mouse was pressed outside of button
                    end
                    if e.pressed then
                        e.pressed = love.mouse.isDown(1)
                    elseif love.mouse.isDown(1) then
                        e.pressed = true
                        love.audio.stop(self.sound_click)
                        love.audio.play(self.sound_click)
                        e.button.on_click()
                    end
                    if e.pressed then
                        love.graphics.draw(e.button.image_active, e.position.x, e.position.y)
                    else
                        love.graphics.draw(e.button.image_hover, e.position.x, e.position.y)
                    end
                else
                    love.graphics.draw(e.button.image_idle, e.position.x, e.position.y)
                    if e.entered then
                        e.entered = false
                        e.button.on_mouse_leave()
                    end
                end
            end
            love.graphics.setCanvas()
        end
    end
end

return UIButtonSystem