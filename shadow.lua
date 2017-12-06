local shadow = entity()
S[#S+1] = shadow
shadow.isStunned = false
shadow.timeStunned = 5
shadow.maxStunned = 5
shadow.speed = 0.04

local x, y

repeat  
  local b = true
  x = love.math.random(2, maze.width-1)
  y = love.math.random(2, maze.height-1)
  for i=1, #S do
    b = b and (S[i] == shadow or (math.abs(maze.ways[y][x] - maze.ways[S[i].y][S[i].x]) > 3))
  end
  b = b and math.abs(maze.ways[y][x] - maze.ways[hero.y][hero.x]) > 3
until maze[y][x] == maze.pass and b

function shadow:tryMovement(x, y)
  self.y = tonumber(tostring(self.y))
  self.x = tonumber(tostring(self.x))
  if self.y + y == magic.fire.y and self.x + x == magic.fire.x then 
    self:turnAround()
    return false
  end
  local shit = maze[self.y + y][self.x + x]
  if shit == maze.wall or shit == maze.room or shit == maze.exit then
    return false
  elseif shit == maze.pass then
    self:moveRel(x, y)
  end
  return true
end

function shadow:step()
  if self.state == 'down' then 
    return self:tryMovement(0, 1)
  elseif self.state == 'right' then 
    return self:tryMovement(1, 0)
  elseif self.state == 'up' then 
    return self:tryMovement(0, -1) 
  elseif self.state == 'left' then 
    return self:tryMovement(-1, 0) 
  end
  return true
end

function shadow:ready()
  while not self:step() do 
    self:turnLeft() 
  end
end

shadow:new(x, y, 'shadow', 'down') 
shadow:ready()

function shadow:deadend()
	local count = 0

	if maze[self.y][self.x + 1] == maze.pass then 
		count = count + 1 
	end
	if maze[self.y + 1][self.x] == maze.pass then 
		count = count + 1 
	end
	if maze[self.y][self.x - 1] == maze.pass then 
		count = count + 1 
	end
	if maze[self.y - 1][self.x] == maze.pass then 
		count = count + 1 
	end
	return count
end

function shadow:logic()
  self.x = tonumber(tostring(self.x))
  self.y = tonumber(tostring(self.y))
  local around = self:deadend()
  
  if magic.light.isActive then 
    for key, _ in pairs(magic.light.souls) do
      local _, _, x, y = key:find('(%d+) (%d+)')
      x, y = tonumber(x), tonumber(y)
      if self.x == x and self.y == y then 
        self.isStunned = true
        self.timeStunned = 0
      end
    end
  end
  
  if self.isStunned then around = 0 end
  
  if around == 1 then
    if not self:step() then
      self:turnAround()
      self:step()
    end
    
  elseif around == 2 then
    if not self:step() then
      self:turnLeft()
      if not self:step() then
        self:turnAround()
        self:step()
      end
    end
  
  elseif around == 3 then
    local r = love.math.random(1, 2)
    if r == 1 then 
      self:turnLeft()
    else 
      self:turnRight()
    end
    if not self:step() then
      self:turnAround()
      self:step()
    end
      
  elseif around == 4 then 
    local r = love.math.random(1, 3)
    if r == 1 then
      self:turnLeft()
    elseif r == 2 then
      self:turnRight()
    end
    self:step()
  end
end

function shadow:update(dt)
  if self.smoothX == 0 and self.smoothY == 0 then self:logic() end
  if self.isStunned then 
    self.timeStunned = self.timeStunned + dt end
  if self.timeStunned > self.maxStunned then self.isStunned = false end
  if math.abs(self.smoothX) > self.speed/2 then self.x = self.smoothX < 0 and self.x - self.speed or self.x + self.speed end
  if math.abs(self.smoothY) > self.speed/2 then self.y = self.smoothY < 0 and self.y - self.speed or self.y + self.speed end
  self.smoothX = math.abs(self.smoothX) > self.speed/2 and (self.smoothX > 0 and self.smoothX - self.speed or self.smoothX + self.speed) or 0
  self.smoothY = math.abs(self.smoothY) > self.speed/2 and (self.smoothY > 0 and self.smoothY - self.speed or self.smoothY + self.speed) or 0
end

shadow.animation:newAnimation('moving', 0.1)
shadow.animation:setAnimation('moving')
shadow.animation:addFrame('moving','imgs/Men/Shadow1.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow2.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow3.png')