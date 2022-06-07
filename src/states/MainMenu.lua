local MainMenu = {}

function MainMenu:init()
    self.world = Concord.world()
    self.world:addSystems(Systems.AnimatedSpriteSystem, Systems.UIButtonSystem)

    -- animated main menu background
    self.background = Concord.entity(self.world)
        :give("animation", {
            total_frames = 4,
            speed = 0.2,
            playing = false
        })
        :give("sprite", {image = love.graphics.newImage('assets/images/main_menu/main_menu_en.png')})
        :give("position")
        :give("layer", Canvas.ui)

    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/play.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/play_hover.png"),
            on_click = function() Gamestate.switch(State.InGame) end,
            on_mouse_enter = function()
                self.background.anim:gotoFrame(1)
                self.background.animation.reversed = false
                self.background.animation.playing = true
            end,
            on_mouse_leave = function()
                self.background.anim_reverse:gotoFrame(1)
                self.background.animation.reversed = true
                self.background.animation.playing = true
            end
        })
        :give("layer", Canvas.ui)
        :give("position", 10, 125)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/manual.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/manual_hover.png"),
            on_click = function() Gamestate.push(State.Instructions) end
        })
        :give("layer", Canvas.ui)
        :give("position", 50, 125)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/twitter.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/twitter_hover.png"),
            on_click = function() print(love.system.openURL("https://twitter.com")) end
        })
        :give("layer", Canvas.ui)
        :give("position", 137, 125)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/home.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/home_hover.png"),
            on_click = function() print(love.system.openURL("https://itch.io")) end
        })
        :give("layer", Canvas.ui)
        :give("position", 156, 125)
    Concord.entity(self.world)
        :give("button", {
            image_idle = love.graphics.newImage("assets/images/main_menu/quit.png"),
            image_hover = love.graphics.newImage("assets/images/main_menu/quit_hover.png"),
            on_click = function() love.event.quit() end
        })
        :give("layer", Canvas.ui)
        :give("position", 175, 125)

    self.overlay = Concord.world()
    self.overlay:addSystems(Systems.SpriteSystem, Systems.MouseCursorSystem)
    Concord.entity(self.overlay)
        :give("sprite", {image = love.graphics.newImage("assets/images/mouse/pointer.png")})
        :give("layer", Canvas.ui_overlay)
        :give("scale", 3)
        :give("position")
        :give("follow_cursor", -5, -5)
end

function MainMenu:update(dt)
    self.world:emit("update", dt)
    self.overlay:emit("update", dt)
end

function MainMenu:draw()
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

return MainMenu