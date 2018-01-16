Light = require 'Light' -- God bless this man

function love.load()
  print('loading')
	love.filesystem.load('load.lua')()
  print('loaded')
end

function love.keypressed(key)
	ingameKeypressed(key)
end

function love.update(dt)
  time = time + dt
  if time > 0.033 then 
    ingameUpdate(time)
    time = dt > 0.033 and time - dt or time - 0.033
  end
end

function love.draw()
  camera:action()
  drawinterface()
end