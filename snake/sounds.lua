local sounds = {
    ['music'] = love.audio.newSource('sounds/music.wav', 'static')
}

love.graphics.setDefaultFilter('nearest', 'nearest') -- Make the aliasing pixely


return sounds
