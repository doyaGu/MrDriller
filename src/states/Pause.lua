pause = {}

function pause:enter(from)
  self.from = from -- record previous state
  resources.sounds.effect['pause']:play()
end

function pause:draw()
  -- draw previous screen
  self.from:draw()
  -- overlay with pause message
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

  love.graphics.setColor(255, 255, 255)
  love.graphics.setFont(gFonts['large'])
  love.graphics.printf('PAUSE', 0, WINDOW_HEIGHT / 5 * 2, WINDOW_WIDTH, 'center')
  love.graphics.setFont(gFonts['medium'])
  love.graphics.printf('Restart by pressed R', 0, WINDOW_HEIGHT / 5 * 3, WINDOW_WIDTH, 'center')
end

function pause:keypressed(key)
  if key == 'escape' then
    return Gamestate.pop() -- return to previous state
  elseif key == 'r' then
    return Gamestate.switch(game, self.from.level)
  end
end
