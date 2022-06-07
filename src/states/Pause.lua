local Pause = {}

function Pause:enter()
    if self.background.anim then
        -- pause animation needs to be reset in case we were paused previously
        self.background.anim:gotoFrame(1)
        self.background.animation.reversed = false
        self.background.animation.playing = true
    end
end

function Pause:init()
    local background_img = love.graphics.newImage('assets/images/pause_menu/pause_animation.png')
    local background_scale_x = love.graphics.getWidth() / background_img:getWidth()
    local background_scale_y = love.graphics.getHeight() / background_img:getHeight()

    self.world = Concord.world()
    self.world:addSystems(Systems.SpriteSystem, Systems.AnimatedSpriteSystem, Systems.UIButtonSystem)
    Concord.entity(self.world)
        :give("sprite", {image = love.graphics.newImage('assets/images/game_background.png')})
        :give("position")
        :give("layer", Canvas.ui)
        :give("scale")
    self.background = Concord.entity(self.world)
        :give("animation", {
            total_frames = 6,
            speed = 0.2,
            playing = true,
            on_complete = function()
                if self.background.animation.reversed then
                    Gamestate.pop()
                    if Gamestate.current() == State.InGame then
                        AudioWorld:emit("playMusic")
                    end
                else
                    self.setButtonState(self, true)
                end
            end
        })
        :give("layer", Canvas.ui)
        :give("sprite", {image = background_img})
        :give("position")
    self.continue_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/continue.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/continue_hover.png"),
            on_click = function()
                self.setButtonState(self, false)
                self.background.anim_reverse:gotoFrame(1)
                self.background.animation.reversed = true
                self.background.animation.playing = true
            end,
            visible = false
        })
        :give("layer", Canvas.ui)
        :give("position", 10, 32)
    self.manual_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/manual.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/manual_hover.png"),
            on_click = function() Gamestate.push(State.Instructions) end,
            visible = false
        })
        :give("layer", Canvas.ui)
        :give("scale")
        :give("position", 132, 32)
    self.retreat_btn = Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/pause_menu/retreat.png"),
            image_hover = love.graphics.newImage("assets/images/pause_menu/retreat_hover.png"),
            on_click = function() Gamestate.switch(State.MainMenu) end,
            visible = false
        })
        :give("layer", Canvas.ui)
        :give("position", 132, 86)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/target.png")})
        :give("scale", 3)
        :give("layer", Canvas.ui_overlay)
        :give("position")
        :give("follow_cursor", -20)
end

function Pause:setButtonState(enabled)
    self.continue_btn.button.visible = enabled
    self.manual_btn.button.visible = enabled
    self.retreat_btn.button.visible = enabled
end

function Pause:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function Pause:draw()
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
return Pause