local Game = {}

function Game:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == Game then
        print("Successfuly entered game.")
    end
end

function Game:update(dt)

end

function Game:draw()

end

return Game