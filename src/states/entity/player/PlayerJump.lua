PlayerJump = Class{__includes = Base}

function PlayerJump:init(player, gravity)
  self.player = player
  self.player.dy = PLAYER_JUMP_VELOCITY
  self.gravity = gravity

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['jump']
  self.currentAnimation = self.animation[self.player.direction]

end

function PlayerJump:update(dt)
  self.currentAnimation = self.animation[self.player.direction]
  self.currentAnimation:update(dt)

  self.player.dy = self.player.dy + self.gravity
    -- go into the falling state when y velocity is positive
  if self.player.dy >= 0 then
    self.player:changeState('falling')
  end

  local world = self.player.world
  local nextX, nextY, cols, len = world:check(self.player, self.player.x, self.player.y + (self.player.dy * dt), self.player.filter)
  self.player.x, self.player.y = nextX, nextY
  -- if it get a collision up top, go into the falling state immediately
  if len ~= 0 then
    self.player.dy = 0
    self.player:changeState('falling')
  elseif love.keyboard.isDown('left') then
    nextX, nextY, cols, len = world:check(self.player, self.player.x - PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
    self.player.x, self.player.y = nextX, nextY
    self.player.direction = 'left'
  elseif love.keyboard.isDown('right') then
    nextX, nextY, cols, len = world:check(self.player, self.player.x + PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
    self.player.x, self.player.y = nextX, nextY
    self.player.direction = 'right'
  end

end

function PlayerJump:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
