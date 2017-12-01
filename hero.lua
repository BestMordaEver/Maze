hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
function hero:tryMovement(x, y)
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
  if math.abs(self.smoothX) > 0.1 then self.x = self.smoothX < 0 and self.x - 0.2 or self.x + 0.2 end
  if math.abs(self.smoothY) > 0.1 then self.y = self.smoothY < 0 and self.y - 0.2 or self.y + 0.2 end
  if math.abs(self.smoothX) > 0.1 then 
    self.light.x = self.smoothX < 0 and self.light.x - 0.2*clusterX or self.light.x + 0.2*clusterX 
  end
  if math.abs(self.smoothY) > 0.1 then 
    self.light.y = self.smoothY < 0 and self.light.y - 0.2*clusterY or self.light.y + 0.2*clusterY 
  end
  self.smoothX = math.abs(self.smoothX) > 0.1 and (self.smoothX > 0 and self.smoothX - 0.2 or self.smoothX + 0.2) or 0
  self.smoothY = math.abs(self.smoothY) > 0.1 and (self.smoothY > 0 and self.smoothY - 0.2 or self.smoothY + 0.2) or 0
end

hero.light = light:newLight((hero.x+0.5)*clusterX, (hero.y+0.5)*clusterY, 255, 255, 255, 500)
