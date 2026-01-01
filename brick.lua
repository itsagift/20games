local class = require 'utils/middleclass'
local Brick = class('Brick')

function Brick:initialize(x, y, width, height, color)
  self.width = width
  self.height = height
  self.x = x
  self.y = y
  self.color = color
  self.visible = true
end

function Brick:draw()
  if self.visible then
    love.graphics.setColor(self.color[1], self.color[2], self.color[3])
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end

return Brick