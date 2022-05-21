local inGame = {}

world = nil

function inGame:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == Game then
        print("Successfuly entered game.")
    end

    self.world = Concord.world()
    self.world:addSystems(Systems.PlayerControlledSystem, Systems.StaticImageSystem, Systems.KeyInputSystem, Systems.GameAudioSystem, Systems.MovementSystem)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    sprites = {}
    sprites.player = love.graphics.newImage('assets/images/player.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 180

    Concord.entity(self.world)
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x, background_scale_y)
    Concord.entity(self.world)
        :give("image", sprites.player)
        :give("position", player.x, player.y)
        :give("scale", 1, 1)
        :give("playerControlled")
        :give("type", "player")
        :give("lookAt")
        :give("directionIntent")
        :give("speed", 180)
        :give("health", 20)


end

function inGame:update(dt)
    self.world:emit("update", dt)
end

function inGame:draw()
    self.world:emit("draw")  
end

return inGame