local UIContainerSystem = Concord.system({
    pool = {"children", "position"}
})

function UIContainerSystem:update(dt)
    for _, e in ipairs(self.pool) do
        for i, child in ipairs(e.children.entities) do
            assert(child.position)
            -- persist initial position as absolute position
            if child.position and not child.abs_position then
                child.abs_position = {x=child.position.x, y=child.position.y}
            end
            child.position.x = e.position.x + child.abs_position.x
            child.position.y = e.position.y + child.abs_position.y
        end
    end
end

return UIContainerSystem