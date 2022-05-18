local Gamestate = require "data/libraries/hump.gamestate"
menu = {}

require('game')

function menu:init() -- This is used on a Gamestate first load... once this loads we just use Gamestate.switch() - Matthew

    self.background = love.graphics.newImage('data/images/main_menu/menu_background.png')
    self.mouse = love.graphics.newImage("data/images/mouse/mouseMiddle.png")
    self.mouseOuter = love.graphics.newImage("data/images/mouse/mouseOuter.png")
    self.homepage_hover = love.graphics.newImage("data/images/main_menu/homepage_hover.png")
    self.introduction_hover = love.graphics.newImage("data/images/main_menu/introduction_hover.png")
    self.quit_hover = love.graphics.newImage("data/images/main_menu/quit_hover.png")
    self.twitter_hover = love.graphics.newImage("data/images/main_menu/twitter_hover.png")

end

function menu:enter(previous) -- This is used if we return back to the menu from another gamestate. With Gamestate.switch() - Matthew

end

function menu:update(dt)

end

function menu:draw()
    
    love.mouse.isVisible = false

    -- Background Draw - Matthew
    local bgSX = love.graphics.getWidth() / self.background:getWidth()
    local bgSY = love.graphics.getHeight() / self.background:getHeight()
    love.graphics.draw(self.background, 0, 0, nil, bgSX, bgSY)

    -- Mouse Icon Draw, this may need to be redone to scale window resizing - Matthew
    love.graphics.draw(self.mouse, love.mouse.getX() - 5, love.mouse.getY() - 5, nil, 3.3)
    love.graphics.draw(self.mouseOuter, love.mouse.getX() - 20, love.mouse.getY() - 20, nil, 3.3)


    -- Gad I haven't done anything with these... they are just on the screen. - Matthew
    love.graphics.draw(self.quit_hover, 10, 125)
    love.graphics.draw(self.homepage_hover, 156, 125)
    love.graphics.draw(self.twitter_hover, 137, 125)
    love.graphics.draw(self.introduction_hover, 51, 125)   

end