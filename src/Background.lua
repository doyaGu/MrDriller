Background = Class{}

function Background:init(color)
  self.color = color or {0, 0, 0, 255}
end

function Background:draw()
love.graphics.setBackgroundColor(self.color)
end
