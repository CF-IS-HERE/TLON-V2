local Instructions = {}

function Instructions:enter(previous)
    self.current_page = 1
    self.container.position.x = 0
    self.updateButtonStates(self)
end


function Instructions:init()
    local background_img = love.graphics.newImage('assets/images/manual/manual_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.current_page = 1
    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem, Systems.UIButtonSystem, Systems.UILabelSystem, Systems.UIKeyImageSystem, Systems.UIContainerSystem)
    self.background = Concord.entity(self.world)
        :give("image", background_img)
        :give("position")
        :give("scale", background_scale_x, background_scale_y)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/back.png"),
            image_hover = love.graphics.newImage("assets/images/manual/back_hover.png"),
            on_click = function() Gamestate.switch(State.MainMenu) end
        })
        :give("scale", 4)
        :give("position", 8, 55)
    Concord.entity(self.world)
        :give("label", {
            font = love.graphics.newFont("assets/fonts/nokia.ttf", 30),
            color = "#e7d5b3",
            text = "Instructions"
        })
        :give("position", 60, 54)
    self.left_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/left.png"),
            image_hover = love.graphics.newImage("assets/images/manual/left_hover.png"),
            image_disabled = love.graphics.newImage("assets/images/manual/left_disabled.png"),
            on_click = function() self.prevPage(self) end
        })
        :give("scale", 4)
        :give("position", 624, 500)
    self.right_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/right.png"),
            image_hover = love.graphics.newImage("assets/images/manual/right_hover.png"),
            image_disabled = love.graphics.newImage("assets/images/manual/right_disabled.png"),
            on_click = function() self.nextPage(self) end
        })
        :give("scale", 4)
        :give("position", 700, 500)
    self.key_a = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_a.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_a_pressed.png"),
            key = "a"
        })
        :give("position", 132, 332)
        :give("scale", 4)
    self.key_w = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_w.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_w_pressed.png"),
            key = "w"
        })
        :give("position", 224, 232)
        :give("scale", 4)
    self.key_s = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_s.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_s_pressed.png"),
            key = "s"
        })
        :give("position", 224, 332)
        :give("scale", 4)
    self.key_d = Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_d.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_d_pressed.png"),
            key = "d"
        })
        :give("position", 296, 332)
        :give("scale", 4)
    self.mouse = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/mouse.png"),
            image_active = love.graphics.newImage("assets/images/manual/mouse_active.png")
        })
        :give("scale", 4)
        :give("position", 480, 236)
    self.instructions = Concord.entity(self.world)
        :give("image", love.graphics.newImage("assets/images/manual/enemy_instructions.png"))
        :give("scale", 4)
        :give("position", love.graphics.getWidth() + 36, 132)
    self.special = Concord.entity(self.world)
        :give("image", love.graphics.newImage("assets/images/manual/special_instructions.png"))
        :give("scale", 4)
        :give("position", love.graphics.getWidth() * 2 + 140, 240)
    self.container = Concord.entity(self.world)
        :give("children", {self.key_a, self.key_w, self.key_s, self.key_d, self.mouse, self.instructions, self.special})
        :give("position")
    self.progress_bar = Concord.entity(self.world)
        :give("image", love.graphics.newImage("assets/images/manual/progress_bar.png"))
        :give("scale", 4)
        :give("position", 40, 556)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.StaticImageSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("image", love.graphics.newImage("assets/images/mouse/pointer.png"))
        :give("scale", 3)
        :give("position")
        :give("follow_cursor")
    
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
    Flux.to(self.progress_bar.position, 0.3, {x = 40 + (self.current_page - 1) * 143})
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
    self.world:emit("draw")
    self.overlay:emit("draw")
 
end

return Instructions