local ParticleSystem = Concord.system({
    pool = {"particles", "position"}
})

local spawns = {
	point = function(x, y, data)
       return Vector(x, y)
    end,
	circle = function(x, y, data)
        local position = Vector(love.math.random(0, data), 0):rotated(love.math.random(0, 2 * math.pi))
        position.x = position.x + x
        position.y = position.y + y
        return position
    end,
	square = function(x, y, data)
        local position = Vector(love.math.random(-data[1], data[1]), love.math.random(-data[2], data[2]))
        position.x = position.x + x
        position.y = position.y + y
        return position
    end
}

local interpolations = {
    linear = function(x, current, start)
        return x * current / start
    end,
    sine = function(x, current, start)
        return x * math.sin(math.pi * current / start)
    end
}

function ParticleSystem:update(dt)
    for _, e in ipairs(self.pool) do
        for i, emitter in pairs(e.particles.emitters) do

            if not emitter.particles then -- init system
                emitter.particles = {}
                emitter.offset = emitter.offset or Vector(0, 0)
                emitter.spawning = emitter.spawning or false
                emitter.timer = emitter.timer or 0
                emitter.speed = emitter.speed or {a=0, b=0}
                emitter.spread = emitter.spread or 0
                emitter.ticks = emitter.ticks or 0
                emitter.tick_speed = emitter.tick_speed or {a=0.1, b=0.11}
                emitter.rotation = emitter.rotation or {a=0, b=0}
                emitter.amount = emitter.amount or {a=1, b=2}
                emitter.shape = emitter.shape or {mode = "point", data = nil}
                emitter.interpolation = emitter.interpolation or "linear"
                emitter.force = emitter.force or Vector(0, 0)
                emitter.color = emitter.color or {r={a=1,b=1}, g={a=1,b=1}, b={a=1,b=1}, a={a=1,b=1}}
            end

            emitter.timer = emitter.timer - dt

            -- emit particles as long as the timer hasn't run out
            if emitter.timer < 0 and emitter.ticks ~= 0 then
                emitter.ticks = emitter.ticks - 1
                emitter.timer = love.math.random(emitter.tick_speed.a * 100, emitter.tick_speed.b * 100) * 0.01
                for i=0,love.math.random(emitter.amount.a, emitter.amount.b) do
                    local position = spawns[emitter.shape.mode](e.position.x + emitter.offset.x, e.position.y + emitter.offset.y, emitter.shape.data)
                    local lifetime = love.math.random(emitter.lifetime.a * 100, emitter.lifetime.b * 100) / 100
                    local velocity = Vector(love.math.random(emitter.speed.a, emitter.speed.b), 0)
                    local rotation = love.math.random(emitter.rotation.a, emitter.rotation.b)
                    rotation = rotation + MathUtils.deg2rad(love.math.random(-emitter.spread, emitter.spread))
                    velocity = velocity:rotated(rotation)
                    local r = love.math.random(emitter.color.r.a * 100, emitter.color.r.b * 100) * 0.01
                    local g = love.math.random(emitter.color.g.a * 100, emitter.color.g.b * 100) * 0.01
                    local b = love.math.random(emitter.color.b.a * 100, emitter.color.b.b * 100) * 0.01
                    local a = love.math.random(emitter.color.a.a * 100, emitter.color.a.b * 100) * 0.01
                    table.insert(emitter.particles, {
                        x = position.x,
                        y = position.y,
                        velocity = velocity,
                        width = love.math.random(emitter.width.a, emitter.width.b),
                        lifetime = lifetime,
                        lifetime_start = lifetime,
                        color = {r=r, g=g, b=b, a=a},
                        rotation = rotation
                    })
                end
            end

            -- update particles, keep track of those that we need to remove
            for i, p in pairs(emitter.particles) do
                -- Add velocity to position
                p.x = p.x + p.velocity.x * dt
                p.y = p.y + p.velocity.y * dt

                -- Rotate vector by rotation and add force
                p.velocity = p.velocity + emitter.force * dt

                -- Decrease lifetime
                p.lifetime = p.lifetime - dt

                -- Kill if lifetime < 0
                if p.lifetime < 0 then emitter.particles[i] = nil end
            end
            ArrayUtils.compact(emitter.particles)
        end
    end
end

local draws = {
    circle = function(particle, width)
        love.graphics.setColor(particle.color.r, particle.color.g, particle.color.b, particle.color.a * particle.lifetime / particle.lifetime_start)
        love.graphics.circle("fill", particle.x, particle.y, width)
    end,
    circle_glow = function(particle, width)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.circle("fill", particle.x, particle.y, width)
        love.graphics.setColor(particle.color.r, particle.color.g, particle.color.b, particle.color.a * particle.lifetime / particle.lifetime_start)
        love.graphics.circle("fill", particle.x, particle.y, width * 1.4)
    end,
    square = function(particle, width)
        local offset = width * 0.5
        love.graphics.setColor(particle.color.r, particle.color.g, particle.color.b, particle.color.a * particle.lifetime / particle.lifetime_start)
        love.graphics.rectangle("fill", particle.x - offset, particle.y - offset, width, width)
    end
}

function ParticleSystem:draw()
    local r,g,b,a = love.graphics.getColor()
    for _, e in ipairs(self.pool) do
        for i, emitter in pairs(e.particles.emitters) do
            love.graphics.setCanvas(emitter.canvas)
            for _, p in pairs(emitter.particles) do
                if p.lifetime > 0 then
                    local width = interpolations[emitter.interpolation](p.width, p.lifetime, p.lifetime_start)
                    draws[emitter.draw_mode](p, width)
                end
            end
            love.graphics.setCanvas()
        end
	end
    love.graphics.setColor(r, g, b, a)
end

return ParticleSystem