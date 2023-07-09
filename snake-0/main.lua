--[[
    2023
    Snake Remake

    snake-0
    "The Day-0 Update"

    -- Main Program --

    Author: Dallas Williamson
    dallas.v.williamson@gmail.com

    Originally created by Gremlin Industries in 1976. In this
    single person varitant, the player controls the head of
    a snake. As the nope-rope consumes powerups, the tail of the
    snake grows. The goal of the game is to grow as long as
    possible without having the head touch the tail.
]]


push = require 'push'
GameState = require 'states'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- local gameState = GameState.START

--[[
    Runs on startup. Used to initialize the game.
]]
function love.load()
    love.window.setTitle('Snake')

    love.graphics.setDefaultFilter('nearest', 'nearest') -- Make the aliasing pixely

    largeFont = love.graphics.newFont('fonts/Press_Start_2P/font.ttf', 32)


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gameState = GameState.START
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.draw()
    push:apply('start')
    drawTitle()
    push:apply('end')
end

function drawTitle()
    love.graphics.setFont(largeFont)

    love.graphics.printf(
        'Snake',
        0,                       -- X: top left corner
        VIRTUAL_HEIGHT / 4 - 16, -- Y: Display 1/4 down the screen
        VIRTUAL_WIDTH,
        'center'
    )
end
