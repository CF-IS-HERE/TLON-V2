local Pause = {}

function Pause:enter(previous)
    -- Debug if statement - Matthew
    if Gamestate.current() == pause then
        print("Succesfully entered pause")
    end
end

function Pause:update(dt)
    print("In Pause")
    -- Debug function
    function love.keypressed(key)
        if key == "q" then
            Gamestate.switch(game)
            print("The q key was pressed.")
        end
    end
end

function Pause:draw()

end

return Pause