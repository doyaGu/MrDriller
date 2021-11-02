require 'src/dependencies'
require 'src/constants'

-- game states
require 'src/states/Menu'
require 'src/states/Game'
require 'src/states/Pass'
require 'src/states/Lose'
require 'src/states/Win'
require 'src/states/Pause'
require 'src/states/Score'

-- entity states
require 'src/states/entity/Base'

-- player states
require 'src/states/entity/player/PlayerIdle'
require 'src/states/entity/player/PlayerWalking'
require 'src/states/entity/player/PlayerDrill'
require 'src/states/entity/player/PlayerClimb'
require 'src/states/entity/player/PlayerFalling'
require 'src/states/entity/player/PlayerCrush'
require 'src/states/entity/player/PlayerStifle'
require 'src/states/entity/player/PlayerRevive'

-- block states
require 'src/states/entity/block/BlockIdle'
require 'src/states/entity/block/BlockShake'
require 'src/states/entity/block/BlockFalling'
require 'src/states/entity/block/BlockDisappear'

-- general
require 'src/Background'
require 'src/Entity'
require 'src/Player'
require 'src/Block'
require 'src/Map'

-- load resources
resources = require 'src/resources'

function love.load()
  math.randomseed(os.time())

  --disable blurry scaling
  love.graphics.setDefaultFilter('nearest', 'nearest')

  love.window.setTitle('Mr Driller')

  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  gFonts = {
    ['small'] = resources.fonts['font'](16),
    ['medium'] = resources.fonts['font'](32),
    ['large'] = resources.fonts['font'](48),
    ['title'] = resources.fonts['ArcadeAlternate'](48)
  }

  gScores = {}

  Gamestate.registerEvents()
  Gamestate.switch(menu)

  -- play our music outside of all states and set it to looping
  resources.sounds['bgm']:setVolume(0.5)
  resources.sounds['bgm']:setLooping(true)
  resources.sounds['bgm']:play()
end

function love.update(dt)
  -- Gamestate.update(dt)
end

function love.keypressed(key)
  if Gamestate.current() == menu and key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  -- Gamestate.draw(dt)
  displayFPS()
end

function displayFPS()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
  love.graphics.setColor(1, 1, 1, 255)
end
