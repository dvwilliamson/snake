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

    -- We need to store the previous direction between ticks so
    -- that you can quickly change up to left to down within the
    -- same tick.
    self.pending_dx = dx
    self.pending_dy = dy
end

function Snake:update(dt)
    self.dx = self.pending_dx
    self.dy = self.pending_dy

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
