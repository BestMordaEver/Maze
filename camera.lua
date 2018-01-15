camera = {}
camera.x = 0
camera.y = 0
camera.scale = 1

function camera:action()
  love.graphics.push()
  light:setTranslation(-self.x, -self.y, self.scale)
  light:draw(draw)
	love.graphics.pop()
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
end

function camera:setScale(s)
	self.scale = s or self.scale
end

return camera