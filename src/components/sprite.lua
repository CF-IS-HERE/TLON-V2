return Concord.component("sprite", function(self, options)
    self.image = options.image
    self.layer = options.layer
    self.visible = options.visible
    if self.visible == nil then
        self.visible = true
    end
end)