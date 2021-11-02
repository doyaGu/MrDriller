BlockFalling = Class{__includes = Base}

function BlockFalling:init(block, player, gravity)
  self.block = block
  self.player = player
  self.gravity = gravity

  self.texture = resources.images['block']
  self.animation = resources.animations['block'][self.block.id][1]
  self.currentAnimation = self.animation[1]
end

function BlockFalling:enter()
  resources.sounds.effect['fall']:play()
end

function BlockFalling:update(dt)
  self.currentAnimation:update(dt)

  self.block.dy = self.block.dy + self.gravity

  local world = self.block.world
  local nextX, nextY, cols, len = world:check(self.block, self.block.x, self.block.y + (self.block.dy * dt), self.block.filter)
  if len ~= 0 then
    self.block.dy = 0
    self.block:changeState('idle')
    if cols[1].other == self.player and self.player.alive then
      if self.block.id ~= BLOCK_ID.AIR then
        self.player:changeState('crush')
      elseif self.block.id == BLOCK_ID.AIR then
        self.block.durability = 0
      end
    end
  else
    self.block.x, self.block.y = nextX, nextY
  end

  local entities = self.block:getAdjacent()
  for i = 1, 4 do
    local entity = entities[i]
    if entity and not entity.id and self.block.id == BLOCK_ID.AIR then
        self.block.durability = 0
    end
  end

  if self.block.durability == 0 then
    self.block:changeState('disappear')
  end
end

function BlockFalling:draw()
  self.currentAnimation:draw(self.texture, self.block.x, self.block.y)
end
