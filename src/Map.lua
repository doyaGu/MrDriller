Map = Class{}

local sortByID = function(a,b)
  return (a.id and b.id) and a.id < b.id or false
end

function Map:init(width, height, level, player, gravity, world, camera)
  self.width = width
  self.height = height
  self.depth = 0

  self.level = level
  self.player = player
  self.gravity = gravity
  self.world = world
  self.camera = camera

  self:reset()
end

function Map:reset()
  self.entities = {}
  self.total = 0
  self.groups = {}

  -- walls
  -- Entity{
  --   x = 0,
  --   y = 0,
  --   width = 1,
  --   height = self.height,
  --   world = self.world
  -- }
  -- Entity{
  --   x = self.width - 1,
  --   y = 0,
  --   width = 1,
  --   height = self.height,
  --   world = self.world
  -- }

  local width, height = self.width / BLOCK_SIZE, self.height / BLOCK_SIZE

  -- groups of blocks
  for i = 0, width - 1 do
    for j = 3, height - 5 do
      -- declaring in advance so we can pass it into state machine
      local block
      block = Block{
        x = i * BLOCK_SIZE,
        y = j * BLOCK_SIZE,
        width = BLOCK_SIZE,
        height = BLOCK_SIZE,
        states = {
          ['idle'] = function() return BlockIdle(block, self.player) end,
          ['shake'] = function() return BlockShake(block) end,
          ['falling'] = function() return BlockFalling(block, self.player, self.gravity) end,
          ['disappear'] = function() return BlockDisappear(block, self.player) end
        },
        world = self.world,
        id = self:randomBlockID()
      }
      block:changeState('idle')
    end
  end

  -- floor
  for i = 0, width - 1 do
    for j = height - 4, height - 1 do
      -- declaring in advance so we can pass it into state machine
      local block
      block = Block{
        x = i * BLOCK_SIZE,
        y = j * BLOCK_SIZE,
        width = BLOCK_SIZE,
        height = BLOCK_SIZE,
        states = {
          ['idle'] = function() return BlockIdle(block, self.player) end,
          ['disappear'] = function() return BlockDisappear(block, self.player) end
        },
        world = self.world,
        id = BLOCK_ID.FLOOR
      }
      block:changeState('idle')
    end
  end
end

function Map:update(dt)
  local x, y = self.camera:worldCoords(0, 0)
  self.entities, self.total = self.world:queryRect(x, 0, WINDOW_WIDTH, y + WINDOW_HEIGHT)
  table.sort(self.entities, sortByID)

  for i = 1, self.total do
    self.entities[i]:update(dt)
  end
end

function Map:draw()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('line', 0, 0, self.width, self.height)
  love.graphics.setColor(255, 255, 255, 255)

  for i = 1, self.total do
    self.entities[i]:draw()
  end
end

function Map:randomBlockID()
  local n = math.random(1, 100)
  local hard = 10 - self.level
  if 1 < n and n < 5 * hard then
    return math.random(5, 7)
  elseif 5 * hard < n and n < 95 then
    return math.random(1, 4)
  else
    return BLOCK_ID.AIR
  end
end

function Map:countItems()
  return self.world:countItems()
end
