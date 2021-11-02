PlayerDrill = Class{__includes = Base}

function PlayerDrill:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['drill']
  self.currentAnimation = self.animation[self.player.direction]

  self.timer = Timer.new()
  self.timer:every(0.8, function() self.drilled = true end)
end

function PlayerDrill:enter()
  self.drilled = false
end

function PlayerDrill:exit()
  self.timer:clear()
end

function PlayerDrill:update(dt)
  self.timer:update(dt)
  self.currentAnimation = self.animation[self.player.direction]
  self.currentAnimation:update(dt)

  -- idle if we're not pressing anything at all
  if not love.keyboard.isDown('space') then
    self.player.direction = 'right'
    self.player:changeState('idle')
  else
    local world = self.player.world
    local blocks, len = world:queryPoint(self.player.x + self.player.width / 2, self.player.y + self.player.height + 1)
    -- check to see whether there are any blocks beneath us
    if len == 0 then
      self.player.direction = 'right'
      self.player.dy = 0
      self.player:changeState('falling')
    else
      -- process with blocks
      if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        for i = 1, len do
          if self.drilled then
            local block = blocks[i]
            block.isDrilled = true
            if block.id == BLOCK_ID.FLOOR then
              blocks, len = world:queryRect(0, block.y, MAP_WIDTH, block.height * 4)
              for i = 1, len do
                blocks[i].isDrilled = true
              end
            end
            self.drilled = false
          end
        end
        self.player.direction = 'down'
      elseif love.keyboard.isDown('left') then
        local nextX, nextY, cols, len = world:check(self.player, self.player.x - PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
        if len ~= 0 then
          for i = 1, len do
            if self.drilled then
              cols[i].other.isDrilled = true
              self.drilled = false
            end
          end
        end
        self.player.x, self.player.y = nextX, nextY
        self.player.direction = 'left'
      elseif love.keyboard.isDown('right') then
        local nextX, nextY, cols, len = world:check(self.player, self.player.x + PLAYER_WALK_SPEED * dt, self.player.y, self.player.filter)
        if len ~= 0 then
          for i = 1, len do
            if self.drilled then
              cols[i].other.isDrilled = true
              self.drilled = false
            end
          end
        end
        self.player.x, self.player.y = nextX, nextY
        self.player.direction = 'right'
      end
    end
  end
end

function PlayerDrill:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
