function love.load()
  print('loading')
	love.filesystem.load('load.lua')()
  print('loaded')
end

function love.keypressed(key)
	keypressed(key)
end

function love.update(dt)
  update(dt)
end

function love.draw()
	camera:set()
	draw()
	camera:unset()
end