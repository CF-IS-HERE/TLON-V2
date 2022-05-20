Gamestate = require "lib/hump.gamestate"
Anim8 = require "lib/anim8.anim8"

-- set up ECS globals
Concord = require "lib/concord"
Systems = {}
Concord.utils.loadNamespace("src/components")
Concord.utils.loadNamespace("src/systems", Systems)

-- global game settings
love.graphics.setDefaultFilter( "nearest" )

-- game states like MainMenu, etc.
State = {}
Concord.utils.loadNamespace("src/states", State)

function love.load()
    love.mouse.setVisible(false)
    love.audio.setVolume(0.1)
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