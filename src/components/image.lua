return Concord.component("image", function(self, img, is_visible)
    self.img = img
    self.visible = visible
    if self.visible == nil then
        self.visible = true
    end
end)