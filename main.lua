Gamestate = require "lib/hump.gamestate"
Vector = require "lib/hump.vector"
Timer = require "lib/hump.timer"
Anim8 = require "lib/anim8.anim8"
Flux = require "lib/flux.flux"

ArrayUtils = require "src/utils/ArrayUtils"
ColorUtils = require "src/utils/ColorUtils"
MathUtils = require "src/utils/MathUtils"
TextUtils = require "src/utils/TextUtils"
Camera = require "src/camera/Camera"

FlashShader = love.graphics.newShader((love.filesystem.read("src/shaders/FLASH.fs")))

-- set up ECS globals
Concord = require 'lib/concord'

Systems = {}
Concord.utils.loadNamespace("src/components")
Concord.utils.loadNamespace("src/systems", Systems)

-- global game settings
IsFullscreen = false
ViewArea = { width = 800, height = 600 }
ViewPort = { width = 800, height = 600, left = 0, top = 0, right = 0, bottom = 0}
DisplayScale = 1
PixelRatio = 4 -- we're working with a 200x150px canvas to work with

function getNewCanvas(ratio)
    ratio = ratio or 1
    return love.graphics.newCanvas(ViewArea.width * ratio, ViewArea.height * ratio)
end

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest") -- ensure proper near neighbor upscaling

    Canvas = {
        ui = getNewCanvas(1 / PixelRatio), -- draw UI background, button etc.
        ui_overlay = getNewCanvas(), -- draw mouse cursor, keep current ratio but just upscale cursor if needed
        game_background = getNewCanvas(1 / PixelRatio),
        game_entities = getNewCanvas(1 / PixelRatio),
        ground_particles = getNewCanvas(1 / PixelRatio),
        sky_particles = getNewCanvas(1 / PixelRatio)
    }

    -- game states like MainMenu, etc. will load their images, this needs to be done after the setDefaultFilter
    State = {}
    Concord.utils.loadNamespace("src/states", State)

    updateViewport(ViewPort.width, ViewPort.height)

    PlayerAssembly = require "src/assemblies/player"
    LemonAssembly = require "src/assemblies/lemon"
    BulletAssembly = require "src/assemblies/bullet"
    CogAssembly = require("src/assemblies/cog")
    ScoreAssembly = require("src/assemblies/score")

    love.mouse.setVisible(false)
    AudioWorld = Concord.world():addSystems(Systems.GameAudioSystem)
    Gamestate.registerEvents()

    -- we're ready to start
    Gamestate.switch(State.MainMenu)
end

function love.update(dt)
    Flux.update(dt)
    Camera.update(dt)
end

function love.keypressed(key)
    if key == "f1" then
        IsFullscreen = not IsFullscreen
        if IsFullscreen then
            love.window.setMode(0, 0, {fullscreen = true})
        else
            love.window.setMode(ViewArea.width, ViewArea.height, {fullscreen = false})
        end
        updateViewport(love.graphics.getWidth(), love.graphics.getHeight())
    end
end

function updateViewport(width, height)
    -- Scale down to fit window while maintaining aspect ratio
    DisplayScale = math.min(width / ViewArea.width, height / ViewArea.height)
	local w, h = love.graphics.getDimensions()
    ViewPort = {
        width = ViewArea.width * DisplayScale,
        height = ViewArea.height * DisplayScale,
        left = w / 2 - ViewArea.width * DisplayScale / 2,
        top = h / 2 - ViewArea.height * DisplayScale / 2,
        right = w / 2 + ViewArea.width * DisplayScale / 2,
        bottom = h / 2 + ViewArea.height * DisplayScale / 2,
    }
end
