function love.load()
	love.filesystem.load('load.lua')()
  mainmenuLoad()
end

function love.update(dt)
  if gameState == 'ingame' then
    time = time + dt
    if time > 0.033 then 
      ingameUpdate(time)
      time = dt > 0.033 and time - dt or time - 0.033
    end
  elseif gameState == 'mainmenu' then
    mainmenuUpdate(dt)
  elseif gameState == 'pause' then
    pauseUpdate(dt)
  elseif gameState == 'transfer' then
    ingameLoad()
    gameState = 'ingame'
  end
end

function love.keypressed(key)
	if gameState == 'ingame' then
    ingameKeypressed(key)
  elseif gameState == 'mainmenu' then
    mainmenuKeypressed(key)
  elseif gameState == 'pause' then
    pauseKeypressed(key)
  end
end

function love.mousepressed(x, y, button)
  if gameState == 'mainmenu' then 
  
  end
end

function love.mousereleased(x, y, button)
  if button == 1 and gameState == 'mainmenu' or gameState == 'pause' then
    local x, y = love.mouse.getPosition()
    for _, b in pairs(B) do
      if x > b.x and x < b.dx and y > b.y and y < b.dy then
        b.action()
        break
      end
    end
  end
end

function love.draw()
  if gameState == 'ingame' then
    camera:action()
    drawinterface()
  elseif gameState == 'mainmenu' then
    mainmenuDraw()
  elseif gameState == 'pause' then
    camera:action()
    pauseDraw()
  end
end