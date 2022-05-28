Gamestate = require "lib/hump.gamestate"
Vector = require "lib/hump.vector"
Timer = require "lib/hump.timer"
Anim8 = require "lib/anim8.anim8"
Flux = require "lib/flux.flux"

ArrayUtils = require "src/utils/ArrayUtils"
ColorUtils = require "src/utils/ColorUtils"
MathUtils = require "src/utils/MathUtils"
TextUtils = require "src/utils/TextUtils"

FlashShader = love.graphics.newShader((love.filesystem.read("src/shaders/FLASH.fs")))

-- set up ECS globals
Concord = require 'lib/concord'

Systems = {}
Concord.utils.loadNamespace("src/components")
Concord.utils.loadNamespace("src/systems", Systems)

-- global game settings

-- game states like MainMenu, etc.
State = {}
Concord.utils.loadNamespace("src/states", State)

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    PlayerAssembly = require "src/assemblies/player"
    LemonAssembly = require "src/assemblies/lemon"
    BulletAssembly = require "src/assemblies/bullet"
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