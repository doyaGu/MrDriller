Block = Class{__includes = Entity}

function Block:init(def)
  Entity.init(self, def)

  self.id = def.id or 0
  self.durability = (self.id == BLOCK_ID.BROWN) and 5 or 1
  self.isDrilled = false
  self.shaking = false
end

function Block:update(dt)
  Entity.update(self, dt)
  if not self.removed and not self.shaking then
    self.world:update(self, self.x, self.y)
  end
end

function Block:draw()
  Entity.draw(self)
end

function Block:getAdjacent()
  local world = self.world
  local x, y, width, height = self.x, self.y, self.width, self.height

  local upEntity = world:queryPoint(x + width / 2, y - 1)
  local downEntity = world:queryPoint(x + width / 2, y + height + 1)
  local leftEntity = world:queryPoint(x - 1, y + height / 2)
  local rightEntity = world:queryPoint(x + width + 1, y + height / 2)

  return {upEntity[1], downEntity[1], leftEntity[1], rightEntity[1]}
end
