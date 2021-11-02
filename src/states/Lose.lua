lose = {}

function lose:enter()
  self.background = Background()
end

function lose:exit()
  gScores = {}
end

function lose:update(dt)
end

function lose:draw()
  self.background:draw()

  love.graphics.setFont(gFonts['title'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('You lose!', 1, WINDOW_HEIGHT / 2 - 40 + 1, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('You lose!', 0, WINDOW_HEIGHT / 2 - 40, WINDOW_WIDTH, 'center')

  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('Restart by pressed Enter', 1, WINDOW_HEIGHT / 2 + 17, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('Restart by pressed Enter', 0, WINDOW_HEIGHT / 2 + 16, WINDOW_WIDTH, 'center')

  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.printf('Show Scores by pressed Space', 1, WINDOW_HEIGHT / 2 + 57, WINDOW_WIDTH, 'center')
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf('Show Scores by pressed Space', 0, WINDOW_HEIGHT / 2 + 56, WINDOW_WIDTH, 'center')
end

function lose:keyreleased(key)
  if key == 'return' then
    return Gamestate.switch(game)
  elseif key == 'space' then
    return Gamestate.push(score)
  end
end
