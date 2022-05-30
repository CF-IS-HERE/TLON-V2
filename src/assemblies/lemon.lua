local images = {}

local lemon_colors = {
	{r={a=232/255,b=232/255}, g={a=193/255,b=193/255}, b={a=112/255,b=112/255}, a={a=1,b=1}}, -- orange
	{r={a=208/255,b=208/255}, g={a=218/255,b=218/255}, b={a=145/255,b=145/255}, a={a=1,b=1}}, -- green
	{r={a=223/255,b=223/255}, g={a=132/255,b=132/255}, b={a=165/255,b=165/255}, a={a=1,b=1}}  -- purple
}

for i=1,3 do
    local filename = "lemon"..i..".png"
    images[i] = love.graphics.newImage("assets/images/"..filename)
end

local getRandomPosition = function()
    local side = math.random(1, 4)
    local x , y = nil, nil
    if side == 1 then
        x = -15
        y = math.random(0, love.graphics.getHeight() / 4)
    elseif side == 2 then
        x = (love.graphics.getWidth() + 15)
        y = math.random(0, love.graphics.getHeight() / 4)
    elseif side == 3 then
        x = math.random(0, love.graphics.getWidth() / 4)
        y = -15
    elseif side == 4 then
        x = math.random(0, love.graphics.getWidth() / 4)
        y = (love.graphics.getHeight() + 15)
    end
    return x, y
end

return function(entity, options)
    local nb = math.random(1, 3)
    local filename = "lemon"..nb..".png"
    local x, y = getRandomPosition()
    entity:give("sprite", {
        image = images[nb],
    })
    entity:give("layer", Canvas.game_entities)
    entity:give("ai_controlled")
    entity:give("out_of_screen_despawn")
    entity:give("position", x, y)
    entity:give("health", {max = options.health or 4})
    entity:give("active")
    entity:give("scale")
    entity:give("speed", 50)
    entity:give("knockback")
    entity:give("hurtbox", {
        center = Vector(8, 6),
        radius = 3,
        layer = "player",
    })
    entity:give("particles", {
        explode = {
            canvas = options.splat_canvas,
            spawning = true,
            amount = {a=4, b=5},
            tick_speed = {a=0.1, b=0.11},
            spread = 20,
            speed = {a=130, b=200},
            rotation = {a=0, b=0},
            force = Vector(3, 0),
            color = lemon_colors[nb],
            width = {a=4, b=8},
            lifetime = {a=0.1, b=0.25},
            draw_mode = "circle"
        },
        hit = {
            canvas = Canvas.sky_particles,
            spawning = true,
            amount = {a=10, b=15},
            tick_speed = {a=0.1, b=0.11},
            spread = 360,
            speed = {a=10, b=40},
            rotation = {a=100, b=100},
            color = lemon_colors[nb],
            width = {a=.2, b=.5},
            lifetime = {a=0.5, b=1},
            draw_mode = "circle"
        },
        death = {
            canvas = Canvas.sky_particles,
            spawning = true,
            amount = {a=10, b=12},
            tick_speed = {a=0.1, b=0.11},
            spread = 360,
            speed = {a=20, b=101},
            rotation = {a=100, b=100},
            color = {r={a=0.99, b=1}, g={a=0.99, b=1}, b={a=0.99, b=1}, a={a=0.99, b=1}},
            width = {a=1, b=2},
            lifetime = {a=0.5, b=1},
            draw_mode = "circle"
        }
    })
    entity:give("hitbox", {
        center = Vector(8, 6),
        radius = 6,
        layer = "enemy",
        on_entered = function(lemon, bullet) -- hit by a bullet
            local knockback_angle = Vector(bullet.position.x - lemon.position.x, bullet.position.y - lemon.position.y):angleTo() + math.pi
            local knockback = Vector(2, 0):rotated(knockback_angle)
            if lemon.health.current > 0 and not lemon.health.invincible then
                lemon.health.current = lemon.health.current - 1
                lemon.health.invincible = true
                lemon.sprite.flash_intensity = 0.7
                lemon.particles.emitters.hit.ticks = 1
                Timer.after(0.1, function()
                    lemon.health.invincible = false
                end)
                if not lemon.ai_controlled.has_item then -- don't knock back as they're already running away
                    lemon.knockback.x = knockback.x
                    lemon.knockback.y = knockback.y
                end
                AudioWorld:emit("playEnemyHitSound")
            elseif lemon.health.current == 0 then
                lemon.particles.emitters.explode.ticks = 1
                lemon.particles.emitters.explode.offset = {x = lemon.knockback.x * -1, y = lemon.knockback.y * -1}
                lemon.particles.emitters.explode.rotation = {a=knockback_angle, b=knockback_angle}
                lemon.particles.emitters.death.ticks = 1
                -- only destroy the entity after the splat is destroyed
                lemon.active = false
                lemon.sprite.visible = false
                Camera.shake(2, 0.3)
                AudioWorld:emit("playEnemyDeathSound")
            end
            bullet:destroy()
        end
    })
end