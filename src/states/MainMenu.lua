local MainMenu = {}

function MainMenu:init()
    local background_img = love.graphics.newImage('assets/images/main_menu/menu_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem)
    self.background = Concord.entity(self.world)
                        :give("image", background_img)
                        :give("scale", background_scale_x, background_scale_y)
                        :give("position", 0, 0)

    self.mouse = love.graphics.newImage("assets/images/mouse/mouseMiddle.png")
    self.mouseOuter = love.graphics.newImage("assets/images/mouse/mouseOuter.png")
    self.homepage_hover = love.graphics.newImage("assets/images/main_menu/homepage_hover.png")
    self.introduction_hover = love.graphics.newImage("assets/images/main_menu/introduction_hover.png")
    self.quit_hover = love.graphics.newImage("assets/images/main_menu/quit_hover.png")
    self.twitter_hover = love.graphics.newImage("assets/images/main_menu/twitter_hover.png")
end

function MainMenu:update(dt)
    -- self.main_menu:emit("update", dt)
end

function MainMenu:draw()
    self.world:emit("draw")
    love.graphics.draw(self.mouse, love.mouse.getX() - 5, love.mouse.getY() - 5, nil, 3.3)
    love.graphics.draw(self.mouseOuter, love.mouse.getX() - 20, love.mouse.getY() - 20, nil, 3.3)
    love.graphics.draw(self.quit_hover, 10, 125)
    love.graphics.draw(self.homepage_hover, 156, 125)
    love.graphics.draw(self.twitter_hover, 137, 125)
    love.graphics.draw(self.introduction_hover, 51, 125)   
end

return MainMenu