local foo = function (dt)
  light:update(dt)
  for _, e in pairs(E) do 
    e.animation:wait(dt)
    e:update(dt)
  end 
  
  magic:update(dt)
  
  local lvX, lvY = 0, 0
  
  if love.keyboard.isDown(keyPreset.down) then lvY = 1 end 
  if love.keyboard.isDown(keyPreset.up) then lvY = lvY - 1 end 
  if love.keyboard.isDown(keyPreset.right) then lvX = 1 end 
  if love.keyboard.isDown(keyPreset.left) then lvX = lvX - 1 end 
  local _, x = math.modf(hero.x)
  local _, y = math.modf(hero.y)
  
  if x == 0 and y == 0 and not magic.light.isActive and not magic.darkness.isActive then 
    if flip then hero:tryMovement(lvX, 0) end
    if not flip then hero:tryMovement(0, lvY) end
  end
  flip = not flip

  if lvX ~= 0 and lvY ~= 0 then 
    cluster.xScale = cluster.xScale <= cluster.minX and cluster.xScale or cluster.xScale - 0.03
    cluster.yScale = cluster.yScale <= cluster.minY and cluster.yScale or cluster.yScale - 0.03
  end
  cluster.xScale = cluster.xScale >= cluster.maxX and cluster.xScale or cluster.xScale + 0.01
  cluster.yScale = cluster.yScale >= cluster.maxY and cluster.yScale or cluster.yScale + 0.01
  
  shadowTime = shadowTime + dt
  if shadowTime > 2 then
    watchlist = {}
    for _, sh in pairs(S) do
      if maze:findAbsolute(sh.x, sh.y, hero.x, hero.y) < 20 then table.insert(watchlist, sh) end
    end
    shadowTime = 0
  end
  
  watchdogs:set()
  for _, val in pairs(watchlist) do
    local steps, dir = maze:findAbsolute(val.x, val.y, hero.x, hero.y)
    if watchdogs[dir] > steps then watchdogs[dir] = steps end
  end
  
  camera:setPosition((hero.x+1)*cluster.x - width/2, (hero.y+1)*cluster.y - height/2)
  --camera:setScale(0.1, 0.1)
  love.window.setTitle(love.timer.getFPS())
end
return foo