return Concord.component("sprite", function(self, options)
    self.image = options.image
    self.layer = options.layer
    self.visible = options.visible
    self.total_frames = options.total_frames or 1
    self.current_frame = options.current_frame or 1
    if self.visible == nil then
        self.visible = true
    end
end)