PlayerRevive = Class{__includes = Base}

function PlayerRevive:init(player)
  self.player = player

  self.texture = resources.images['player']
  self.animation = resources.animations['player']['revive']
  self.currentAnimation = self.animation

  self.timer = Timer.new()

  local process = function()
    local world = self.player.world
    local blocks, len = world:queryRect(self.player.x - self.player.width - 4, 0, self.player.width * 3, self.player.y + self.player.height)
    if len ~= 0 then
      for i = 1, len do
        local block = blocks[i]
        if block.id then
          block.durability = 0
        end
      end
    end
    self.player.air = 100
    self.player.stifle = false
    self.player.alive = true
    self.player:changeState('idle')
  end

  self.timer:after(1.2, process)
end

function PlayerRevive:enter()
  self.dead = false
    resources.sounds.effect['resurrection']:play()
end

function PlayerRevive:exit()
  self.timer:clear()
end

function PlayerRevive:update(dt)
  self.timer:update(dt)
  self.currentAnimation:update(dt)
end

function PlayerRevive:draw()
  self.currentAnimation:draw(self.texture, self.player.x, self.player.y)
end
