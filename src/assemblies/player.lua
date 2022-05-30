local player_image = love.graphics.newImage('assets/images/player.png')
local weapon_image = love.graphics.newImage("assets/images/shooter.png")
local position = Vector(love.graphics.getWidth(), love.graphics.getHeight()) / 8

return function(entity, options)
    entity:give("sprite", {
        image = player_image,
        total_frames = 5,
        offset = Vector(5, 0)
    })
    entity:give("layer", Canvas.game_entities)
    entity:give("player_controlled")
    entity:give("position", position.x, position.y)
    entity:give("scale")
    entity:give("velocity")
    entity:give("active")
    entity:give("speed", 2)
    entity:give("health", {max = 4})
    entity:give("weapon", {
        image = weapon_image,
        latency = 0.1,
        on_shoot = options.on_shoot,
        offset = Vector(2, -2),
        muzzle_offset = Vector(6, -2)
    })
    entity:give("particles", {
        run = {
            canvas = Canvas.ground_particles,
            spawning = true,
            tick_speed = {a=0.1, b=0.21},
            offset = Vector(0, 15),
            spread = 360,
            speed = {a=0, b=20},
            rotation = {a=0, b=1},
            color = {
                r = {a=0.921, b=0.921},
                g = {a=0.929, b=0.929},
                b = {a=0.913, b=0.913},
                a = {a=0.99, b=1}
            },
            width = {a=3, b=3.1},
            lifetime = {a=1, b=1.01},
            draw_mode = "circle_glow"
        },
        death = {
            canvas = Canvas.sky_particles,
            spawning = true,
            amount = {a=20, b=28},
            tick_speed = {a=0.1, b=0.11},
            spread = 360,
            speed = {a=20, b=101},
            rotation = {a=100, b=100},
            color = {r={a=0.99, b=1}, g={a=0.99, b=1}, b={a=0.99, b=1}, a={a=0.99, b=1}},
            width = {a=8, b=16},
            lifetime = {a=3, b=3.51},
            draw_mode = "circle"
        }
    })
    entity:give("hitbox", {
        center = Vector(-5, 4),
        radius = 3,
        layer = "player",
        on_entered = function(player, foe)
            if not player.health.invincible then
                if player.health.current > 0 then
                    player.health.current = player.health.current - 1
                    player.sprite.current_frame = player.sprite.current_frame + 1
                    player.sprite.blinking = true
                    player.health.invincible = true
                    foe.ai_controlled.has_item = true
                    AudioWorld:emit("playPlayerHitSound")
                    Timer.after(2, function()
                        player.health.invincible = false
                        player.sprite.blinking = false
                    end)
                else
                    if not player.dying then
                        player.dying = true
                        player.particles.emitters.death.ticks = 1
                        player.sprite.visible = false
                        player.active = false
                        AudioWorld:emit("playPlayerDeathSound")
                    end
                    Timer.after(2, function()
                        AudioWorld:emit("sysCleanUp")
                        Gamestate.switch(State.Death)
                    end)
                end
            end
        end
    })
end