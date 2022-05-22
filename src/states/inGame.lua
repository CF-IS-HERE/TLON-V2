local InGame = {}

world = nil

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem, 
        Systems.GameAudioSystem,
        Systems.PlayerControlSystem, 
        Systems.AiControlSystem,
        Systems.WeaponSystem)
    self.scaled_canvas = love.graphics.newCanvas(200, 150)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    Concord.entity(self.world)
        :give("sprite", {image = background_img})
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    player = {}
    player.x = love.graphics.getWidth() / 8
    player.y = love.graphics.getHeight() / 8

    ai = {}
    ai.x = 0
    ai.y = 0

    Concord.entity(self.world) 
        :give("sprite", {
            image = love.graphics.newImage('assets/images/player.png'),
            total_frames = 5,
            offset = Vector(5, 0)
        })
        :give("layer", self.scaled_canvas)
        :give("player_controlled")
        :give("position", player.x, player.y)
        :give("velocity")
        :give("speed", 2)
        :give("weapon", {
            image = love.graphics.newImage("assets/images/shooter.png"),
            latency = 0.2,
            on_shoot = function() print("shooting") end
        })

    -- Concord.entity(self.world)
    --     :give("sprite", {
    --         image = love.graphics.newImage('assets/images/lemon.png'),
    --     })
    --     :give("layer", self.scaled_canvas)
    --     :give("ai_controlled")
    --     :give("position", ai.x, ai.y)
    --     :give("speed", 50)

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

function InGame:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function InGame:draw()
    -- clean canvas before drawing on it
    love.graphics.setCanvas(self.scaled_canvas)
    love.graphics.clear()
    love.graphics.setCanvas()
    self.world:emit("draw")
    love.graphics.draw(self.scaled_canvas, 0, 0, 0, 4, 4)
    self.overlay:emit("draw")
end

return InGame