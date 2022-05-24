Gamestate = require "lib/hump.gamestate"
Vector = require "lib/hump.vector"
Timer = require "lib/hump.timer"
Anim8 = require "lib/anim8.anim8"
Flux = require "lib/flux.flux"

ColorUtils = require "src/utils/ColorUtils"
MathUtils = require "src/utils/MathUtils"
TextUtils = require "src/utils/TextUtils"

-- set up ECS globals
Concord = require 'lib/concord'

Systems = {}
Concord.utils.loadNamespace("src/components")
Concord.utils.loadNamespace("src/systems", Systems)

PlayerAssembly = require "src/assemblies/player"
LemonAssembly = require "src/assemblies/lemon"

-- global game settings
love.graphics.setDefaultFilter("nearest")

-- game states like MainMenu, etc.
State = {}
Concord.utils.loadNamespace("src/states", State)

function love.load()
    love.mouse.setVisible(false)
    AudioWorld = Concord.world():addSystems(Systems.GameAudioSystem)
    Gamestate.registerEvents()
    Gamestate.switch(State.MainMenu)
end

function love.update(dt)
    Flux.update(dt)
    --Debug Function not final solution - Matthew
    function love.keypressed(key)
        if key == "space" and Gamestate.current() ~= State.InGame then
            Gamestate.switch(State.InGame)
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