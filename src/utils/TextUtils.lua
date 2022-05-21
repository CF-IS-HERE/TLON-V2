return {
    -- https://stackoverflow.com/questions/1426954/split-string-in-lua
    split = function(inputstr, sep)
        sep = sep or '%s'
        local t = {}
        for field, s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
            table.insert(t, field)
            if s == "" then return t end
        end
    end
}
