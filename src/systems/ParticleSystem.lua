local ParticleSystem = Concord.system({
    pool = {"particle_emitter", "position"}
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
        if not e.particle_emitter.particles then
            e.particle_emitter.particles = {}
        end
        e.particle_emitter.timer = e.particle_emitter.timer - dt
        
        -- emit particles as long as the timer hasn't run out
        if e.particle_emitter.timer < 0 and e.particle_emitter.ticks ~= 0 then
    		e.particle_emitter.ticks = e.particle_emitter.ticks - 1
	    	e.particle_emitter.timer = love.math.random(e.particle_emitter.tick_speed.a * 100, e.particle_emitter.tick_speed.b * 100) * 0.01
		    for i=0,love.math.random(e.particle_emitter.amount.a, e.particle_emitter.amount.b) do
			    local position = spawns[e.particle_emitter.shape.mode](e.position.x + e.particle_emitter.offset.x, e.position.y + e.particle_emitter.offset.y, e.particle_emitter.shape.data)
			    local lifetime = love.math.random(e.particle_emitter.particle_data.lifetime.a * 100, e.particle_emitter.particle_data.lifetime.b * 100) / 100
			    local velocity = Vector(love.math.random(e.particle_emitter.particle_data.speed.a, e.particle_emitter.particle_data.speed.b), 0)
                velocity = velocity:rotated(MathUtils.deg2rad(e.particle_emitter.rotation + love.math.random(-e.particle_emitter.spread, e.particle_emitter.spread)))
                local r = love.math.random(e.particle_emitter.particle_data.color.r.a*100, e.particle_emitter.particle_data.color.r.b * 100) * 0.01
                local g = love.math.random(e.particle_emitter.particle_data.color.g.a*100, e.particle_emitter.particle_data.color.g.b * 100) * 0.01
                local b = love.math.random(e.particle_emitter.particle_data.color.b.a*100, e.particle_emitter.particle_data.color.b.b * 100) * 0.01
                local a = love.math.random(e.particle_emitter.particle_data.color.a.a*100, e.particle_emitter.particle_data.color.a.b * 100) * 0.01

                table.insert(e.particle_emitter.particles, {
                    x = position.x,
                    y = position.y,
                    velocity = velocity,
                    width = love.math.random(e.particle_emitter.particle_data.width.a, e.particle_emitter.particle_data.width.b),
                    lifetime = lifetime,
                    lifetime_start = lifetime,
                    color = {r=r, g=g, b=b, a=a},
                    rotation = love.math.random(e.particle_emitter.particle_data.rotation.a, e.particle_emitter.particle_data.rotation.b)
                })
            end
		end
        
        -- update particles, keep track of those that we need to remove
        for i, p in pairs(e.particle_emitter.particles) do
            -- Set color to particles color
            love.graphics.setColor(p.color.r, p.color.g, p.color.b, p.color.a)
    
            -- Add velocity to position
            p.x = p.x + p.velocity.x * dt
            p.y = p.y + p.velocity.y * dt
    
            -- Rotate vector by rotation and add force
            p.velocity = p.velocity:rotated(p.rotation * dt)
            p.velocity.x = p.velocity.x + e.particle_emitter.force.x * dt
            p.velocity.y = p.velocity.y + e.particle_emitter.force.y * dt
    
            -- Decrease lifetime
            p.lifetime = p.lifetime - dt
    
            -- Kill if lifetime < 0
            if p.lifetime < 0 then e.particle_emitter.particles[i] = nil end
        end
        ArrayUtils.compact(e.particle_emitter.particles)
    end
end

local draws = {
    circle = function(particle, width)
        love.graphics.circle("fill", particle.x, particle.y, width)
    end,
    circle_glow = function(particle, width)
        love.graphics.circle("fill", particle.x, particle.y, width)
        local r,g,b,a = love.graphics.getColor()
        love.graphics.setColor(particle.color.r, particle.color.g, particle.color.b, particle.color.a * 0.4)
        love.graphics.circle("fill", particle.x, particle.y, width * 1.4)
        love.graphics.setColor(r, g, b, a)
    end,
    square = function(particle, width)
        local offset = width * 0.5
        love.graphics.rectangle("fill", particle.x - offset, particle.y - offset, width, width)
    end
}

function ParticleSystem:draw()
    for _, e in ipairs(self.pool) do
        love.graphics.setCanvas(e.particle_emitter.canvas)
        for _, p in pairs(e.particle_emitter.particles) do
            if p.lifetime > 0 then
                local width = interpolations[e.particle_emitter.interpolation](p.width, p.lifetime, p.lifetime_start)
                draws[e.particle_emitter.particle_data.draw_mode](p, width)
            end
        end
        love.graphics.setCanvas()
	end
end

return ParticleSystem