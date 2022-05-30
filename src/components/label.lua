return Concord.component("label", function(self, options)
    self.font = options.font
    self.color = options.color or {r=0, g=0, b=0, a=1}
    self.text = options.text or ""
    self.border = options.border
end)