score = {}

function score:enter()
  self.background = Background()

  self.total = 0
  for k, s in pairs(gScores) do
    self.total = self.total + s
  end
  table.sort(gScores)
end

function score:update(dt)
end

function score:draw()
  self.background:draw()

  love.graphics.setFont(gFonts['large'])
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.print('Total Score: ' .. tostring(self.total), 20, 20)

  for k, s in pairs(gScores) do
    love.graphics.setFont(gFonts['medium'])
    love.graphics.print(tostring(k) .. 'st. Score: ' .. tostring(s), 20, 60 + 20 * k)
  end
end

function score:keyreleased(key)
  if key == 'space' then
    return Gamestate.pop() -- return to previous state
  end
end
