local InGame = {}

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem,
        Systems.PlayerControlSystem,
        Systems.AiControlSystem,
        Systems.CollisionSystem,
        Systems.WeaponSystem,
        Systems.BulletControlSystem,
        Systems.OutOfScreenDespawnSystem,
        Systems.ParticleSystem)

    Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage('assets/images/game_background.png')})
        :give("scale")
        :give("position")
        :give("layer", Canvas.game_background)

    self.player = Concord.entity(self.world):assemble(PlayerAssembly, {
        on_shoot = function() self:spawnBullet(self) end
    })

    self.splat_canvases = {} -- list of canvases that never get cleared so that the particles can have a splat effect
    Timer.every(1, function()
        local splat_canvas = getNewCanvas(1/4)
        local lemon = Concord.entity(self.world):assemble(LemonAssembly, {
            splat_canvas = splat_canvas
        })
        table.insert(self.splat_canvases, {
            lemon = lemon,
            canvas = splat_canvas
        })
    end)

    self.overlay = Concord.world()
    self.overlay:addSystems(
        Systems.MouseCursorSystem,
        Systems.SpriteSystem
    )
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/target.png")})
        :give("layer", Canvas.ui_overlay)
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -5, -5)
end

function InGame:cleanupSplats()
    for i, s in ipairs(self.splat_canvases) do
        if self.splat_canvases[i].canvas.color.a <= 0 then
            self.splat_canvases[i] = nil
        end
    end
    ArrayUtils.compact(self.splat_canvases)
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
    love.graphics.draw(Canvas.game_background, viewportLeft, viewportTop, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    -- love.graphics.draw(Canvas.game_background, viewportLeft + shakeX * displayScale, viewportTop + shakeY * displayScale, 0, displayScale, displayScale)

    -- draw the splats on the ground next
    local r,g,b,a = love.graphics.getColor()
    -- draw splats first as they are each drawn on their own canvas
    -- to remove the splats from the game, we first reduce the opacity of their associated canvases
    for _, c in ipairs(self.splat_canvases) do
        if c.lemon.layer.color.a > 0 then
            love.graphics.setColor(1, 1, 1, c.lemon.layer.color.a)
            love.graphics.draw(c.canvas, 0, 0, 0, 4, 4)
        end
    end
    love.graphics.setColor(r,g,b,a)

    love.graphics.draw(Canvas.ground_particles, viewportLeft, viewportTop, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.game_entities, viewportLeft, viewportTop, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.sky_particles, viewportLeft, viewportTop, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.ui_overlay, viewportLeft , viewportTop, 0, DisplayScale, DisplayScale)

end

return InGame