local PlayerControlledSystem = Concord.system({ 
    pool = { 'playerControlled', 'directionIntent', 'lookAt' } 
})

function PlayerControlledSystem:init()
  self.shootDelay = 0.3
  self.shootCountdown = self.shootDelay
end

function PlayerControlledSystem:moveLeft()
  for _, entity in ipairs(self.pool) do
    entity.directionIntent.vec.x = -1
  end
end

function PlayerControlledSystem:moveRight()
  for _, entity in ipairs(self.pool) do
    entity.directionIntent.vec.x = 1
  end
end

function PlayerControlledSystem:moveUp()
  for _, entity in ipairs(self.pool) do
    entity.directionIntent.vec.y = -1
  end
end

function PlayerControlledSystem:moveDown()
  for _, entity in ipairs(self.pool) do
    entity.directionIntent.vec.y = 1
  end
end

function PlayerControlledSystem:update(dt)
  self.shootCountdown = self.shootCountdown - dt
end

function PlayerControlledSystem:playerLookAt(x, y)
  for _, entity in ipairs(self.pool) do
    entity.lookAt.x = x
    entity.lookAt.y = y
  end
end

function PlayerControlledSystem:playerShoot()
    if self.shootCountdown < 0 then
      self.shootCountdown = self.shootDelay
  
      for _, entity in ipairs(self.pool) do
        local lookX, lookY = entity.lookAt.x, entity.lookAt.y
        local direction = (Vector(lookX, lookY) - entity.position.vec).normalized
        self:getWorld():emit("shoot", entity, entity.position.vec, direction, "bullets.basicBullet", { "player" })
      end
    end
  end

  return PlayerControlledSystem