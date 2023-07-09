--[[
    2023
    Snake Remake

    -- Snake Class --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Represents a snake.
]]

Snake = Class {}
require 'Tail'

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
    self.pendnig_grow = false

    self.tail_length = 0
    self.tail = {}
end

function Snake:update(dt)
    self.dx = self.pending_dx
    self.dy = self.pending_dy

    if self.pendnig_grow then
        self.tail_length = self.tail_length + 1
        table.insert(self.tail, 1, Tail(self.x, self.y, self.width, self.height))
        self.pendnig_grow = false
    else
        if self.tail_length > 0 then
            local temp = table.remove(self.tail)
            temp.x = self.x
            temp.y = self.y
            table.insert(self.tail, 1, temp)
        end
    end

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Snake:grow()
    self.pendnig_grow = true
end

function Snake:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    for i = 1, self.tail_length do
        self.tail[i]:render()
    end
end

function Snake:tailCollides()
    for i = 1, self.tail_length do
        if self.x == self.tail[i].x and self.y == self.tail[i].y then
            return true
        end
    end
    return false
end
