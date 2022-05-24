local GameAudioSystem = Concord.system({})

function GameAudioSystem:init()
    self.music = love.audio.newSource("assets/sounds/music/music.wav", "static")
    self.music:setVolume(0.1) -- set this back to 0.1 later
    self.music:setLooping(true)
    self.music:play()
    self.sound_enemy_hit = love.audio.newSource('assets/sounds/SFX/enemyHit.wav', "static")
    self.sound_enemy_die = love.audio.newSource('assets/sounds/SFX/enemyDie.wav', "static")
    self.sound_player_hit = love.audio.newSource('assets/sounds/SFX/playerStolen.wav', "static")
    self.sound_player_die = love.audio.newSource('assets/sounds/SFX/playerDie.wav', "static")
    self.sound_shoot = love.audio.newSource('assets/sounds/SFX/shoot.wav', "static")
    for _, sound in ipairs({self.sound_enemy_die, self.sound_enemy_hit, self.sound_player_hit, self.sound_player_die, self.sound_shoot}) do
        sound:setVolume(0.1)
    end
end

function GameAudioSystem:sysCleanUp()
    self.music:stop()
end

function GameAudioSystem:playEnemyHitSound()
    self.sound_enemy_hit:play()
end

function GameAudioSystem:playPlayerHitSound()
    self.sound_player_hit:play(love.math.random(80,120) * 0.01)
end

function GameAudioSystem:playEnemyDeathSound()
    self.sound_enemy_die:play()
end

function GameAudioSystem:playPlayerDeathSound()
    self.sound_player_die:play()
end

function GameAudioSystem:playShotSound()
    self.sound_shoot:play()
end

return GameAudioSystem