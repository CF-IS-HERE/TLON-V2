local GameAudioSystem = Concord.system({})

function GameAudioSystem:init()
    self.music = love.audio.newSource("assets/sounds/music/music.wav", "static")
    self.music:setVolume(0.1)
    self.music:setLooping(true)
    self.music:play()
end

function GameAudioSystem:sysCleanUp()
    self.music:stop()
end

function GameAudioSystem:takeDamage(target, damage)
    if target.type == "enemy" then
        local sound = love.audio.newSource('assets/sounds/SFX/enemyHit.wav', "static")
        sound:setVolume(0.1)
        sound:play()
    end
end

function GameAudioSystem:healthZero(target)
    if target.type == "enemy" then
        local sound = love.audio.newSource('assets/sounds/SFX/enemyDie.wav', "static")
        sound:setVolume(0.1)
        sound:play()
    end
    if target.type == "player" then
        local sound = love.audio.newSource('assets/sounds/SFX/playerDie.wav', "static")
        sound:setVolume(0.1)
        sound:play()
    end
end

function GameAudioSystem:shoot()
    local sound = love.audio.newSource('assets/sounds/SFX/shoot.wav', "static")
    sound:setVolume(0.1)
    sound:play()
end

return GameAudioSystem