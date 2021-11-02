PlayerFalling = Class{__includes = Base}

function PlayerFalling:init(player, gravity)
  self.player = player
  self.gravity = gravity

  self.texture = resources.images['player']
  self.animation = {
    resources.animations['player']['idle'],
    resources.animations['player']['falling']
  }
  self.currentAnimation = self.animation[1]

  self.timer = Timer.new()
  self.timer:after(1, function() self.currentAnimation = self.animation[2] end)
end

function PlayerFalling:exit()
  self.timer:clear()
end

function PlayerFalling:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)

  self.player.dy = self.player.dy + self.gravity

  local world = self.player.world
  local nextX, nextY, cols, len = world:check(self.player, self.player.x, self.player.y + (self.player.dy * dt), self.player.filter)
  self.player.x, self.player.y = nextX, nextY
  -- if we get a collision beneath us, go into either walking or idle
  if len ~= 0 then
    self.player.dy = 0
    -- set the player to be walking or idle on landing depending on input
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
      self.player:changeState('walking')
    else
      self.player:changeState('idle')
    end
  -- check side collisions
  elseif love.keyboard.isDown('left') then
    local nextX, nextY, cols, len = world:check(self.player, self.player.x - PLAYER_WALK_SPEED * dt, self.player.y)
    self.player.x, self.player.y = nextX, nextY
    self.player.direction = 'left'
  elseif love.keyboard.isDown('right') then
    local nextX, nextY, cols, len = world:check(self.player, self.player.x + PLAYER_WALK_SPEED * dt, self.player.y)
    self.player.x, self.player.y = nextX, nextY
    self.player.direction = 'right'
  end
end

function PlayerFalling:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
