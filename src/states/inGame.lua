local InGame = {}

world = nil

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem, 
        Systems.GameAudioSystem,
        Systems.PlayerControlSystem, 
        Systems.AiControlSystem)
    self.game_layer = love.graphics.newCanvas(200, 150)

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
            layer = self.game_layer,
            total_frames = 5
        })
        :give("player_controlled")
        :give("position", player.x, player.y)
        :give("scale", 1, 1)
        :give("speed", 200)

    Concord.entity(self.world)
        :give("sprite", {
            image = love.graphics.newImage('assets/images/lemon.png'),
            layer = self.game_layer
        })
        :give("ai_controlled")
        :give("position", ai.x, ai.y)
        :give("scale", 1, 1)
        :give("speed", 130)

    self.overlay = Concord.world()
    self.overlay:addSystems(
        Systems.MouseCursorSystem,
        Systems.StaticImageSystem
    )

end

function InGame:update(dt)
    self.world:emit("update", dt)
end

function InGame:draw()
    -- clean canvas before drawing on it
    love.graphics.setCanvas(self.game_layer)
    love.graphics.clear()
    love.graphics.setCanvas()
    self.world:emit("draw")
    love.graphics.draw(self.game_layer, 0, 0, 0, 4, 4)
end

return InGame