return Concord.component("button", function(self, options)
    assert(options.image_idle)
    self.image_idle = options.image_idle
    self.image_hover = options.image_hover or options.image_idle
    self.image_disabled = options.image_disabled or options.image_idle
    self.image_active = options.image_active or options.image_idle
    self.disabled = options.disabled or false
    self.on_click = options.on_click or function() end
    self.on_mouse_enter = options.on_mouse_enter or function() end
    self.on_mouse_leave = options.on_mouse_leave or function() end
    self.visible = options.visible
    if self.visible == nil then
        self.visible = true
    end
end)