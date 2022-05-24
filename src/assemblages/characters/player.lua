return function(entity, test)
require 'src/states/InGame'
require 'src/systems/GameAudioSystem'
print(test)
    entity:give("sprite", {
        image = love.graphics.newImage('assets/images/player.png'),
        total_frames = 5,
        offset = Vector(5, 0)
        })
    entity:give("layer", scaled_canvas)
    entity:give("player_controlled")
    entity:give("position", love.graphics.getWidth() / 8, love.graphics.getHeight() / 8)
    entity:give("velocity")
    entity:give("speed", 2)
    entity:give("health", {max = 5})
    entity:give("id", generateEntityID())
    entity:give("weapon", {
        image = love.graphics.newImage("assets/images/shooter.png"),
        latency = 0.2,
        on_shoot = function() print("shooting") end
        })
    entity:give("hitbox", {
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
                playPlayerHitSound()
                Timer.after(2, function()
                    player.health.invincible = false
                end)
            end
        end,
        rendered = show_hitbox
    })
end
