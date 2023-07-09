local sounds = {
    ['music'] = love.audio.newSource('sounds/music.wav', 'static'),
    ['collect_item'] = love.audio.newSource('sounds/collect_item.wav', 'static'),
    ['countdown'] = love.audio.newSource('sounds/countdown.wav', 'static'),
    ['game_over'] = love.audio.newSource('sounds/game_over.wav', 'static')
}

return sounds
