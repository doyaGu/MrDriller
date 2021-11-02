PlayerCrush = Class{__includes = Base}

function PlayerCrush:init(player)
  self.player = player
  self.player.direction = (self.player.direction == 'down') and 'right' or self.player.direction

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['crushed']
  self.currentAnimation = self.animation[self.player.direction]

  self.timer = Timer.new()
  self.timer:after(1.8, function() self.dead = true end)
end

function PlayerCrush:enter()
  self.dead = false
  resources.sounds.effect['block-crush']:play()
end

function PlayerCrush:exit()
  self.timer:clear()
end

function PlayerCrush:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)

  if self.dead then
    self.player:die()
    if self.player.life ~= 0 then
      self.player:changeState('revive')
    end
  end
end

function PlayerCrush:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
