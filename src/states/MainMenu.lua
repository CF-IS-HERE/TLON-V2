local MainMenu = {}

function MainMenu:init()
    local background_img = love.graphics.newImage('assets/images/main_menu/menu_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem, Systems.ClickableButtonSystem)
    Concord.entity(self.world)
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x, background_scale_y)
    Concord.entity(self.world)
        :give("hover", love.graphics.newImage("assets/images/main_menu/help.png"), love.graphics.newImage("assets/images/main_menu/help_hover.png"))
        :give("scale", 4, 4)
        :give("position", 204, 500)
        :give("callback", function() Gamestate.switch(State.Instructions) end)
    Concord.entity(self.world)
        :give("hover", love.graphics.newImage("assets/images/main_menu/twitter.png"), love.graphics.newImage("assets/images/main_menu/twitter_hover.png"))
        :give("scale", 4, 4)
        :give("position", 548, 500)
        :give("callback", function() print(love.system.openURL("https://twitter.com/CF_IS_HERE")) end)
    Concord.entity(self.world)
        :give("hover", love.graphics.newImage("assets/images/main_menu/homepage.png"), love.graphics.newImage("assets/images/main_menu/homepage_hover.png"))
        :give("scale", 4, 4)
        :give("position", 624, 500)
        :give("callback", function() print(love.system.openURL("https://leyuan.wixsite.com/love/en?ref=lemonia")) end)
    Concord.entity(self.world)
        :give("hover", love.graphics.newImage("assets/images/main_menu/quit.png"), love.graphics.newImage("assets/images/main_menu/quit_hover.png"))
        :give("scale", 4, 4)
        :give("position", 700, 500)
        :give("callback", function() love.event.quit() end)
    
    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.StaticImageSystem, Systems.MouseCursorSystem)
    self.mouse = Concord.entity(self.overlay)
                        :give("image", love.graphics.newImage("assets/images/mouse/pointer.png"))
                        :give("scale", 3, 3)
                        :give("position")
                        :give("follow_cursor")
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