return Concord.component("sprite", function(self, options)
    self.image = options.image
    self.total_frames = options.total_frames or 1
    self.current_frame = options.current_frame or 1
    self.flipped = options.flipped or false
    self.rotation = options.rotation or 0
    self.offset = options.offset or Vector(0, 0)
    self.flash_intensity = options.flash_intensity or 0
    self.blinking = options.blinking or false
    self.visible = options.visible
    if self.visible == nil then
        self.visible = true
    end
end)