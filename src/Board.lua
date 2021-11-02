Board = Class{}

function Board:init(width, height)
  self.width = width
  self.height = height
  self.blocks = {}

  for y = 1, self.height do
    local row = {}
    for x = 1, self.width do
      row[x] = false
    end
    table.insert(self.blocks,  row)
  end
end

function Board:deleteBlock(block)
  assert(block)
  self.blocks[math.floor(block.y / BLOCK_SIZE) + 1][math.floor(block.x / BLOCK_SIZE) + 1] = false
  return true
end

function Board:pointToBlock(x, y)
  if x < 0 or x > self.width * BLOCK_SIZE or y < 0 or y > self.height * BLOCK_SIZE then
    return nil
  end

  return self.blocks[math.floor(y / BLOCK_SIZE) + 1][math.floor(x / BLOCK_SIZE) + 1]
end

function Board:blockToPoint(block)
  assert(block)
  return block.x, block.y
end

function Board:update(dt)
  -- for y = 1, self.height do
  --   for x = 1, self.width do
  --     if self.blocks[y][x] then
  --       self.blocks[y][x]:update(dt)
  --     end
  --   end
  -- end
end

function Board:draw()
  love.graphics.setColor(0, 0, 0, 100)
  love.graphics.rectangle('line', 0, 0, (self.width * BLOCK_SIZE) + 1, (self.height * BLOCK_SIZE) + 1)
  love.graphics.setColor(255, 255, 255, 255)
  -- for y = 1, self.height do
  --   for x = 1, self.width do
  --     if self.blocks[y][x] then
  --       self.blocks[y][x]:draw(dt)
  --     end
  --   end
  -- end
end
