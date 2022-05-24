local InGame = {}
local bullet_image = love.graphics.newImage("assets/images/playerBullet.png")

world = nil

function InGame:init()
    self.world = Concord.world()
    self.world:addSystems(
        Systems.SpriteSystem, 
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

    self.player = Concord.entity(self.world):assemble(PlayerAssembly, {
        canvas = self.scaled_canvas,
        on_shoot = function() self.spawnBullet(self) end
    })
    Concord.entity(self.world):assemble(LemonAssembly, {
        canvas = self.scaled_canvas
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
    local r_muzzle = (muzzle_offset:clone() + Vector(0, 5)):rotated(angle)
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
        :give("hurtbox", {
            center = r_muzzle,
            radius = 4,
            layer = "enemy",
        })
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