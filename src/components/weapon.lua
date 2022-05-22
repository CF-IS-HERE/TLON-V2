return Concord.component("weapon", function(self, options)
    self.image = options.image
    self.on_shoot = options.on_shoot or function() end
    self.damage = options.damage or 1
    self.latency = options.latency or 1
    self.can_shoot = true
end)