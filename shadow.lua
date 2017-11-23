local shadow = entity()
S[#S+1] = shadow

local x, y

repeat
  x = love.math.random(2, maze.width-1)
  y = love.math.random(2, maze.height-1)
until maze[y][x] == maze.pass

shadow:new(x, y, 'shadow', 'down')

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

local function deadend(x,y) -- Checking for deadend
	local count = 0

	if maze[y][x + 1] == self.pass then 
		count = count + 1 
	end
	if maze[y + 1][x] == self.pass then 
		count = count + 1 
	end
	if maze[y][x - 1] == self.pass then 
		count = count + 1 
	end
	if maze[y - 1][x] == self.pass then 
		count = count + 1 
	end
	return count == 4
end

shadow.animation:newAnimation('moving', 0.1)
shadow.animation:setAnimation('moving')
shadow.animation:addFrame('moving','imgs/Men/Shadow1.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow2.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow3.png')

function shadow:logic()
  local around = deadend(self.x, self.y)
  
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