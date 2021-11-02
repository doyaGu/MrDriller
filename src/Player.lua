Player = Class{__includes = Entity}

function Player:init(def)
  Entity.init(self, def)

  self.speed = PLAYER_WALK_SPEED
  self.direction = 'right'

  self.score = 0
  self.life = 3
  self.air = 100

  self.alive = true
  self.stifle = false
  self.pass = false
  self.timer = Timer.new()
  self.timer:every(1, function() self.air = self.air - 1 end)
end

function Player:update(dt)
  Entity.update(self, dt)
  if not self.removed then
    self.world:update(self, self.x, self.y)
  end

  self.timer:update(dt)

  if self.air == 0 then
    self.stifle = true
  elseif self.air < 10 then
    resources.sounds.effect['air-less-than-ten']:play()
  elseif self.air < 30 then
    resources.sounds.effect['air-less-than-thrity']:play()
  end
end

function Player:draw()
  Entity.draw(self)
end

function Player:die()
  self.alive = false
  self.life = self.life - 1
end
