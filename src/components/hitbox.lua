-- hitbox is an area that can receive damage when encountered by a hurtbox component
-- hitbox and hurtbox have to be on the same layer in order to interact with each other
return Concord.component("hitbox", function(self, options)
    self.center = options.center or Vector(0, 0)
    self.radius = options.radius or 1
    self.layer = options.layer or "world"
    self.on_entered = options.on_entered or function() end
    self.rendered = options.rendered or false -- for debug purposes
end)