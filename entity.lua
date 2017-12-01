local entity = love.filesystem.load('animated.lua')()
entity.smoothX = 0
entity.smoothY = 0

function entity:moveRel(x, y)
  self.smoothX = self.smoothX + x
  self.smoothY = self.smoothY + y
end

function entity:turnLeft()
  if self.state == 'down' then 
    self.state = 'right' 
  elseif self.state == 'right' then 
    self.state = 'up'
  elseif self.state == 'up' then 
    self.state = 'left'
  elseif self.state == 'left' then 
    self.state = 'down' 
  end
end

function entity:turnRight()
  if self.state == 'down' then 
    self.state = 'left' 
  elseif self.state == 'right' then 
    self.state = 'down'
  elseif self.state == 'up' then 
    self.state = 'right'
  elseif self.state == 'left' then 
    self.state = 'up' 
  end
end

function entity:turnAround()
  if self.state == 'down' then 
    self.state = 'up' 
  elseif self.state == 'right' then 
    self.state = 'left'
  elseif self.state == 'up' then 
    self.state = 'down'
  elseif self.state == 'left' then 
    self.state = 'right' 
  end
end

return entity