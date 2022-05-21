return Concord.component("image_key", function(self, options)
    self.image_idle = options.image_idle
    self.image_active = options.image_active or options.image_idle
    self.key = options.key or " "
end)