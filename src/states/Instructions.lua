local Instructions = {}

function Instructions:enter(previous)
    self.current_page = 1
    self.container.position.x = 0
    self.updateButtonStates(self)
end

function Instructions:init()
    self.current_page = 1
    self.world = Concord.world()
    self.world:addSystems(Systems.SpriteSystem, Systems.UIButtonSystem, Systems.UILabelSystem, Systems.UIKeyImageSystem, Systems.UIContainerSystem)

    Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage('assets/images/manual/manual_background.png')})
        :give("position")
        :give("scale")
        :give("layer", Canvas.ui)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/back.png"),
            image_hover = love.graphics.newImage("assets/images/manual/back_hover.png"),
            on_click = function() Gamestate.pop(Gamestate.Pause) end
        })
        :give("layer", Canvas.ui)
        :give("position", 2, 14)
    Concord.entity(self.world)
        :give("label", {
            font = love.graphics.newFont("assets/fonts/nokia.ttf", 30),
            color = "#e7d5b3",
            text = "Instructions"
        })
        :give("layer", Canvas.ui_overlay)
        :give("position", 60, 54)
    self.left_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/left.png"),
            image_hover = love.graphics.newImage("assets/images/manual/left_hover.png"),
            image_disabled = love.graphics.newImage("assets/images/manual/left_disabled.png"),
            on_click = function() self.prevPage(self) end
        })
        :give("layer", Canvas.ui)
        :give("position", 156, 125)
    self.right_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/right.png"),
            image_hover = love.graphics.newImage("assets/images/manual/right_hover.png"),
            image_disabled = love.graphics.newImage("assets/images/manual/right_disabled.png"),
            on_click = function() self.nextPage(self) end
        })
        :give("layer", Canvas.ui)
        :give("position", 175, 125)
    self.key_a = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_a.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_a_pressed.png"),
            key = "a"
        })
        :give("scale")
        :give("position", 33, 83)
        :give("layer", Canvas.ui)
    self.key_w = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_w.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_w_pressed.png"),
            key = "w"
        })
        :give("scale")
        :give("position", 56, 58)
        :give("layer", Canvas.ui)
    self.key_s = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_s.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_s_pressed.png"),
            key = "s"
        })
        :give("scale")
        :give("position", 56, 83)
        :give("layer", Canvas.ui)
    self.key_d = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_d.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_d_pressed.png"),
            key = "d"
        })
        :give("scale")
        :give("position", 74, 83)
        :give("layer", Canvas.ui)
    self.mouse = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/mouse.png"),
            image_active = love.graphics.newImage("assets/images/manual/mouse_active.png")
        })
        :give("layer", Canvas.ui)
        :give("position", 120, 59)
    self.instructions = Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage("assets/images/manual/enemy_instructions.png")})
        :give("scale")
        :give("layer", Canvas.ui)
        :give("position", love.graphics.getWidth() + 9, 33)
    self.special = Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage("assets/images/manual/special_instructions.png")})
        :give("scale")
        :give("layer", Canvas.ui)
        :give("position", love.graphics.getWidth() * 2 + 35, 60)
    self.container = Concord.entity(self.world)
        :give("children", {self.key_a, self.key_w, self.key_s, self.key_d, self.mouse, self.instructions, self.special})
        :give("position")
    self.progress_bar = Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage("assets/images/manual/progress_bar.png")})
        :give("layer", Canvas.ui)
        :give("position", 10, 139)
        :give("scale")

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/pointer.png")})
        :give("layer", Canvas.ui_overlay)
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -5, -5)

    self.updateButtonStates(self)
end

function Instructions:prevPage()
    if self.current_page > 1 then
        self.current_page = self.current_page - 1
        self.scrollToPage(self)
    end
    self.updateButtonStates(self)
end

function Instructions:nextPage()
    if self.current_page < 4 then
        self.current_page = self.current_page + 1
        self.scrollToPage(self)
    end
    self.updateButtonStates(self)
end

function Instructions:scrollToPage()
    Flux.to(self.container.position, 0.3, {x = -love.graphics.getWidth() * (self.current_page - 1)})
    Flux.to(self.progress_bar.position, 0.3, {x = 10 + (self.current_page - 1) * 36})
end

function Instructions:updateButtonStates()
    self.left_btn.button.disabled = false
    self.right_btn.button.disabled = false
    if self.current_page == 1 then
        self.left_btn.button.disabled = true
    elseif self.current_page == 4 then
        self.right_btn.button.disabled = true
    end
    for _, k in ipairs({self.key_a, self.key_w, self.key_d, self.key_s}) do
        k.image_key.silent = self.current_page > 1
    end
end

function Instructions:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function Instructions:draw()
    -- clear canvases used on every call
    for _, c in ipairs({Canvas.ui_overlay, Canvas.ui}) do
        love.graphics.setCanvas(c)
        love.graphics.clear() -- clear all canvases to transparent before each draw call
    end

    self.world:emit("draw")
    self.overlay:emit("draw")

    love.graphics.setCanvas()

    love.graphics.draw(Canvas.ui, ViewPort.left, ViewPort.top, 0, DisplayScale * PixelRatio, DisplayScale * PixelRatio)
    love.graphics.draw(Canvas.ui_overlay, ViewPort.left , ViewPort.top, 0, DisplayScale, DisplayScale)
end

return Instructions