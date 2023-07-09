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

function Apple:collides(other)
    return not
        self.x + self.width < other.x or
        self.x > other.x + other.width or
        self.y + self.height < other.y or
        self.y > other.y + other.width
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
