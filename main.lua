Gamestate = require "lib/hump.gamestate"

-- set up ECS globals
Concord = require 'lib/concord'
Systems = {}
Concord.utils.loadNamespace("src/components")
Concord.utils.loadNamespace("src/systems", Systems)

-- global game settings
love.graphics.setDefaultFilter( "nearest" )
love.mouse.isVisible = false

State = {}
Concord.utils.loadNamespace("src/states", State)

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(State.MainMenu)
end

function love.update(dt)

    --Debug Function not final solution - Matthew
    function love.keypressed(key)
        if key == "space" and Gamestate.current() ~= State.Game then
            Gamestate.switch(State.Game)
            -- Debug Print - Matthew
            print("The Spacebar key was pressed. Gamestate should switch to Game.")
        end

        if key == "p" and Gamestate.current() ~= State.MainMenu then
            Gamestate.switch(State.Pause)
            -- Debug Print - Matthew
            print("The P key was pressed. Gamestate should switch to Pause.")
    
        end
    end
end

function love.draw()

end