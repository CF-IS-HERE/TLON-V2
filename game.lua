local Gamestate = require "data/libraries/hump.gamestate"

game = {}

function game:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == game then
        print("Successfuly entered game.")
    end
end

function game:update(dt)

end

function game:draw()

end