local Gamestate = require "data/libraries/hump.gamestate"
pause = {}

-- No INIT function here as we will never INIT into this Gamestate - Matthew

function pause:enter(previous)
    -- Debug if statement - Matthew
    if Gamestate.current() == pause then
        print("Succesfully entered pause")
    end
end

function pause:update(dt)
    print("In Pause")
    -- Debug function noy final solution - Matthew
    function love.keypressed(key)
        if key == "q" then
            Gamestate.switch(game)
            print("The q key was pressed.")
        end
    end
end

function pause:draw()
 

end