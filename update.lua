local foo = function (dt)
  for _, e in pairs(E) do 
    e.animation:wait(dt)
    --e:update(dt)
  end 
  
  magic:update(dt)
  hero:update(dt)
  local lvX, lvY = 0, 0
  
  if love.keyboard.isDown('s') then lvY = 1 end 
  if love.keyboard.isDown('w') then lvY = lvY - 1 end 
  if love.keyboard.isDown('d') then lvX = 1 end 
  if love.keyboard.isDown('a') then lvX = lvX - 1 end 
  local _, x = math.modf(hero.x)
  local _, y = math.modf(hero.y)
  
  if x == 0 and y == 0 then hero:tryMovement(lvX, lvY, maze) end
  
  camera:setPosition((hero.x+1)*clusterX - width/2, (hero.y+1)*clusterY - height/2)

end
return foo