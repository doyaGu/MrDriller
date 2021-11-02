PlayerStifle = Class{__includes = Base}

function PlayerStifle:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['air']
  self.currentAnimation = self.animation[self.player.direction]

  self.timer = Timer.new()
  self.timer:after(1.6, function() self.dead = true end)
end

function PlayerStifle:enter()
  self.dead = false
  resources.sounds.effect['dead-air']:play()
end

function PlayerStifle:exit()
  self.timer:clear()
end

function PlayerStifle:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)

  if self.dead then
    self.player:die()
    if self.player.life >= 0 then
      self.player:changeState('revive')
    end
  end

end

function PlayerStifle:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
