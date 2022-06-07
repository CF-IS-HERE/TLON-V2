return Concord.component("rotation", function(self, options)
    self.speed = options.speed or 1
    self.rotating = options.rotating or false
    self.ticks = options.ticks or 0
end)