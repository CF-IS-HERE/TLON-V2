Gamestate = require "lib/hump.gamestate"
Anim8 = require "lib/anim8.anim8"
Flux = require "lib/flux.flux"

ColorUtils = require "src/utils/ColorUtils"
TextUtils = require "src/utils/TextUtils"

-- set up ECS globals
Concord = require 'lib/concord'
Vector = require 'lib/hump.vector'

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
    Gamestate.registerEvents()
    Gamestate.switch(State.MainMenu)
end

function love.update(dt)
    Flux.update(dt)
    --Debug Function not final solution - Matthew
    function love.keypressed(key)
        if key == "space" and Gamestate.current() ~= State.inGame then
            Gamestate.switch(State.inGame)
            -- Debug Print - Matthew
            print("The Spacebar key was pressed. Gamestate should switch to Game.")
        end

        if key == "p" and Gamestate.current() ~= State.Pause then
            Gamestate.push(State.Pause)
            -- Debug Print - Matthew
            print("The P key was pressed. Gamestate should switch to Pause.")
        end

        if key == "delete" and Gamestate.current ~= State.Death then
            Gamestate.switch(State.Death)
        end
    end
end

function love.draw()

end