return {
    -- modified from https://gist.github.com/jasonbradley/4357406
    hex2rgb = function(hex)
        local h = hex:gsub("#","")
        return tonumber("0x"..h:sub(1,2)) / 255, tonumber("0x"..h:sub(3,4)) / 255, tonumber("0x"..h:sub(5,6)) / 255
    end
}
