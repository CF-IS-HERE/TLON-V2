return Concord.component("weapon", function(self, options)
    self.image = options.image
    self.on_shoot = options.on_shoot or function() end
    self.damage = options.damage or 1
    self.latency = options.latency or 1
    self.offset = options.offset or Vector(0, 0)
    self.bullet_spread = options.bullet_spread or 5
    self.bullet_speed = options.bullet_speed or 160
    self.muzzle_offset = options.muzzle_offset or Vector(0, 0)
    self.can_shoot = true
    self.shooting_angle = 0
end)