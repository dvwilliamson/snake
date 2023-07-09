--[[
    2023
    Snake Remake

    -- Apple Class --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Represents an apple which will change position once consumed by
    the snake. Consuming an apple results in scoring a point for the
    player.
]]

Apple = Class {}

function Apple:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

--[[
    Since we are gridded, we just have to check if the x and y are the same
]]
function Apple:collides(other)
    return self.x == other.x and self.y == other.y
end

function Apple:render()
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle(
        'fill',
        self.x,
        self.y,
        self.width,
        self.height
    )
    love.graphics.setColor(255, 255, 255)
end
