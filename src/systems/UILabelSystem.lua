local UILabelSystem = Concord.system({
    pool = {"label", "position"}
})

function UILabelSystem:draw()
    for _, e in ipairs(self.pool) do
        -- store previous values so that we can re-set them after printing our label
        local _r,_g,_b,_a = love.graphics.getColor()
        local _f = love.graphics.getFont()
        local r,g,b = ColorUtils.hex2rgb(e.label.color)
        love.graphics.setColor(r, g, b, 1)
        love.graphics.setFont(e.label.font)
        if e.label.border then
            love.graphics.setLineWidth(4)
            -- love doesn't have a lot of tools to measure text, do a dirty approximation instead
            -- get the list of substrings (\n), find the longest one for the width and use the # of substrings for height
            local substrings = TextUtils.split(e.label.text, "\n")
            local max_chars = #substrings[1]
            for __, sub in ipairs(substrings) do
                if #sub > max_chars then max_chars = #sub end
            end
            local container_width = 20 + max_chars * 16
            local container_height = 32 + #substrings * 32
            love.graphics.rectangle("line", e.position.x - 20, e.position.y - 20, container_width, container_height)
        end
        love.graphics.print(e.label.text, e.position.x, e.position.y)
        love.graphics.setColor(_r,_g,_b,_a)
        love.graphics.setFont(_f)
    end
end

return UILabelSystem