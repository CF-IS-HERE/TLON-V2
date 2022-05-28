local InGame = {}

function InGame:init()
    self.scaled_canvas = love.graphics.newCanvas(200, 150)
    self.ground_canvas = love.graphics.newCanvas(200, 150) -- used for ground particles
    self.sky_canvas = love.graphics.newCanvas(200, 150) -- used for sky particles
    self.splat_canvases = {} -- these are never cleared for a splat effect

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

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()
    Concord.entity(self.world)
        :give("sprite", {image = background_img})
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    self.player = Concord.entity(self.world):assemble(PlayerAssembly, {
        canvas = self.scaled_canvas,
        ground_canvas = self.ground_canvas,
        sky_canvas = self.sky_canvas,
        on_shoot = function() self:spawnBullet(self) end
    })

    Timer.every(1, function() 
        local splat_canvas = love.graphics.newCanvas(200, 150)
        local lemon = Concord.entity(self.world):assemble(LemonAssembly, {
            canvas = self.scaled_canvas,
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
        canvas = self.scaled_canvas,
        sky_canvas = self.sky_canvas,
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
    for _, c in ipairs({self.scaled_canvas, self.ground_canvas, self.sky_canvas}) do
        love.graphics.setCanvas(c)
        love.graphics.clear()
    end
    love.graphics.setCanvas()

    self.world:emit("draw") -- this will draw things to the scaled canvas and the particle canvas
    -- make sure we're back on the main screen before drawing
    love.graphics.setCanvas()
    -- draw splats first as they are each drawn on their own canvas
    local r,g,b,a = love.graphics.getColor()
    for _, c in ipairs(self.splat_canvases) do
        if c.lemon.layer.color.a > 0 then
            love.graphics.setColor(1, 1, 1, c.lemon.layer.color.a)
            love.graphics.draw(c.canvas, 0, 0, 0, 4, 4)
        end
    end
    love.graphics.setColor(r,g,b,a)
    love.graphics.draw(self.ground_canvas, 0, 0, 0, 4, 4)
    love.graphics.draw(self.scaled_canvas, 0, 0, 0, 4, 4)
    love.graphics.draw(self.sky_canvas, 0, 0, 0, 4, 4)
    self.overlay:emit("draw")
end

return InGame