local Pause = {}

function Pause:enter()
    if self.background.anim then
        -- pause animation needs to be reset in case we were paused previously
        self.background.anim:gotoFrame(1)
        self.background.animation.reversed = false
        self.background.animation.playing = true
    end
end

function Pause:init()
    local game_background_img = love.graphics.newImage('assets/images/game_background.png')
    local game_background_scale_x = love.graphics.getWidth() / game_background_img:getWidth()
    local game_background_scale_y = love.graphics.getHeight() / game_background_img:getHeight()
    local background_img = love.graphics.newImage('assets/images/pause_menu/pause_animation.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()
    
    self.world = Concord.world()
    self.world:addSystems(Systems.SpriteSystem, Systems.AnimatedSpriteSystem, Systems.UIButtonSystem)
    Concord.entity(self.world)
        :give("sprite", {image = game_background_img})
        :give("position")
        :give("scale", game_background_scale_x, game_background_scale_y)
    self.background = Concord.entity(self.world)
        :give("animation", {
            total_frames = 6,
            speed = 0.2,
            playing = true,
            on_complete = function()
                if self.background.animation.reversed then
                    Gamestate.pop()
                    if Gamestate.current() == State.InGame then
                        AudioWorld:emit("playMusic")
                    end
                else
                    self.setButtonState(self, true)
                end
            end
        })
        :give("sprite", {image = background_img})
        :give("position")
        :give("scale", background_scale_x * 6, background_scale_y)
    self.continue_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/continue.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/continue_hover.png"),
            on_click = function() 
                self.setButtonState(self, false)
                self.background.anim_reverse:gotoFrame(1)
                self.background.animation.reversed = true
                self.background.animation.playing = true                
            end,
            visible = false
        })
        :give("scale", 4)
        :give("position", 40, 128)
    self.manual_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/manual.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/manual_hover.png"),
            on_click = function() Gamestate.push(State.Instructions) end,
            visible = false
        })
        :give("scale", 4)
        :give("position", 528, 128)
    self.retreat_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/retreat.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/retreat_hover.png"),
            on_click = function() Gamestate.switch(State.MainMenu) end,
            visible = false
        })
        :give("scale", 4)
        :give("position", 528, 344)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/target.png")})
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -20)
end

function Pause:setButtonState(enabled)
    self.continue_btn.button.visible = enabled
    self.manual_btn.button.visible = enabled
    self.retreat_btn.button.visible = enabled
end

function Pause:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function Pause:draw()
    self.world:emit("draw")
    self.overlay:emit("draw")
end
return Pause