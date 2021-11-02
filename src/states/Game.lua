game = {}

function game:enter(previous, level)
  self.level = level

  self.background = Background({255, 255, 255, 255})
  self.gravity = GRAVITY

  self.world = bump.newWorld()

  self.player = Player{
    x = BLOCK_SIZE * 4,
    y = 0,
    width = CHARACTER_WIDTH,
    height = CHARACTER_HEIGHT,
    states = {
      ['idle'] = function() return PlayerIdle(self.player) end,
      ['walking'] = function() return PlayerWalking(self.player) end,
      ['drill'] = function() return PlayerDrill(self.player) end,
      ['climb'] = function() return PlayerClimb(self.player) end,
      ['falling'] = function() return PlayerFalling(self.player, self.gravity) end,
      ['crush'] = function() return PlayerCrush(self.player) end,
      ['stifle'] = function() return PlayerStifle(self.player) end,
      ['revive'] = function() return PlayerRevive(self.player) end
    },
    world = self.world
  }
  self.player:changeState('idle')

  self.camera = Camera(MAP_WIDTH / 2, self.player.y + self.player.height / 2)
  self.map = Map(MAP_WIDTH, MAP_HEIGHT, self.level, self.player, self.gravity, self.world, self.camera)

  resources.sounds.effect['play']:play()
end

function game:exit(dt)
  self.world = nil
  self.player = nil
  self.camera = nil
  self.map = nil
end

function game:update(dt)
  Timer.update(dt)

  self.player:update(dt)
  self.map:update(dt)

  if self.player.life <= 0 then
    table.insert(gScores, self.player.score)
    return Gamestate.switch(lose)
  elseif self.player.pass then
    table.insert(gScores, self.player.score)
    if self.level == 10 then
      return Gamestate.switch(win)
    else
      return Gamestate.switch(pass, self.level)
    end
  end

  self.camera:lookAt(MAP_WIDTH / 2, self.player.y + self.player.height / 2)
end

function game:draw()
  local player = self.player

  self.camera:attach()

  self.background:draw()
  player:draw()
  self.map:draw()

  self.camera:detach()

  self:drawDepth(player.y + player.height)
  self:drawScore(player.score)
  self:drawLife(player.life)
  self:drawAirSupply(player.air)
end

function game:drawDepth(depth)
  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print('Depth:', 10, 5)
  love.graphics.printf(tostring(math.floor(depth)) .. 'pt', 120, 5, 120, 'left')
  love.graphics.setColor(255, 255, 255, 255)
end

function game:drawLife(life)
  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print('Life:', love.graphics.getWidth() - 540, 5)
  love.graphics.printf(tostring(life), love.graphics.getWidth() - 460, 5, 120, 'left')
  love.graphics.setColor(255, 255, 255, 255)
end

function game:drawAirSupply(air)
  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print('Air:', love.graphics.getWidth() - 400, 5)
  love.graphics.printf(tostring(air) .. '%', love.graphics.getWidth() - 340, 5, 80, 'left')
  love.graphics.setColor(255, 255, 255, 255)
end

function game:drawScore(score)
  love.graphics.setFont(gFonts['medium'])
  love.graphics.setColor(0, 0, 0, 255)
  love.graphics.print('Score:', love.graphics.getWidth() - 240, 5)
  love.graphics.printf(tostring(score), love.graphics.getWidth() - 120, 5, 120, 'left')
  love.graphics.setColor(255, 255, 255, 255)
end

function game:keypressed(key)
  if key == 'escape' then
    return Gamestate.push(pause)
  end
end
