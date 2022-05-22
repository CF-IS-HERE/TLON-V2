return {
    lerp = function(a, b, c)
        return a + (b - a) * c
    end,

    clamp = function(n, min, max)
        if n < min then n = min end
        if n > max then n = max end
        return n
    end,

    rad2deg = function(rad)
        return rad / 180 * 3.14
    end
}
