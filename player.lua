local class = require 'middleclass'
local Player = class('Player')

function Player:initialize(x, y, width, height)
  self.width = width
  self.height = height
  self.x = x
  self.y = y
  self.score = 0
end

function Player:update(dt, key1, key2)
    local speed = 300
    if love.keyboard.isDown(key1) then
        self.x = self.x - speed * dt
    elseif love.keyboard.isDown(key2) then
        self.x = self.x + speed * dt
    end
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player