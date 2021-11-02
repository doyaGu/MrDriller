pass = {}

function pass:enter(previous, level)
  self.level = level
  self.background = Background()
end

function pass:update(dt)
end

function pass:draw()
  self.background:draw()

  love.graphics.setFont(gFonts['title'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('You Pass the level ' .. tostring(level) .. '!', 1, WINDOW_HEIGHT / 2 - 40 + 1, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('You Pass the level ' .. tostring(level) .. '!', 0, WINDOW_HEIGHT / 2 - 40, WINDOW_WIDTH, 'center')

  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('Next by pressed Enter', 1, WINDOW_HEIGHT / 2 + 17, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('Next by pressed Enter', 0, WINDOW_HEIGHT / 2 + 16, WINDOW_WIDTH, 'center')
end

function pass:keyreleased(key)
  if key == 'return' then
    return Gamestate.switch(game, self.level + 1)
  end
end
