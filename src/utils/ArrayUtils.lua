return {
    -- removes all nil elements and compacts an array into shortest form
    -- warning: this mutates the array
    -- inspired by https://stackoverflow.com/questions/12394841/safely-remove-items-from-an-array-table-while-iterating
    compact = function(array)
        assert(array)
        local n = #array
        local j = 0
        for i = 1, n do
            if array[i] ~= nil then
                j = j + 1
                array[j] = array[i]
            end
        end
        for i = j + 1, n do
            array[i] = nil
        end 
    end
}