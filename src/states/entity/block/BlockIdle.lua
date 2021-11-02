BlockIdle = Class{__includes = Base}

function BlockIdle:init(block, player)
  self.block = block
  self.player = player

  self.texture = resources.images['block']
  self.animation = resources.animations['block'][self.block.id][1]
  self.animationIndex = 1
  self.currentAnimation = self.animation[self.animationIndex]

  self.timer = Timer.new()
  if self.block.id == BLOCK_ID.CRYSTAL then
    self.timer:after(2, function() self.block:changeState('disappear') end)
  end
end

function BlockIdle:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)

  local world = self.block.world
  local nextX, nextY, cols, len = world:check(self.block, self.block.x, self.block.y + 1, self.block.filter)
  if len == 0 and self.block.id ~= BLOCK_ID.FLOOR then
    self.block:changeState('shake')
  end

  local entities = self.block:getAdjacent()
  for i = 1, 4 do
    local entity = entities[i]
    if entity and not entity.id and self.block.id == BLOCK_ID.AIR then
        self.block.durability = 0
    end
  end

  if self.block.isDrilled then
    self.block.durability = self.block.durability - 1
    self.animationIndex = self.animationIndex + 1
    self.currentAnimation = self.animation[self.animationIndex]
    self.block.isDrilled = false

    if self.block.id == BLOCK_ID.BROWN and self.block.durability == 0 then
      self.player.air = (self.player.air - 20 > 0) and self.player.air - 20 or 0
    elseif self.block.id == BLOCK_ID.FLOOR then
      local blocks, len = world:queryRect(0, self.block.y, MAP_WIDTH, self.block.height * 4)
      for i = 1, len do
        blocks[i].durability = 0
      end
    end
  end

  if self.block.durability == 0 then
    self.block:changeState('disappear')
  end
end

function BlockIdle:draw()
  self.currentAnimation:draw(self.texture, self.block.x, self.block.y)
end
