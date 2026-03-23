local Player = require('player')
local Ball = require('ball')
local Header = require('header')
local Brick = require('brick')
local Menu = require('menu')
local print_table = require('print_table')

local player
local ball
local header
local score
local lives
local menu

local bricks = {}

local game_over
GameState = {
    
}

local palette = {
}
local rectangleColors = {}




local rectangleColors = {}



function love.load()
    love.window.setTitle("Breakout")
    love.window.setMode(800, 600)
    local width = 800
    local height = 600
    timer = 0

    game_over = false
    GameState = {
        menu = true,
        running = false,
        paused = false, 
        blinking = false,
        ended = false
    }

    palette = {
        {252, 3, 61},
        {69, 78, 158},
        {1, 142, 66},
        {255, 204, 51}
    }
    for i, v in ipairs(palette) do
    for j, w in ipairs(v) do
        palette[i][j] = palette[i][j] / 255
    end
    end
    
    math.randomseed(100)
    for i = 1, 60 do 
        rectangleColors[i] = palette[math.random(1, 4)]
    end
    local paddle_width = 100
    local paddle_height = 20
    local ball_size = 20

    score = 0
    lives = 5
    player = Player:new(width / 2, height - 25, paddle_width, paddle_height)
    ball = Ball:new((800 - ball_size) / 2, (600 - ball_size) / 2, ball_size)
    header = Header:new()
    menu = Menu:new()
    
    local index = 1
    for j = 0, 3 do
        for i = 0, 10 do
            brick = Brick:new((i * 80) + 5, (j * 40) + 50, 70, 30, rectangleColors[index])
            table.insert(bricks, brick)
            index = index + 1
        end
    end
end

local function checkCollision(ball, paddle)
    return ball.x <= paddle.x + paddle.width and 
    ball.x + ball.size >= paddle.x and 
    ball.y <= paddle.y + paddle.height and
    ball.y + ball.size >= paddle.y
end



local function resetBall()
    
    ball.x = (800 - ball.size) / 2
    ball.y = (600 - ball.size) / 2
    ball.dx = 200 * (math.random(2) == 1 and 1 or -1)
end

local function resetGame()
    timer = 0
    score = 0
    lives = 5
    resetBall()
    for i, brick in ipairs(bricks) do
        brick.visible = true
    end
    GameState = {
        menu = false,
        running = true,
        paused = false, 
        blinking = false,
        ended = false
    }
    ball.dx = 200
    ball.dy = 200
end

function love.keypressed(key)
  if (key=="space") then GameState.paused = not GameState.paused end
  if (key=="a") then 
    if GameState.ended then
        resetGame()
        GameState.menu = false
        GameState.running = true
    end
    if GameState.menu then
        GameState.menu = false
        GameState.running = true
    end
  end
end

function love.update(dt)
    local speed = 300
    timer = timer + dt
    if GameState.paused then return end
    if GameState.running then
        player:update(dt, "left", "right")
        ball:update(dt)

        if checkCollision(ball, player) then
            ball.y = ball.y - player.height
            ball.dy = -ball.dy * 1.05
        end

        if ball.y <= 0 + ball.size then
            ball.y = 0 + ball.size
            ball.dy = -ball.dy * 1.05
        end

        if ball.y >= 600 - ball.size then
            
            lives = lives - 1
            if lives <= 0 then
                GameState.running = false
                GameState.ended = true
            else
                GameState.blinking = true
                timer = 0
                resetBall()
            end
        end
        
    end
    if GameState.blinking then
        ball.blinking = true
        if timer > 0.1 then
            GameState.blinking = false
            ball.blinking = false
            timer = 0
        end
    end
    
    for i, brick in ipairs(bricks) do
        if checkCollision(ball, brick) and brick.visible then
            ball.y = ball.y + brick.height
            ball.dy = -ball.dy * 1.05
            -- ball.dx = -ball.dx * 1.05
            brick.visible = false
            score = score + 1
        end
    end
end

function love.draw()
    for i, brick in ipairs(bricks) do 
        brick:draw()
    end
    love.graphics.push()
    love.graphics.setColor(255, 255, 255)
    player:draw()
    love.graphics.pop()
    love.graphics.push()
    if GameState.blinking then
        love.graphics.setColor(200, 0, 0)
    else
        love.graphics.setColor(255, 255, 255)
    end
    ball:draw()
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255)
    header:draw(score, lives)
    menu:draw()
end