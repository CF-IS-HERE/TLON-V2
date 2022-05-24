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
BulletAssembly = require "src/assemblies/bullet"

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
end

function love.draw()

end