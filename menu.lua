local class = require 'utils/middleclass'
local Menu = class('Menu')

function Menu:initialize()
    self.width = 700
    self.height = 500
    self.x = 50
    self.y = 50
end

function Menu:update()
    
end

function Menu:draw()
    love.graphics.setColor(0.1, 0.5, 0.4)
    if GameState.menu then
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        local scoreFont = love.graphics.newFont("PressStart2P.ttf", 32)
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Breakout", 275, 275)
        local capFont = love.graphics.newFont("PressStart2P.ttf", 16)
        love.graphics.setFont(capFont)
        love.graphics.print("Press <<A>> to start", 240, 350)
    end
    if GameState.ended then
        love.graphics.rectangle("fill", 250, 250, self.width / 2, self.height / 2)
        local scoreFont = love.graphics.newFont("PressStart2P.ttf", 32)
        love.graphics.setFont(scoreFont)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Game Over", 275, 275)
    end

end

return Menu