BlockDisappear = Class{__includes = Base}

function BlockDisappear:init(block, player)
  self.block = block
  self.player = player

  self.texture = resources.images['block']
  self.animation = resources.animations['block'][self.block.id][1]
  self.currentAnimation = self.animation[#self.animation]

  self.timer = Timer.new()

  local process = function()
    self.player.score = self.player.score + 100
    if self.block.id == BLOCK_ID.AIR then
      self.player.score = self.player.score + 100
      self.player.air = (self.player.air + 20 < 100) and self.player.air + 20 or 100
    elseif self.block.id == BLOCK_ID.FLOOR then
      self.player.score = self.player.score + 1000
      self.player.pass = true
    end
    self.block:destroy()
  end

  self.timer:after(0.3, process)
end

function BlockDisappear:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)
end

function BlockDisappear:draw()
  self.currentAnimation:draw(self.texture, self.block.x, self.block.y)
end
