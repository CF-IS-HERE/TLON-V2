local Instructions = {}

function Instructions:enter(previous)
    self.current_page = 1
end


function Instructions:init()
    local background_img = love.graphics.newImage('assets/images/manual/manual_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.current_page = 1
    self.world = Concord.world()
    self.world:addSystems(Systems.StaticImageSystem, Systems.UIButtonSystem, Systems.UILabelSystem, Systems.UIKeyImageSystem)
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
            disabled = true,
            on_click = self.prevPage
        })
        :give("scale", 4)
        :give("position", 624, 500)
    self.right_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/right.png"),
            image_hover = love.graphics.newImage("assets/images/manual/right_hover.png"),
            image_disabled = love.graphics.newImage("assets/images/manual/right_disabled.png"),
            on_click = self.nextPage
        })
        :give("scale", 4)
        :give("position", 700, 500)
    Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_a.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_a_pressed.png"),
            key = "a"
        })
        :give("position", 132, 332)
        :give("scale", 4)
    Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_w.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_w_pressed.png"),
            key = "w"
        })
        :give("position", 224, 232)
        :give("scale", 4)
    Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_s.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_s_pressed.png"),
            key = "s"
        })
        :give("position", 224, 332)
        :give("scale", 4)
    Concord.entity(self.world)
        :give("image_key", {
            image_idle = love.graphics.newImage("assets/images/manual/key_d.png"),
            image_active = love.graphics.newImage("assets/images/manual/key_d_pressed.png"),
            key = "d"
        })
        :give("position", 296, 332)
        :give("scale", 4)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/manual/mouse.png"),
            image_active = love.graphics.newImage("assets/images/manual/mouse_active.png")
        })
        :give("scale", 4)
        :give("position", 480, 236)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.StaticImageSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("image", love.graphics.newImage("assets/images/mouse/pointer.png"))
        :give("scale", 3)
        :give("position")
        :give("follow_cursor")        
end

function Instructions:prevPage()
    print("prev page")
end

function Instructions:nextPage()
    print("next page")
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