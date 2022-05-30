local cog_image = love.graphics.newImage("assets/images/cog.png")

return function(entity, options)
    entity:give("sprite", { image = cog_image })
    entity:give("layer", Canvas.game_entities)
    entity:give("active")
    entity:give("scale")
    entity:give("position", options.position.x, options.position.y)
    entity:give("hitbox", {
        center = Vector(4, 4),
        radius = 5,
        layer = "cog",
        rendered = true
    })
end