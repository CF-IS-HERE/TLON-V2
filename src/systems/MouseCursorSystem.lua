local MouseCursorSystem = Concord.system({
    pool = {"follow_cursor"}
})

function MouseCursorSystem:update()
    for _, e in ipairs(self.pool) do
        e.position.x = love.mouse.getX() - 5
        e.position.y = love.mouse.getY() - 5
    end
end

return MouseCursorSystem