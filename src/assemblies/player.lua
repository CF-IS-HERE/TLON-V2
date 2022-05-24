return function(entity, options)
    entity:give("sprite", {
        image = love.graphics.newImage('assets/images/player.png'),
        total_frames = 5,
        offset = Vector(5, 0)
    })
    entity:give("layer", options.canvas)
    entity:give("player_controlled")
    entity:give("position", love.graphics.getWidth() / 8, love.graphics.getHeight() / 8)
    entity:give("velocity")
    entity:give("speed", 2)
    entity:give("health", {max = 5})
    entity:give("weapon", {
        image = love.graphics.newImage("assets/images/shooter.png"),
        latency = 0.1,
        on_shoot = options.on_shoot,
        offset = Vector(2, -2),
        muzzle_offset = Vector(6, -2)
    })
    entity:give("hitbox", {
        center = Vector(-5, 4),
        radius = 3,
        layer = "player",
        on_entered = function(player, foe)
            if not player.health.invincible and player.health.current > 0 then
                player.health.current = player.health.current - 1
                player.sprite.current_frame = player.sprite.current_frame + 1
                player.health.invincible = true
                foe.ai_controlled.has_item = true
                AudioWorld:emit("playPlayerHitSound")
                Timer.after(2, function()
                    player.health.invincible = false
                end)
            end
        end
    })
end