local class = require 'utils/middleclass'
local Header = class('Header')

function Header:initialize()
    self.width = 800
    self.height = 50
end

function Header:draw(score, lives)
    if GameState.running then
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, self.width, self.height)
        local scoreFont = love.graphics.newFont("PressStart2P.ttf", 32)
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(score, 10, 10)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(lives, 750, 10)
        love.graphics.rectangle("fill", 0, self.height - 5, self.width, 5)
    end
end

return Header