Light = require 'Light' -- God bless this man

function love.load()
  print('loading')
	love.filesystem.load('load.lua')()
  print('loaded')
end

function love.keypressed(key)
	keypressed(key)
end

function love.update(dt)
  light:update(dt)
  update(dt)
end

function love.draw()
  light:setTranslation(-camera.x, -camera.y)
	camera:set()
  light:draw(draw)
	camera:unset()
end