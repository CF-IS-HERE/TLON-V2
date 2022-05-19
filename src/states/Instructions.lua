local Instructions = {}

function Instructions:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == instructions then
        print("Successfully entered instructions")
    end
end

function Instructions:update(dt)

end

function Instructions:draw()
 
end

return Instructions