--[[
    2023
    Snake Remake

    -- Snake Class --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Represents a tail chunk of a snake. Once createed, it will have
    a time to live (in ticks). Once its time to live is up, it  will
    stop rendering.
]]

Tail = Class {}

function Tail:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function Tail:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
