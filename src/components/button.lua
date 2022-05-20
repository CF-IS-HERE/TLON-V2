return Concord.component("button", function(self, options)
    self.image_idle = options.image_idle
    self.image_hover = options.image_hover
    self.on_click = options.on_click or function() end
    self.on_mouse_enter = options.on_mouse_enter or function() end
    self.on_mouse_leave = options.on_mouse_leave or function() end
end)