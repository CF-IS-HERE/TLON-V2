-- hurtbox is an area that can deal damage when encountering a hitbox component
-- hitbox and hurtbox have to be on the same layer in order to interact with each other
return Concord.component("hurtbox", function(self, options)
    -- for 
    self.offset_x = options.offset_x or 0
    self.offset_y = options.offset_y or 0
    self.width = options.width or 1
    self.height = options.height or 1
    self.layer = options.layer or "world"
    self.on_enter = options.on_enter or function() end
    self.rendered = options.rendered or false -- for debug purposes
end)