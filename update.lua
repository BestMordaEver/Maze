local foo = function (dt)
  for i, e in pairs(E) do 
    e.animation:wait(dt)
  end 
  magic:update(dt)
  
  time = time + dt
  if time > 0.5 then
    for key, val in pairs(S) do
      val:logic()
    end
    time = 0
  end

  --[[local lvX, lvY = 0, 0
  
  if love.keyboard.isDown('down') then lvY = 1 end 
  if love.keyboard.isDown('up') then lvY = lvY - 1 end 
  if love.keyboard.isDown('right') then lvX = 1 end 
  if love.keyboard.isDown('left') then lvX = lvX - 1 end 
  
  hero:tryMovement(lvX, lvY, maze)
  ]] -- push to move
  
  camera:setPosition((hero.x+1)*clusterX - width/2, (hero.y+1)*clusterY - height/2)

end
return foo