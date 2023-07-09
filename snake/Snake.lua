--[[
    2023
    Snake Remake

    -- Snake Class --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Represents a snake.
]]

Snake = Class {}

function Snake:init(x, y, width, height, dx, dy)
    self.x = x
    self.y = y
    self.dx = dx
    self.dy = dy
    self.width = width
    self.height = height
end

function Snake:update(dt)
    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
