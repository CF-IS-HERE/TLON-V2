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
    local animation_img = love.graphics.newImage('assets/images/deathscreen/death_animation.png')
    local animation_img_scale_x = love.graphics.getWidth() / animation_img:getWidth()
    local animation_img_scale_y = love.graphics.getHeight() / animation_img:getHeight()
    
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
        :give("sprite", {image = animation_img})
        :give("position")
        :give("scale", animation_img_scale_x * 15, animation_img_scale_y)
end

function Death:update(dt)
    self.world:emit("update", dt)
end

function Death:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(16/255, 20/255, 31/255, 1)
    love.graphics.rectangle("fill", 0, 0, 800, 600)
    love.graphics.setColor(r,g,b,a)
    self.world:emit("draw")
end
return Death