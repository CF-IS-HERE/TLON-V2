local SpriteSystem = Concord.system({
    pool = {"position", "scale", "image"}
})

function SpriteSystem:draw() 
    for _, e in ipairs(pool) do
        love.graphics.draw(e.image.img, e.position.x, e.position.y, nil, e.scale.x, e.scale.y)
    end
end