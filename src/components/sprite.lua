return Concord.component("sprite", function(self, options)
    self.image = options.image
    self.total_frames = options.total_frames or 1
    self.current_frame = options.current_frame or 1
    self.flipped = options.flipped or false
    self.visible = options.visible
    self.rotation = options.rotation
    self.offset = options.offset or Vector(0, 0)
    if self.visible == nil then
        self.visible = true
    end
end)