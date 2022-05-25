return Concord.component("particle_emitter", function(self, options)
    self.offset = options.offset or Vector(0, 0)
    self.spawning = options.spawning or false
    self.amount = options.amount or {a=1, b=2}
    self.timer = options.timer or 0
    self.ticks = options.ticks or -1
    self.tick_speed = options.tick_speed or {a=0.1, b=0.11}
    self.rotation = options.rotation or 0
    self.spread = options.spread or 0
    self.interpolation = options.interpolation or "linear"
    self.force = options.force or Vector(0, 0)
    self.shape = options.shape or {mode = "point", data = nil}
    self.canvas = options.canvas
    self.particle_data = options.particle_data or {
        speed = {a=100, b=101},
        rotation = {a=0, b=1},
        color = {
            r = {a=0.99, b=1},
            g = {a=0.99, b=1},
            b = {a=0.99, b=1},
            a = {a=0.99, b=1},
        },
        width = {a=36, b=36.1},
        lifetime = {a=1, b=1.01},
        draw_mode = "circle_glow"
    }
end)