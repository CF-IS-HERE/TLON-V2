local AiSpawnSystem = Concord.system({})

math.randomseed(os.time())

function generateID()
    local result = {}
    local rand_num = {}
    local e_Name = "E-"

    for i=1, 500, 1 do
        table.insert(rand_num, i)
    end

    for i=1, 5, 1 do
        local r = math.random(1, #rand_num)
        table.insert(result, rand_num[r])
        table.remove(rand_num, r)
    end

    for i,v in pairs(result) do
        e_Name = e_Name .. v
        return e_Name
    end
end

function AiSpawnSystem:checkID()
    -- Something to compare ID of Dead Entity and remove from Table
end

function setPosition()
    local side = math.random(1, 4)
    local x , y = nil, nil
    if side == 1 then
        x = -15
        y = math.random(0, love.graphics.getHeight())
    elseif side == 2 then
        x = (love.graphics.getWidth() + 15)
        y = math.random(0, love.graphics.getHeight())
    elseif side == 3 then
        x = math.random(0, love.graphics.getWidth())
        y = -15
    elseif side == 4 then
        x = math.random(0, love.graphics.getWidth())
        y = (love.graphics.getHeight() + 15)
    end
   return x, y
end

function generateSprite()
    local spritenumber = math.random(1, 3)
    local sprite = nil
    if spritenumber == 1 then
        sprite = love.graphics.newImage('assets/images/lemon.png')
    elseif spritenumber == 2 then
        sprite = love.graphics.newImage('assets/images/lemon2.png')
    elseif spritenumber == 3 then
        sprite = love.graphics.newImage('assets/images/lemon3.png')
    end
    return sprite
end

return AiSpawnSystem
