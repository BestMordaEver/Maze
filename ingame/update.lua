local foo = function (dt)
  light:update(dt)
  for _, s in pairs(S) do -- Update for shadows
    s.animation:wait(dt)
    s:update(dt)
    if (math.abs(s.x - hero.x) < 0.75 and math.abs(s.y - hero.y) < 0.75) and not s.isStunned and not magic.darkness.isActive then 
      love.event.quit() 
    end
  end 
  hero.animation:wait(dt)
  hero:update(dt)
  
  magic:update(dt)
  
  local lvX, lvY = 0, 0 -- Movement control
  
  if love.keyboard.isDown(keyPreset.down) then lvY = 1 end 
  if love.keyboard.isDown(keyPreset.up) then lvY = lvY - 1 end 
  if love.keyboard.isDown(keyPreset.right) then lvX = 1 end 
  if love.keyboard.isDown(keyPreset.left) then lvX = lvX - 1 end 
  local _, x = math.modf(hero.x)
  local _, y = math.modf(hero.y)
  
  if flip then hero.lastStep = false end -- Camera shifting fix
  
  if x == 0 and y == 0 and not magic.light.isActive and not magic.darkness.isActive then 
    if flip then hero.lastStep = hero:tryMovement(lvX, 0) or hero.lastStep end
    if not flip then hero.lastStep = hero:tryMovement(0, lvY) or hero.lastStep end
  end
  flip = not flip

  if hero.lastStep and (lvX ~= 0 or lvY ~= 0) then -- Camera shifting back
    cluster.s = cluster.s <= cluster.min and cluster.s or cluster.s - 0.004
  else
    cluster.s = cluster.s >= cluster.max and cluster.s or cluster.s + 0.0005
  end
  
  shadowTime = shadowTime + dt -- Watchlist control
  if shadowTime > 2 then
    watchlist = {}
    for _, sh in pairs(S) do
      if maze:findAbsolute(sh.x, sh.y, hero.x, hero.y) < 20 then table.insert(watchlist, sh) end
    end
    shadowTime = 0
  end
  
  watchdogs.up, watchdogs.down, watchdogs.left, watchdogs.right = 20, 20, 20, 20
  for _, val in pairs(watchlist) do
    local steps, dir = maze:findAbsolute(val.x, val.y, hero.x, hero.y)
    if watchdogs[dir] > steps then watchdogs[dir] = steps end
  end
  
  camera:setScale(cluster.s)
  camera:setPosition((hero.x+0.5)*cluster.x*camera.scale - width/2, (hero.y+0.5)*cluster.y*camera.scale - height/2)
  love.window.setTitle(love.timer.getFPS())
end
return foo