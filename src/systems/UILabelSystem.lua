local UILabelSystem = Concord.system({
    pool = {"label", "position"}
})

function UILabelSystem:draw()
    for _, e in ipairs(self.pool) do
        -- store previous values so that we can re-set them after printing our label
        local _r,_g,_b,_a = love.graphics.getColor()
        local _f = love.graphics.getFont()
        local hex = e.label.color:gsub("#","")
        local r = tonumber("0x"..hex:sub(1,2)) / 255
        local g = tonumber("0x"..hex:sub(3,4)) / 255
        local b = tonumber("0x"..hex:sub(5,6)) / 255
        love.graphics.setColor(r, g, b, 1)
        love.graphics.setFont(e.label.font)
        love.graphics.print(e.label.text, e.position.x, e.position.y)
        love.graphics.setColor(_r,_g,_b,_a)
        love.graphics.setFont(_f)
    end
end

return UILabelSystem