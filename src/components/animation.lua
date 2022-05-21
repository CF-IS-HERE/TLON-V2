return Concord.component("animation", function(self, options)
    self.total_frames = options.total_frames or 1
    self.speed = options.speed or 1
    self.looped = options.looped or false
    self.playing = options.playing
    if self.playing == nil then
        self.playing = true
    end
    self.reversed = options.reversed or false
end)