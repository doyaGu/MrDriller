BlockShake = Class{__includes = Base}

function BlockShake:init(block, player)
  self.block = block
  self.player = player

  self.originX = self.block.x

  self.texture = resources.images['block']
  self.animation = resources.animations['block'][self.block.id][1]
  self.animationIndex = 1
  self.currentAnimation = self.animation[self.animationIndex]

  self.timer = Timer.new()

  local process = function()
    self.ready = true
    self.block.shaking = false
  end

  self.timer:after(1, process)

  local shakeToLeft, shakeToRight
  shakeToLeft = function()
    self.timer:tween(0.1, self.block, {x = self.block.x - 3}, 'in-out-quad', shakeToRight)
  end
  shakeToRight = function()
    self.timer:tween(0.1, self.block, {x = self.block.x + 3}, 'in-out-quad', shakeToLeft)
  end
  shakeToLeft()
end

function BlockShake:enter()
  self.ready = false
  self.block.shaking = true
end

function BlockShake:exit()
  self.timer:clear()
end

function BlockShake:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)

  if self.ready then
    self.block.x = self.originX
    self.block.dy = 0
    self.block:changeState('falling')
  end
end

function BlockShake:draw()
  self.currentAnimation:draw(self.texture, self.block.x, self.block.y)
end
