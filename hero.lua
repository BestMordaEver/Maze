hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
function hero:tryMovement(x, y)
  local shit = maze[self.y + y][self.x + x]
  if shit == maze.wall and not magic.earth.isActive then
    return false
  elseif shit == maze.pass or magic.earth.isActive then
    self:moveRel(x, y)
  elseif shit == maze.room then
    self:moveRel(x, y)
  elseif shit == maze.exit then
    love.event.quit()
  end
  return true
end
