local Score = {}

function Score:enter()
    local feedbacks = {
        "Well I have to say this was a\npretty poor performance.",
        "I believe in you friend, stay strong.",
        "You have outdone yourself, thank you.",
        "What an amazing run, great job!"
    }
    
    -- todo: set this to the global entity's score component
    self.score = 4000

    if self.score_text.label then
        self.score_text.label.text = feedbacks[math.ceil(self.score / 10000)]
    end
    
end

function Score:init()
    local background_img = love.graphics.newImage('assets/images/deathscreen/death_background.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()
    
    self.font = love.graphics.newFont("assets/fonts/nokia.ttf", 20)
    self.world = Concord.world()
    self.world:addSystems(Systems.SpriteSystem, Systems.UIButtonSystem, Systems.UILabelSystem)
    Concord.entity(self.world)
        :give("sprite", {
            image = background_img
        })
        :give("position")
        :give("scale", background_scale_x, background_scale_y)

    self.score_text = Concord.entity(self.world)
        :give("label", {
            font = self.font,
            color = "#e7d5b3",
            text = self.score_text,
            border = true
        })
        :give("position", 60, 160)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/deathscreen/again.png"),
            image_hover = love.graphics.newImage("assets/images/deathscreen/again_hover.png"),
            on_click = function()
                -- todo: transition to game reset state instead
                Gamestate.switch(State.InGame)
            end
        })
        :give("scale", 4)
        :give("position", 624, 388)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/deathscreen/giveup.png"),
            image_hover = love.graphics.newImage("assets/images/deathscreen/giveup_hover.png"),
            on_click = function()
                Gamestate.switch(State.MainMenu)
            end
        })
        :give("scale", 4)
        :give("position", 540, 464)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/target.png")})
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -20)
end

function Score:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function Score:draw()
    self.world:emit("draw")
    self.overlay:emit("draw")
end

return Score