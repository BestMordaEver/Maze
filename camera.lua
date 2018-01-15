-- Code is fully stolen from some guy, who didn't mind, so again, who cares?
-- Modificated in order to work with lightWorld lib
camera = {}
camera.x = 0
camera.y = 0
camera.scale = 1

function camera:move(dx, dy)
	self.x = self.x + (dx or 0)
	self.y = self.y + (dy or 0)
end

function camera:setPosition(x, y)
	self.x = x or self.x
	self.y = y or self.y
  light:setTranslation(-x or -self.x, -y or -self.y)
end

function camera:setScale(s)
	self.scale = s or self.scale
  light:setScale(s or self.scale)
end

return camera