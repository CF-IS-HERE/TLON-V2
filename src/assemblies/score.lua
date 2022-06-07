local font = love.graphics.newFont("assets/fonts/nokia.ttf", 10)

return function(entity, options)
    entity:give("layer", Canvas.sky_particles)
    entity:give("position", options.position.x, options.position.y)
    entity:give("label", {
        font = font,
        color = {r=207/255, g=87/255, b=60/255, a=1},
        text = options.text
    })
    entity:give("lifetime", options.lifetime or 1)
end