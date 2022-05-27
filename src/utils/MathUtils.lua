return {
    lerp = function(start, finish, percent)
        return start + (finish - start) * percent
    end,

    clamp = function(n, min, max)
        if n < min then n = min end
        if n > max then n = max end
        return n
    end,

    deg2rad = function(rad)
        return rad / 180 * math.pi
    end,

    round = function(x)
        return math.floor(x + 0.5)
    end
}
