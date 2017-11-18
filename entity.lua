local animated = love.filesystem.load('animated.lua')
local entity = animated()

function entity:new(x, y, group, state) 
	self.x = x -- Whenever entity created - give him start values via this
	self.y = y
	self.group = group
  self.state = state
end

function entity:tryMovement(x, y, maze)
  local shit = maze[self.y + y][self.x + x]
  if shit ~= maze.wall then
    self.y = self.y + y
    self.x = self.x + x
  end
end

return entity