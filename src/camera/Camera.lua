local shake_timer = 0
local shake_strength = 0
local current_shake = Vector(0, 0)

return {
    shake = function(amount, time)
        shake_timer = time
        shake_strength = math.max(shake_strength, amount)
        Timer.after(time, Camera.stopShake)
    end,
    stopShake = function()
        -- we may have triggered another shake in the meantime
        -- the source of truth is the timer
        if shake_timer < 0.1 then
            shake_strength = 0
            shake_timer = 0
        end
    end,
    update = function(dt)
        shake_timer = shake_timer - dt
        if shake_timer > 0 then
            current_shake.x = love.math.random(-shake_strength, shake_strength)
            current_shake.y = love.math.random(-shake_strength, shake_strength)
        end
    end,
    getCurrentShake = function()
        return current_shake
    end
}