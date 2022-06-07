-- transitionary state to show death animation prior to moving to score state
local Death = {}

function Death:enter()
    if self.death_animation.anim then
        -- animation needs to be reset in case we died previously
        self.death_animation.anim:gotoFrame(1)
        self.death_animation.animation.playing = true
    end
end

function Death:init()
    self.world = Concord.world()
    self.world:addSystems(Systems.AnimatedSpriteSystem)
    self.death_animation = Concord.entity(self.world)
        :give("animation", {
            total_frames = 15,
            speed = 0.05,
            playing = true,
            on_complete = function()
                Gamestate.switch(State.Score)
            end
        })
        :give("sprite", {image = love.graphics.newImage('assets/images/deathscreen/death_animation.png')})
        :give("position")
        :give("layer", Canvas.ui)
end

function Death:update(dt)
    self.world:emit("update", dt)
end

function Death:draw()
    love.graphics.setCanvas(Canvas.ui)
    love.graphics.clear(16/255, 20/255, 31/255, 1)
    love.graphics.setCanvas()
    self.world:emit("draw")
    love.graphics.draw(Canvas.ui, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
end
return Death