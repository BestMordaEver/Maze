camera = {}
camera.x = 0
camera.y = 0
camera.scale = 1

function camera:action()
  love.graphics.push()
  love.graphics.translate(-self.x, -self.y)
  love.graphics.scale(self.scale)
  ingameDraw()
	love.graphics.pop()
end

function camera:setPosition(x, y)
  self.x = x 
	self.y = y
end

function camera:setScale(s)
	self.scale = s
end

return camera