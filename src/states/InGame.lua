local InGame = {}

function InGame:init()
    self.scaled_canvas = love.graphics.newCanvas(200, 150)
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem, 
        Systems.PlayerControlSystem, 
        Systems.AiControlSystem,
        Systems.CollisionSystem,
        Systems.WeaponSystem,
        Systems.BulletControlSystem,
        Systems.OutOfScreenDespawnSystem)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()
    Concord.entity(self.world)
        :give("sprite", {image = background_img})
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    self.player = Concord.entity(self.world):assemble(PlayerAssembly, {
        canvas = self.scaled_canvas,
        on_shoot = function() self:spawnBullet(self) end
    })

    Timer.every(1, function() 
        Concord.entity(self.world):assemble(LemonAssembly, {
            canvas = self.scaled_canvas
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

function InGame:enter()
    AudioWorld:emit("playMusic")
end

function InGame:spawnBullet()
    Concord.entity(self.world):assemble(BulletAssembly, {
        canvas = self.scaled_canvas,
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
    love.graphics.setCanvas(self.scaled_canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
    self.world:emit("draw") -- this will draw things to the scaled canvas
    -- make sure we're back on the main screen before drawing
    love.graphics.setCanvas()
    love.graphics.draw(self.scaled_canvas, 0, 0, 0, 4, 4)
    self.overlay:emit("draw")
end

return InGame