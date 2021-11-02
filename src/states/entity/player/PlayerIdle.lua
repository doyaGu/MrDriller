PlayerIdle = Class{__includes = Base}

function PlayerIdle:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['idle']
  self.currentAnimation = self.animation
end

function PlayerIdle:update(dt)
  self.currentAnimation:update(dt)

  if self.player.stifle then
    self.player:changeState('stifle')
  end

  local world = self.player.world
  local nextX, nextY, cols, len = world:check(self.player, self.player.x, self.player.y + 1, self.player.filter)
  -- if we get a collision beneath us, go into either walking or idle
  if len == 0 then
    self.player.dy = 0
    self.player:changeState('falling')
  elseif love.keyboard.isDown('left') or love.keyboard.isDown('right') then
      self.player:changeState('walking')
  end

  if love.keyboard.isDown('space') then
    self.player.direction = 'down'
    self.player:changeState('drill')
  end
end

function PlayerIdle:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
