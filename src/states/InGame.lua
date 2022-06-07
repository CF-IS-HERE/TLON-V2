local InGame = {}
local score_font = love.graphics.newFont("assets/fonts/nokia.ttf", 30)

local wave = 1
local eCount = 0
local spawnCount = 4

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem,
        Systems.PlayerControlSystem,
        Systems.ScoreTextSystem,
        Systems.AiControlSystem,
        Systems.CollisionSystem,
        Systems.WeaponSystem,
        Systems.BulletControlSystem,
        Systems.OutOfScreenDespawnSystem,
        Systems.ParticleSystem,
        Systems.UILabelSystem)

    Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage('assets/images/game_background.png')})
        :give("scale")
        :give("position")
        :give("layer", Canvas.game_background)

    self.player = Concord.entity(self.world):assemble(PlayerAssembly, {
        on_shoot = function()
            self:spawnBullet(self)
            self.cursor.rotation.ticks = 1
        end
    })

<<<<<<< HEAD
    Timer.every(1, function() self:startWaveCheck() end)
=======
    self.score_text = Concord.entity(self.world)
        :give("label", {
            font = score_font,
            color = {r=240/255, g=240/255, b=230/255, a=1},
            text = Score
        })
        :give("layer", Canvas.ui_overlay)
        :give("position", 16, 8)

    self.splat_canvases = {} -- list of canvases that never get cleared so that the particles can have a splat effect
    Timer.every(1, function()
        local splat_canvas = getNewCanvas(1/4)
        local lemon = Concord.entity(self.world):assemble(LemonAssembly, {
            splat_canvas = splat_canvas,
            on_destroy = function(lemon)
                self:spawnScore({x=lemon.position.x-6, y=lemon.position.y})
                self:increaseScore(100)
                if lemon.ai_controlled.has_item then
                    local position = {x=lemon.position.x + 12, y=lemon.position.y + 12}
                    self:releaseCog(position)
                end
            end
        })
        table.insert(self.splat_canvases, {
            lemon = lemon,
            canvas = splat_canvas
        })
    end)
>>>>>>> 08c90de1a20b06f97c0c63e17717b7eb1fe68e79

    self.overlay = Concord.world()
    self.overlay:addSystems(
        Systems.MouseCursorSystem,
        Systems.SpriteSystem,
        Systems.RotatingSpriteSystem
    )
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/mouseMiddle.png")})
        :give("layer", Canvas.ui_overlay)
        :give("scale", 3)
        :give("position")
        :give("follow_cursor")
    self.cursor = Concord.entity(self.overlay)
        :give("sprite", {
            image = love.graphics.newImage("assets/images/mouse/mouseOuter.png"),
            offset = Vector(6, 6)
        })
        :give("layer", Canvas.ui_overlay)
        :give("scale", 3)
        :give("position")
        :give("rotation", {
            speed = 10
        })
        :give("follow_cursor", 12, 12)
end

function InGame:increaseScore(amount)
    Score = Score + amount
    self.score_text.label.text = tostring(Score)
end

function InGame:cleanupSplats()
    for i, s in ipairs(self.splat_canvases) do
        if self.splat_canvases[i].canvas.color.a <= 0 then
            self.splat_canvases[i] = nil
        end
    end
    ArrayUtils.compact(self.splat_canvases)
end

function updateeCount()
    print("Update eCount Ran")
    eCount = eCount - 1
end

function InGame:startWaveCheck()
    if eCount < spawnCount then
        self:spawnLemon()
    elseif eCount == 0 then
        Timer.after(5, self:updateWave())
    end
end

function InGame:updateWave()
    wave = wave + 1
    spawnCount = 2 + ((wave * 2) / 2)
    print("Wave Updated, New wave is: ".. wave .. "New spawnCount is: ".. spawnCount)
end

function InGame:spawnLemon()
    self.lemon = Concord.entity(self.world):assemble(LemonAssembly, {
        canvas = self.scaled_canvas
    })
    eCount = eCount + 1
    print("eCount: "..eCount)
    print("spawnCount: "..spawnCount)
    print("Lemon Spawned")
end

function InGame:enter()
    AudioWorld:emit("playMusic")
    -- coming in from main menu, the player might have the mouse button down already
    self.player.weapon.can_shoot = false
    Timer.after(0.2, function() self.player.weapon.can_shoot = true end)
end

function InGame:spawnBullet()
    Concord.entity(self.world):assemble(BulletAssembly, {
        player = self.player
    })
    AudioWorld:emit("playShotSound")
end

function InGame:spawnScore(position)
    Concord.entity(self.world):assemble(ScoreAssembly, {
        position = position,
        text = "100"
    })
end

function InGame:releaseCog(position)
    Concord.entity(self.world):assemble(CogAssembly, {
        position = position
    })
end

function InGame:update(dt)
    Timer.update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
    if love.keyboard.isDown("escape") then
        AudioWorld:emit("sysCleanUp")
        Gamestate.push(State.Pause)
    end
end

function InGame:draw()

    -- clean canvas before drawing on it
    for _, c in ipairs({Canvas.game_background, Canvas.game_entities, Canvas.ground_particles, Canvas.game_entities, Canvas.sky_particles, Canvas.ui_overlay}) do
        love.graphics.setCanvas(c)
        love.graphics.clear()
    end
    -- always draw into specific canvases
    self.world:emit("draw")
    self.overlay:emit("draw")

    love.graphics.setCanvas()

    -- start drawing canvases in order
    local shake = Camera.getCurrentShake()
    love.graphics.draw(Canvas.game_background, ViewPort.left + shake.x, ViewPort.top + shake.y, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)

    -- draw the splats on the ground next
    local r,g,b,a = love.graphics.getColor()
    -- draw splats first as they are each drawn on their own canvas
    -- to remove the splats from the game, we first reduce the opacity of their associated canvases
    for _, c in ipairs(self.splat_canvases) do
        if c.lemon.layer.color.a > 0 then
            love.graphics.setColor(1, 1, 1, c.lemon.layer.color.a)
            love.graphics.draw(c.canvas, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
        end
    end
    love.graphics.setColor(r,g,b,a)

    love.graphics.draw(Canvas.ground_particles, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.game_entities, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.sky_particles, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.ui_overlay, ViewPort.left , ViewPort.top, 0, DisplayScale, DisplayScale)

end

function InGame:waveMessage()
    print("Next Wave Starting...")
end

return InGame