hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
hero.speed = 0.2
function hero:tryMovement(x, y)
  if self.smoothX ~= 0 or self.smoothY ~= 0 then x, y = 0, 0 end
  if magic.earth.isActive and not (self.y+y < 2 or self.x+x < 2 or self.y+y > maze.height - 1 or self.x+x > maze.width - 1) then 
    magic.earth.isActive = false
    return self:tryMovement(2*x, 2*y)
  end
  self.y = tonumber(tostring(self.y))
  self.x = tonumber(tostring(self.x))
  local shit = maze[self.y + y][self.x + x]
  if shit == maze.wall then
    return false
  elseif shit == maze.pass then
    self:moveRel(x, y)
  elseif shit == maze.room then
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
    self.light.x = self.smoothX < 0 and self.light.x - self.speed*clusterX or self.light.x + self.speed*clusterX 
  end
  if math.abs(self.smoothY) > self.speed/2 then 
    self.y = self.smoothY < 0 and self.y - self.speed or self.y + self.speed 
    self.light.y = self.smoothY < 0 and self.light.y - self.speed*clusterY or self.light.y + self.speed*clusterY 
  end
    
  self.smoothX = math.abs(self.smoothX) > self.speed/2 and 
    (self.smoothX > 0 and self.smoothX - self.speed or self.smoothX + self.speed) or 0
  self.smoothY = math.abs(self.smoothY) > self.speed/2 and 
    (self.smoothY > 0 and self.smoothY - self.speed or self.smoothY + self.speed) or 0
end

hero.light = light:newLight((hero.x+0.5)*clusterX, (hero.y+0.5)*clusterY, 255, 255, 255, 500)
