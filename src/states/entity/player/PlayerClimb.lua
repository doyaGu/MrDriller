PlayerClimb = Class{__includes = Base}

function PlayerClimb:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['climb']
  self.currentAnimation = self.animation[self.player.direction]

  self.timer = Timer.new()
  self.timer:after(0.8, function() self.player:changeState('walking') end)

  local climb, move
  climb = function()
    self.timer:tween(0.4, self.player, {y = self.player.y - self.player.height - 6}, 'in-out-quad', move)
  end
  if self.player.direction == 'right' then
    move = function()
      self.timer:tween(0.4, self.player, {x = self.player.x + self.player.width}, 'in-out-quad')
    end
  else
    move = function()
      self.timer:tween(0.4, self.player, {x = self.player.x - self.player.width}, 'in-out-quad')
    end
  end
  climb()
end

function PlayerClimb:exit()
  self.timer:clear()
end

function PlayerClimb:update(dt)
  self.timer:update(dt)
  self.currentAnimation = self.animation[self.player.direction]
  self.currentAnimation:update(dt)
end

function PlayerClimb:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
