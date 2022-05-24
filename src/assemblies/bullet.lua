local bullet_image = love.graphics.newImage("assets/images/playerBullet.png")

return function(entity, options)
    local player_center = Vector(options.player.position.x - 5, options.player.position.y + 9)
    local mouse_center = Vector(love.mouse.getX() + 14, love.mouse.getY() + 14)
    local muzzle_offset = options.player.weapon.muzzle_offset
    local muzzle_center = player_center + muzzle_offset
    local rnd_spread = love.math.random(-options.player.weapon.bullet_spread, options.player.weapon.bullet_spread)
    local angle = (mouse_center / 4 - muzzle_center):angleTo() + MathUtils.deg2rad(rnd_spread)
    local velocity = Vector(options.player.weapon.bullet_speed, 0):rotated(angle)    
    local r_muzzle = (muzzle_offset:clone() + Vector(0, 5)):rotated(angle)
    local position = player_center + muzzle_offset:rotated(angle)

    entity:give("sprite", {
        image = bullet_image,
        rotation = angle
    })
    entity:give("layer", options.canvas)
    entity:give("cruise_controlled")
    entity:give("out_of_screen_despawn")
    entity:give("position", position.x, position.y)
    entity:give("velocity", velocity.x, velocity.y)
    entity:give("hurtbox", {
        center = r_muzzle,
        radius = 4,
        layer = "enemy",
    })
end