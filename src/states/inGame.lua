local inGame = {}

world = nil

function inGame:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == Game then
        print("Successfuly entered game.")
    end

    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem, Systems.GameAudioSystem)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    Concord.entity(self.world)
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    self.game = Concord.world()    
    self.game:addSystems(Systems.SpriteSystem, Systems.PlayerControlledSystem, Systems.MovementSystem, Systems.KeyInputSystem)

    sprites = {}
    sprites.player = love.graphics.newImage('assets/images/player.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 180


    Concord.entity(self.game)
        :give("sprite", sprites.player)
        :give("position", player.x, player.y)
        :give("pos", player.x, player.y)
        :give("playerControlled")
        :give("directionIntent")
        :give("clearDirectionIntent")
        :give("lookAt")
        :give("scale", 1, 1)
        :give("type", "player")
        :give("speed", 800)

end

function inGame:update(dt)
    self.world:emit("update", dt)
    self.game:emit("update", dt)
end

function inGame:draw()
    self.world:emit("draw")
    self.game:emit("draw")  
end

return inGame