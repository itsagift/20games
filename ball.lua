local class = require 'utils/middleclass'
local Ball = class('Ball')

function Ball:initialize(x, y, size)
    self.x = x
    self.y = y
    self.size = size
    self.dx = 200
    self.dy = 200
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
    elseif self.x + self.size >= 800 then
        self.x = 800 - self.size 
        self.dx = -self.dx
    end
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

return Ball