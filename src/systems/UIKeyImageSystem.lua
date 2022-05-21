local UIKeyImageSystem = Concord.system({
    pool = {"image_key", "position", "scale"}
})

function UIKeyImageSystem:init(world)
    self.sound_pressed = love.audio.newSource("assets/sounds/menu-accept.mp3", "stream")
end

function UIKeyImageSystem:draw()
    for _, e in ipairs(self.pool) do
        if love.keyboard.isDown(e.image_key.key) then
            love.graphics.draw(e.image_key.image_active, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
            if not e.active then
                e.active = true
                if not e.image_key.silent then
                    love.audio.stop(self.sound_pressed)
                    love.audio.play(self.sound_pressed)
                end
            end
        else
            e.active = false
            love.graphics.draw(e.image_key.image_idle, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
        end
    end
end

return UIKeyImageSystem