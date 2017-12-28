local foo = function (dt)
  light:update(dt)
  for _, e in pairs(E) do 
    e.animation:wait(dt)
    e:update(dt)
  end 
  
  magic:update(dt)
  
  local lvX, lvY = 0, 0
  
  if love.keyboard.isDown('s') then lvY = 1 end 
  if love.keyboard.isDown('w') then lvY = lvY - 1 end 
  if love.keyboard.isDown('d') then lvX = 1 end 
  if love.keyboard.isDown('a') then lvX = lvX - 1 end 
  local _, x = math.modf(hero.x)
  local _, y = math.modf(hero.y)
  
  if x == 0 and y == 0 and not magic.light.isActive then 
    if flip then hero:tryMovement(lvX, 0) end
    if not flip then hero:tryMovement(0, lvY) end
  end
  flip = not flip

  --[[
  if lvX ~= 0 and lvY ~= 0 then 
    cluster.xScale = cluster.xScale <= cluster.minX and cluster.xScale or cluster.xScale - 0.03
    cluster.yScale = cluster.yScale <= cluster.minY and cluster.yScale or cluster.yScale - 0.03
  end
  cluster.xScale = cluster.xScale >= cluster.maxX and cluster.xScale or cluster.xScale + 0.01
  cluster.yScale = cluster.yScale >= cluster.maxY and cluster.yScale or cluster.yScale + 0.01
  print(cluster.xScale)
  print(cluster.yScale)
  print()
  ]]
  camera:setPosition((hero.x+1)*cluster.x - width/2, (hero.y+1)*cluster.y - height/2)
  --camera:setScale(0.1, 0.1)
  love.window.setTitle(love.timer.getFPS())
  
end
return foo