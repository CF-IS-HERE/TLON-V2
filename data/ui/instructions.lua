local Gamestate = require "data/libraries/hump.gamestate"
instructions = {}

-- No INIT here as we will never INIT into this Gamestate - Matthew

function instructions:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == instructions then
        print("Successfully entered instructions")
    end
end

function instructions:update(dt)

end

function instructions:draw()
 

end