hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
function hero:tryMovement(x, y)
  if magic.earth.isActive then 
    magic.earth.isActive = false
    return self:tryMovement(2*x, 2*y)
  end
  if self.y+y < 2 or self.x+x < 2 or self.y+y > maze.height - 1 or self.x+x > maze.width - 1 then
    x, y = 0, 0
  end
  
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
