local MainMenu = {}

function MainMenu:init()
    local background_img = love.graphics.newImage('assets/images/main_menu/main_menu_en.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.world = Concord.world()
    self.world:addSystems(Systems.AnimatedImageSystem, Systems.UIButtonSystem)
    self.background = Concord.entity(self.world)
        :give("animation", {
            total_frames = 4,
            speed = 0.2,
            playing = false
        })
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x * 4, background_scale_y)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/play.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/play_hover.png"),
            on_click = function() Gamestate.switch(State.inGame) end,
            on_mouse_enter = function()
                self.background.anim:gotoFrame(1)
                self.background.animation.reversed = false
                self.background.animation.playing = true
            end,
            on_mouse_leave = function()
                self.background.anim_reverse:gotoFrame(1)
                self.background.animation.reversed = true
                self.background.animation.playing = true
            end
        })
        :give("scale", 4)
        :give("position", 40, 500)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/manual.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/manual_hover.png"),
            on_click = function() Gamestate.push(State.Instructions) end
        })
        :give("scale", 4)
        :give("position", 204, 500)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/twitter.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/twitter_hover.png"),
            on_click = function() print(love.system.openURL("https://twitter.com")) end
        })
        :give("scale", 4)
        :give("position", 548, 500)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/home.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/home_hover.png"),
            on_click = function() print(love.system.openURL("https://itch.io")) end
        })
        :give("scale", 4)
        :give("position", 624, 500)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/quit.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/quit_hover.png"),
            on_click = function() love.event.quit() end
        })
        :give("scale", 4)
        :give("position", 700, 500)
    
    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.StaticImageSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("image", love.graphics.newImage("assets/images/mouse/pointer.png"))
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -5, -5)
end

function MainMenu:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function MainMenu:draw()
    self.world:emit("draw")
    self.overlay:emit("draw")
end

return MainMenu