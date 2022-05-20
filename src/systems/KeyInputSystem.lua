local keyMap = require 'keymap'
local reverseKeyMap = {}
for action, mappedKey in ipairs(keyMap) do
  reverseKeyMap[mappedKey] = action
end

local KeyInputSystem = Concord.system({})

local function checkInput(keyMapDef)
  local key = keyMap[keyMapDef]
  if key == "mouse1" then
    return love.mouse.isDown(1)
  elseif key == "mouse2" then
    return love.mouse.isDown(2)
  else
    return love.keyboard.isDown(key)
  end
end

function KeyInputSystem:update(dt)
  if checkInput('moveDown') then
    self:getWorld():emit('moveDown')
    --Debug Print
    print("Down was Pressed!")
  end

  if checkInput('moveUp') then
    self:getWorld():emit('moveUp')
    --Debug Print
    print("Up was Pressed!")
  end

  if checkInput('moveRight') then
    self:getWorld():emit('moveRight')
    --Debug Print
    print("Right was Pressed!")
  end

  if checkInput('moveLeft') then
    self:getWorld():emit('moveLeft')
    --Debug Print
    print("Left was Pressed!")
  end

  if checkInput('shoot') then
    self:getWorld():emit('playerShoot')
  end
end

return KeyInputSystem