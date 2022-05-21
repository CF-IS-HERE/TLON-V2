local MouseCursorSystem = Concord.system({
    pool = {"follow_cursor"}
})

function MouseCursorSystem:update()
    for _, e in ipairs(self.pool) do
        e.position.x = love.mouse.getX() + e.follow_cursor.offset_x
        e.position.y = love.mouse.getY() + e.follow_cursor.offset_y
    end
end

return MouseCursorSystem