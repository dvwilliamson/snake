--[[
    2023
    Snake Remake

    snake-1
    "The Music Update"

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
local Class = require 'class' -- Will use in later updates

local GameState = require 'states'
local Sounds = require 'sounds'
local Fonts = require 'fonts'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

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

    gameState = GameState.START
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.draw()
    push:apply('start')
    love.graphics.clear(60 / 255, 70 / 255, 85 / 255, 255 / 255)
    drawTitle()
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
        'press enter to start..',
        0,
        VIRTUAL_HEIGHT / 4 + Fonts['large']['half_size'] + 10 - Fonts['small']['half_size'],
        VIRTUAL_WIDTH,
        'center'
    )
end
