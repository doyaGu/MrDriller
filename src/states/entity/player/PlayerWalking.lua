PlayerWalking = Class{__includes = Base}

function PlayerWalking:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['walking']
  self.currentAnimation = self.animation[self.player.direction]
end

function PlayerWalking:update(dt)
  self.currentAnimation = self.animation[self.player.direction]
  self.currentAnimation:update(dt)

  -- idle if we're not pressing anything at all
  if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
    self.player:changeState('idle')
  else
    local world = self.player.world
    local nextX, nextY, cols, len = world:check(self.player, self.player.x, self.player.y + 1, self.player.filter)
    -- check to see whether there are any blocks beneath us
    if len == 0 then
      self.player.dy = 0
      self.player:changeState('falling')
    else
      local originX = self.player.x
      if love.keyboard.isDown('left') then
        nextX, nextY, cols, len = world:check(self.player, self.player.x - PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
        self.player.x, self.player.y = nextX, nextY
        self.player.direction = 'left'

        if self.player.x == originX then
          local block, len = world:queryRect(self.player.x - self.player.width, self.player.y - self.player.height, self.player.width, 1)
          if len == 0 then
            self.player:changeState('climb')
          end
        end
      elseif love.keyboard.isDown('right') then
        nextX, nextY, cols, len = world:check(self.player, self.player.x + PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
        self.player.x, self.player.y = nextX, nextY
        self.player.direction = 'right'

        if self.player.x == originX then
          local block, len = world:queryRect(self.player.x + self.player.width, self.player.y - self.player.height, self.player.width, 1)
          if len == 0 then
            self.player:changeState('climb')
          end
        end
      end
    end
    if love.keyboard.isDown('space') then
      self.player:changeState('drill')
    end

  end
end

function PlayerWalking:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
