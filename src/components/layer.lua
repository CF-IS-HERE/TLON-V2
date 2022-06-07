return Concord.component("layer", function(self, canvas, color)
    self.canvas = canvas
    self.color = color or {r=1, g=1, b=1, a=1}
end)