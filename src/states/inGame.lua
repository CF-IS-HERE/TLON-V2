local inGame = {}

world = nil

function inGame:enter(previous)
    --Debug if statement - Matthew
    if Gamestate.current() == Game then
        print("Successfuly entered game.")
    end

    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem, Systems.GameAudioSystem, Systems.SpriteImageSystem, Systems.PlayerControlSystem)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    Concord.entity(self.world)
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    sprites = {}
    sprites.player = love.graphics.newImage('assets/images/player.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2

    Concord.entity(self.world) 
        :give("sprite", sprites.player)
        :give("player_controlled")
        :give("player_position", player.x, player.y)
        :give("scale", 1, 1)
        :give("speed", 400)


end

function inGame:update(dt)
    self.world:emit("update", dt)
end

function inGame:draw()
    self.world:emit("draw")
end

return inGame