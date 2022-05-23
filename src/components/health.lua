return Concord.component("health", function(self, options)
    self.max = options.max or 1
    self.current = options.current or self.max
    self.invincible = options.invincible or false
end)