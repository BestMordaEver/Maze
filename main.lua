function love.load()
	start = love.filesystem.load('start.lua')
	start()
  print('load ended')
end

function love.keypressed(key)
	k = key
	keys()
end

function love.update(dt)
	t = dt
	updates()
end

function love.draw()
	camera:set()
	drawing()
	camera:unset()
end