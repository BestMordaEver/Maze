local animated = {x = 0, y = 0, state = 'idle',
	animation = {count = 0, current = 'idle', imgs = {}}}
E[#E+1] = animated

function animated:new(x, y, state) 
	self.x = x -- Whenever entity created - give him start values via this
	self.y = y
	self.group = group
  self.state = state
end

function animated:moveTo(x, y)
  self.x = x
  self.y = y
end

function animated.animation:newAnimation(name, del)
	self[name] = {tick = 1, time = 0, delay = del, imgs = {}}
end

function animated.animation:addFrame(name, img)
	self[name].imgs[#self[name].imgs+1] = love.graphics.newImage(img)
end

function animated.animation:wait(dt)
	if self.current ~= 'none' then 
		self[self.current].time = self[self.current].time + dt 
		if self[self.current].time > self[self.current].delay then 
			self[self.current].time = 0
			self[self.current].tick =
				self[self.current].tick == #self[self.current].imgs 
					and 1 or self[self.current].tick + 1
		end 
	end
end 

function animated.animation:setAnimation(name)
	self.current = name
	self[name].tick = 1
	self[name].time = 0
end

function animated.animation:getAnimation()
	return self.current
end

function animated:draw()
	love.graphics.draw(self.animation[self.animation.current].imgs[self.animation[self.animation.current].tick], self.x*cluster.x, self.y*cluster.y)
end

return animated