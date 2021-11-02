Entity = Class{}

function Entity:init(def)
  -- position
  self.x = def.x
  self.y = def.y

  -- velocity
  self.dx = 0
  self.dy = 0

  -- dimensions
  self.width = def.width
  self.height = def.height

  -- timer
  -- self.timer = def.timer or nil

  -- state
  self.states = def.states or {}
  self.currentState = {
    enter = function() end,
    exit = function() end,
    update = function() end,
    draw = function() end,
  }
  self.removed = false
  -- reference to world so we can check collisions and test against other entities
  self.world = def.world
  self.world:add(self, self.x, self.y, self.width, self.height)
end

function Entity:changeState(state, ...)
  assert(self.states[state])
  self.currentState:exit()
  self.currentState = self.states[state]()
  self.currentState:enter(...)
end

function Entity:update(dt)
  self.currentState:update(dt)
end

function Entity:filter(entity)
  local id = entity.id
  if id then
    return (id == BLOCK_ID.AIR) and 'cross' or 'touch'
  end
  return 'slide'
end

function Entity:getCenter()
  return self.x + self.width / 2,
         self.y + self.height / 2
end

function Entity:destroy()
  self.removed = true
  self.world:remove(self)
end

function Entity:draw()
  self.currentState:draw(dt)
end
