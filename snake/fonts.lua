local fonts = {}

love.graphics.setDefaultFilter('nearest', 'nearest') -- Make the aliasing pixely

fonts.small = {
    ['size'] = 8,
    ['half_size'] = 4,
    ['font'] = love.graphics.newFont('fonts/Press_Start_2P/font.ttf', 8)
}

fonts.medium = {
    ['size'] = 16,
    ['half_size'] = 8,
    ['font'] = love.graphics.newFont('fonts/Press_Start_2P/font.ttf', 16)
}

fonts.large = {
    ['size'] = 32,
    ['half_size'] = 16,
    ['font'] = love.graphics.newFont('fonts/Press_Start_2P/font.ttf', 32)
}

return fonts
