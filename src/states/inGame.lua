local InGame = {}
local show_hitbox = false
local bullet_image = love.graphics.newImage("assets/images/playerBullet.png")

world = nil

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem, 
        Systems.GameAudioSystem,
        Systems.PlayerControlSystem, 
        Systems.AiControlSystem,
        Systems.CollisionSystem,
        Systems.WeaponSystem,
        Systems.BulletControlSystem,
        Systems.OutOfScreenDespawnSystem)
    self.scaled_canvas = love.graphics.newCanvas(200, 150)

    local background_img = love.graphics.newImage('assets/images/game_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    Concord.entity(self.world)
        :give("sprite", {image = background_img})
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    self.player = Concord.entity(self.world) 
        :give("sprite", {
            image = love.graphics.newImage('assets/images/player.png'),
            total_frames = 5,
            offset = Vector(5, 0)
        })
        :give("layer", self.scaled_canvas)
        :give("player_controlled")
        :give("position", love.graphics.getWidth() / 8, love.graphics.getHeight() / 8)
        :give("velocity")
        :give("speed", 2)
        :give("health", {max = 5})
        :give("weapon", {
            image = love.graphics.newImage("assets/images/shooter.png"),
            latency = 0.1,
            on_shoot = function() self:spawnBullet() end,
            offset = Vector(2, -2),
            muzzle_offset = Vector(6, -2)
        })
        :give("hitbox", {
            offset_x = -8,
            offset_y = 4,
            width = 6,
            height = 5,
            layer = "player",
            on_entered = function(player, foe)
                if not player.health.invincible and player.health.current > 0 then
                    player.health.current = player.health.current - 1
                    player.sprite.current_frame = player.sprite.current_frame + 1
                    player.health.invincible = true
                    foe.ai_controlled.has_item = true
                    self.world:emit("playPlayerHitSound")
                    Timer.after(2, function()
                        player.health.invincible = false
                    end)
                end
            end,
            rendered = show_hitbox
        })

    Concord.entity(self.world)
        :give("sprite", {
            image = love.graphics.newImage('assets/images/lemon.png'),
        })
        :give("layer", self.scaled_canvas)
        :give("ai_controlled")
        :give("out_of_screen_despawn")
        :give("position")
        :give("speed", 50)
        :give("hurtbox", {
            offset_x = 5,
            offset_y = 3,
            width = 6,
            height = 5,
            layer = "player",
            rendered = show_hitbox
        })

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

function InGame:spawnBullet()
    local player_center = Vector(self.player.position.x - 5, self.player.position.y + 9)
    local mouse_center = Vector(love.mouse.getX() + 14, love.mouse.getY() + 14)
    local muzzle_offset = self.player.weapon.muzzle_offset
    local muzzle_center = player_center + muzzle_offset
    local rnd_spread = love.math.random(-self.player.weapon.bullet_spread, self.player.weapon.bullet_spread)
    local angle = (mouse_center / 4 - muzzle_center):angleTo() + MathUtils.deg2rad(rnd_spread)
    local velocity = Vector(self.player.weapon.bullet_speed, 0):rotated(angle)
    local position = player_center + muzzle_offset:rotated(angle)

    Concord.entity(self.world)
        :give("sprite", {
            image = bullet_image,
            rotation = angle
        })
        :give("layer", self.scaled_canvas)
        :give("cruise_controlled")
        :give("out_of_screen_despawn")
        :give("position", position.x, position.y)
        :give("velocity", velocity.x, velocity.y)
    self.world:emit("playShotSound")

end

function InGame:update(dt)
    Timer.update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
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