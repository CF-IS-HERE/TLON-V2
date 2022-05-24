local AiSpawnSystem = Concord.system({})

math.randomseed(os.time())

function AiSpawnSystem:assembleEntity()

    

end




function AiSpawnSystem:generateID()
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


return AiSpawnSystem
