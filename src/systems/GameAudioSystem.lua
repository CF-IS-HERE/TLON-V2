local AudioSys = Concord.system({})

function AudioSys:init()
    self.music = love.audio.newSource('assests/sounds/music/music.wav')
    self.music:setVolume(0.1)
    self.music:setLooping(true)
    self.music:play()
end

function AudioSys:sysCleanUp()
    self.music:stop()
end

function AudioSys:takeDamage(target, damage)
    if target.type == "enemy" then
        local sound = love.audio.newSource('assests/sounds/SFX/enemyHit.wav')
        sound:setVolume(0.1)
        sound:play()
    end
end

function AudioSys:healthZero(target)
    if target.type == "enemy" then
        local sound = love.sound.newSource('assests/sounds/SFX/enemyDie.wav')
        sound:setVolume(0.1)
        sound:play()
    end
    if target.type == "player" then
        local sound = love.audio.newSource('assests/sounds/SFX/playerDie.wav')
        sound:setVolume(0.1)
        sound:play()
    end
end

function AudioSys:shoot()
    local sound = love.audio.newSource('assests/sounds/SFX/shoot.wav')
    sound:setVolume(0.1)
    sound:play()
end

return AudioSys