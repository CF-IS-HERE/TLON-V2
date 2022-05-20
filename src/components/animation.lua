return Concord.component("animation", function(self, options)
    self.total_frames = options.total_frames or 1
    self.speed = options.speed or 1
    self.is_loop = options.is_loop or false
    self.is_playing = options.is_playing
    if self.is_playing == nil then
        self.is_playing = true
    end
    self.is_reverse = options.is_reverse or false
end)