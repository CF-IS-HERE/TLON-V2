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
    self.font = love.graphics.newFont("assets/fonts/nokia.ttf", 20)
    self.world = Concord.world()
    self.world:addSystems(Systems.SpriteSystem, Systems.UIButtonSystem, Systems.UILabelSystem)
    Concord.entity(self.world)
        :give("sprite", {
            image = love.graphics.newImage('assets/images/deathscreen/death_background.png')
        })
        :give("position")
        :give("layer", Canvas.ui)
        :give("scale")

    self.score_text = Concord.entity(self.world)
        :give("label", {
            font = self.font,
            color = {r=231/255, g=213/255, b=179/255, a=1},
            text = self.score_text,
            border = true
        })
        :give("layer", Canvas.ui_overlay)
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
        :give("layer", Canvas.ui)
        :give("position", 156, 97)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/deathscreen/giveup.png"),
            image_hover = love.graphics.newImage("assets/images/deathscreen/giveup_hover.png"),
            on_click = function()
                Gamestate.switch(State.MainMenu)
            end
        })
        :give("layer", Canvas.ui)
        :give("position", 135, 116)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/target.png")})
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -20)
        :give("layer", Canvas.ui_overlay)
end

function Score:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function Score:draw()
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

return Score