local hero = entity()
hero:new(Maze.ways.x, Maze.ways.y, 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
hero.speed = 0.1
hero.lastStep = false

function hero:tryMovement(x, y)
  if self.smoothX ~= 0 or self.smoothY ~= 0 then x, y = 0, 0 end
  if x == 0 and y == 0 then return false end
  if magic.earth.isActive and (x ~= 0 or y ~= 0) and 
    not (self.y+y < 2 or self.x+x < 2 or self.y+y > Maze.height - 1 or self.x+x > Maze.width - 1) then 
    magic.earth.isActive = false
    return self:tryMovement(2*x, 2*y)
  end
  
  self.y = tonumber(tostring(self.y))
  self.x = tonumber(tostring(self.x))
  
  local shit = Maze.content[(self.y + y)*Maze.width + self.x + x]
  if shit == Maze.wall then
    return false
  elseif shit == Maze.pass or shit == Maze.room or shit == Maze.decoKey then
    self:moveRel(x, y)
  elseif shit == Maze.chest then
    if magic.water.charges ~= 0 then
      Maze.content[(self.y + y)*Maze.width + self.x + x] = Maze.chestUsed
      magic.water.charges = magic.water.charges - 1
    end
    return false
  elseif shit == Maze.key then
    Maze.content[(self.y + y)*Maze.width + self.x + x] = Maze.decoKey
    magic.water.charges = magic.water.charges + 1
    self:moveRel(x, y)
  elseif shit == Maze.exit then
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
  end
  if math.abs(self.smoothY) > self.speed/2 then 
    self.y = self.smoothY < 0 and self.y - self.speed or self.y + self.speed 
  end
    
  self.smoothX = math.abs(self.smoothX) > self.speed/2 and 
    (self.smoothX > 0 and self.smoothX - self.speed or self.smoothX + self.speed) or 0
  self.smoothY = math.abs(self.smoothY) > self.speed/2 and 
    (self.smoothY > 0 and self.smoothY - self.speed or self.smoothY + self.speed) or 0
end

return hero