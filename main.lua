local Gamestate = require "data/libraries/hump.gamestate"

require("game")
require("data/ui/menu")


function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)

end

function love.update(dt)
    function love.keypressed(key)
        if key == "space" and Gamestate.get() ~= "game" then
            Gamestate.switch(game)
            -- Debug Print
            print("The Spacebar was Pressed. Game state should switch.")
        end
    end
end

function love.draw()

end