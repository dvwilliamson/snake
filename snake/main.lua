--[[
    2023
    Snake Remake

    snake-5
    "The Growth Update"

    -- Main Program --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Originally created by Gremlin Industries in 1976. In this
    single person varitant, the player controls the head of
    a snake. As the nope-rope consumes powerups, the tail of the
    snake grows. The goal of the game is to grow as long as
    possible without having the head touch the tail.
]]


local push = require 'push'
Class = require 'class'

local GameState = require 'states'
local Sounds = require 'sounds'
local Fonts = require 'fonts'

require 'Apple'
require 'Snake'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 180

local apple
local player
local game_state
local tick_tracker
local score
local tick_speed

--[[
    Runs on startup. Used to initialize the game.
]]
function love.load()
    love.window.setTitle('Snake')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest') -- Make the aliasing pixely

    -- Initialize variables
    reset()
end

function reset()
    game_state = GameState.START
    tick_tracker = 0
    score = 0
    tick_speed = 0.1

    apple = Apple(clip(VIRTUAL_WIDTH / 2 - 2, 4), clip(VIRTUAL_HEIGHT * (3 / 4) - 2, 4), 4, 4)
    player = Snake(clip(VIRTUAL_WIDTH / 2 - 2, 4), clip(VIRTUAL_HEIGHT / 2 - 2, 4), 4, 4, -4, 0)

    if not Sounds.music:isPlaying() then
        Sounds.music:setLooping(true)
        Sounds.music:play()
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function tick(dt)
    tick_tracker = tick_tracker + dt
    if tick_tracker > tick_speed then
        tick_tracker = tick_tracker % tick_speed
        return true
    end
    return false
end

function love.update(dt) -- Delta Time (Time passed since last update)
    if game_state == GameState.PENDING_PLAY then
        if not Sounds['countdown']:isPlaying() then
            game_state = GameState.PLAY
        end
    elseif game_state == GameState.PLAY then
        if tick(dt) then
            player:update(dt)
            if apple:collides(player) then
                Sounds['collect_item']:play()
                relocate_apple()
                tick_speed = tick_speed - 0.001
                score = score + 1
                player:grow()
            end

            if player:tailCollides() or
                player.x < 0 or
                player.y < 0 or
                player.x >= VIRTUAL_WIDTH or
                player.y >= VIRTUAL_HEIGHT
            then
                game_state = GameState.GAME_OVER
                Sounds['game_over']:play()
            end
        end
    end
end

function love.keypressed(key)
    if key == 'escape' then -- Exit the Game
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if game_state == GameState.START then
            Sounds.music:stop()
            game_state = GameState.PENDING_PLAY
            Sounds.countdown:play()
        elseif game_state == GameState.GAME_OVER and not Sounds['game_over']:isPlaying() then
            reset()
        end
    end

    if game_state == GameState.PLAY then
        if key == 'up' then
            if not (player.dy > 0) then -- Prevent going up from down
                player.pending_dx = 0
                player.pending_dy = -player.height
            end
        elseif key == 'down' then
            if not (player.dy < 0) then -- Prevent going down from up
                player.pending_dx = 0
                player.pending_dy = player.height
            end
        elseif key == 'left' then
            if not (player.dx > 0) then -- Prevent going left from right
                player.pending_dx = -player.width
                player.pending_dy = 0
            end
        elseif key == 'right' then
            if not (player.dx < 0) then -- Prevent going right from left
                player.pending_dx = player.width
                player.pending_dy = 0
            end
        end
    end
end

function love.draw()
    push:apply('start')
    love.graphics.clear(60 / 255, 70 / 255, 85 / 255, 255 / 255)
    if game_state == GameState.START then
        drawTitle()
        apple:render()
        player:render()
    elseif game_state == GameState.PENDING_PLAY then
        drawScore()
        apple:render()
        player:render()
    elseif game_state == GameState.PLAY then
        drawScore()
        apple:render()
        player:render()
    elseif game_state == GameState.GAME_OVER then
        drawGameOver()
    end
    push:apply('end')
end

function drawTitle()
    love.graphics.setFont(Fonts['large']['font'])
    love.graphics.printf(
        'Snake',
        0,                                                -- X: top left corner
        VIRTUAL_HEIGHT / 4 - Fonts['large']['half_size'], -- Y: Display 1/4 down the screen
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(Fonts['small']['font'])
    love.graphics.printf(
        'press enter to start...',
        0,
        VIRTUAL_HEIGHT / 4 + Fonts['large']['half_size'] + 10 - Fonts['small']['half_size'],
        VIRTUAL_WIDTH,
        'center'
    )
end

function drawGameOver()
    love.graphics.setFont(Fonts['large']['font'])
    love.graphics.printf(
        'Game Over',
        0,
        VIRTUAL_HEIGHT / 2 - Fonts['large']['size'] - 5,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(Fonts['small']['font'])
    love.graphics.printf(
        'Final Score:',
        0,
        VIRTUAL_HEIGHT / 2 + 5,
        VIRTUAL_WIDTH,
        'center'
    )

    love.graphics.setFont(Fonts['medium']['font'])
    love.graphics.printf(
        tostring(score),
        0,
        VIRTUAL_HEIGHT / 2 + 15 + Fonts['small']['size'],
        VIRTUAL_WIDTH,
        'center'
    )

    if not Sounds['game_over']:isPlaying() then
        love.graphics.setFont(Fonts['small']['font'])
        love.graphics.printf(
            'Press enter to Continue...',
            0,
            VIRTUAL_HEIGHT - 10 - Fonts['small']['half_size'],
            VIRTUAL_WIDTH,
            'right'
        )
    end
end

function drawScore()
    love.graphics.setFont(Fonts['small']['font'])
    love.graphics.printf(
        tostring(score),
        10,
        10,
        VIRTUAL_WIDTH - 10,
        'left'
    )
end

--[[
    To make the game more grid-like, this function corrects the pos
    parameter to the nearest grid position based on the provided value
]]
function clip(pos, value)
    local result = pos - (pos % value)
    if pos % value > 2 then
        result = result + value
    end
    return result
end

function relocate_apple()
    local new_x = clip(math.random(0, VIRTUAL_WIDTH - apple.width), apple.width)
    local new_y = clip(math.random(0, VIRTUAL_HEIGHT - apple.height), apple.height)
    apple.x = new_x
    apple.y = new_y
end
