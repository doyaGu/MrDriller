menu = {}

function menu:enter()
  self.background = Background()
end

function menu:update(dt)
end

function menu:draw()
  self.background:draw()

  love.graphics.setFont(gFonts['title'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('Mr Driller', 1, WINDOW_HEIGHT / 2 - 40 + 1, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('Mr Driller', 0, WINDOW_HEIGHT / 2 - 40, WINDOW_WIDTH, 'center')

  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('Press Enter', 1, WINDOW_HEIGHT / 2 + 17, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('Press Enter', 0, WINDOW_HEIGHT / 2 + 16, WINDOW_WIDTH, 'center')
end

function menu:keyreleased(key)
  if key == 'return' then
    return Gamestate.switch(game, 1)
  end
end
