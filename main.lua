local Gamestate = require "data/libraries/hump.gamestate"

require("game")
require("data/ui/menu")
require("data/ui/pause")
require("data/ui/instructions")


function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(menu)

end

function love.update(dt)

    --Debug Function not final solution - Matthew
    function love.keypressed(key)
        if key == "space" and Gamestate.current() ~= game then
            Gamestate.switch(game)
            -- Debug Print - Matthew
            print("The Spacebar key was pressed. Gamestate should switch to Game.")
        end

        if key == "p" and Gamestate.current() ~= menu then
            Gamestate.switch(pause)
            -- Debug Print - Matthew
            print("The P key was pressed. Gamestate should switch to Pause.")
    
        end
    end
end

function love.draw()

end