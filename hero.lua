hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
hero.speed = 0.2
hero.lightSize = 400

function hero:tryMovement(x, y)
  if self.smoothX ~= 0 or self.smoothY ~= 0 then x, y = 0, 0 end
  if magic.earth.isActive and (x ~= 0 or y ~= 0) and 
    not (self.y+y < 2 or self.x+x < 2 or self.y+y > maze.height - 1 or self.x+x > maze.width - 1) then 
    magic.earth.isActive = false
    return self:tryMovement(2*x, 2*y)
  end
  
  self.y = tonumber(tostring(self.y))
  self.x = tonumber(tostring(self.x))
  
  local shit = maze.content[(self.y + y)*maze.width + self.x + x]
  if shit == maze.wall then
    return false
  elseif shit == maze.pass or shit == maze.room or shit == maze.decoKey then
    self:moveRel(x, y)
  elseif shit == maze.chest then
    if magic.water.charges ~= 0 then
      maze.content[(self.y + y)*maze.width + self.x + x] = maze.chestUsed
      magic.water.charges = magic.water.charges - 1
    end
    return false
  elseif shit == maze.key then
    maze.content[(self.y + y)*maze.width + self.x + x] = maze.decoKey
    magic.water.charges = magic.water.charges + 1
    self:moveRel(x, y)
  elseif shit == maze.exit then
    love.event.quit()
  end
  return true
end

function hero:update(dt)
  self.x = tonumber(string.format('%.1f', self.x))
  self.y = tonumber(string.format('%.1f', self.y))
  self.smoothX = tonumber(string.format('%.1f', self.smoothX))
  self.smoothY = tonumber(string.format('%.1f', self.smoothY))
  
  if math.abs(self.smoothX) > self.speed/2 then 
    self.x = self.smoothX < 0 and self.x - self.speed or self.x + self.speed 
    self.light.x = self.smoothX < 0 and self.light.x - self.speed*cluster.x or self.light.x + self.speed*cluster.x 
  end
  if math.abs(self.smoothY) > self.speed/2 then 
    self.y = self.smoothY < 0 and self.y - self.speed or self.y + self.speed 
    self.light.y = self.smoothY < 0 and self.light.y - self.speed*cluster.y or self.light.y + self.speed*cluster.y 
  end
    
  self.smoothX = math.abs(self.smoothX) > self.speed/2 and 
    (self.smoothX > 0 and self.smoothX - self.speed or self.smoothX + self.speed) or 0
  self.smoothY = math.abs(self.smoothY) > self.speed/2 and 
    (self.smoothY > 0 and self.smoothY - self.speed or self.smoothY + self.speed) or 0
end

hero.light = light:newLight((hero.x+0.5)*cluster.x, (hero.y+0.5)*cluster.y, 128, 128, 128, hero.lightsize)
hero.light:setGlowSize(0)
hero.light:setGlowStrength(1)
