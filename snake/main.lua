--[[
    2023
    Snake Remake

    snake-2
    "The Moving Snake Update"

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
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
TICK_SPEED = .2 -- Seconds

local apple
local player
local game_state
local tick_tracker

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

    Sounds.music:setLooping(true)
    Sounds.music:play()


    -- Initialize variables
    game_state = GameState.START
    tick_tracker = 0

    apple = Apple(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT * (3 / 4) - 2, 4, 4)
    player = Snake(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4, -4, 0)
end

function love.resize(w, h)
    push:resize(w, h)
end

function tick(dt)
    tick_tracker = tick_tracker + dt
    if tick_tracker > TICK_SPEED then
        tick_tracker = tick_tracker % TICK_SPEED
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
        end
    end
end

function love.draw()
    push:apply('start')
    love.graphics.clear(60 / 255, 70 / 255, 85 / 255, 255 / 255)
    if game_state == GameState.START then
        drawTitle()
    elseif game_state == GameState.PENDING_PLAY then
    end
    apple:render()
    player:render()
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
