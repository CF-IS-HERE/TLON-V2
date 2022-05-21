return Concord.component("label", function(self, options)
    self.font = options.font
    self.color = options.color or "#FFFFFF"
    self.text = options.text or ""
    self.border = options.border
end)