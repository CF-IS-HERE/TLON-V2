local inGame = {}

world = nil

function inGame:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == Game then
        print("Successfuly entered game.")
    end

    self.world = Concord.world()
    self.world:addSystems(Systems.PlayerControlledSystem, Systems.StaticImageSystem, Systems.KeyInputSystem)

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


    --Drawing of the player is not correct. I will need to look into this... not sure if this is a draw order issue.    
    self.overlaytest = Concord.world()
    self.overlaytest:addSystems(Systems.PlayerControlledSystem, Systems.KeyInputSystem)
    Concord.entity(self.overlaytest)
        :give("sprite", sprites.player)
        :give("position", player.x, player.y)
        :give("speed", player.speed)
        :give("health", 20)
        :give("playerControlled")
end

function inGame:update(dt)
    self.world:emit("update", dt)
    self.overlaytest:emit("update", dt)
end

function inGame:draw()
    self.world:emit("draw")
    self.overlaytest:emit("draw")    
end

return inGame