Light = require 'Light' -- God bless this man

function love.load()
	love.filesystem.load('load.lua')()
  ingameLoad()
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