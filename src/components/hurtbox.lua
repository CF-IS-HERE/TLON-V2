-- hurtbox is an area that can deal damage when encountering a hitbox component
-- hitbox and hurtbox have to be on the same layer in order to interact with each other
return Concord.component("hurtbox", function(self, options)
    self.center = options.center or Vector(0, 0)
    self.radius = options.radius or 1
    self.layer = options.layer or "world"
    self.on_enter = options.on_enter or function() end
    self.rendered = options.rendered or false -- for debug purposes
end)