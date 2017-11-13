local entity = {x = 0, y = 0, group, steps = 10, 
	animation = {count = 0, current = 'none', imgs = {}}}
E[#E+1] = entity

function entity:new(x, y, sx, sy, group) 
	self.x = x -- Whenever entity created - give him start values via this
	self.y = y
	self.group = group
end

function entity:tryMovement(x, y, maze)
  if maze[self.y + y][self.x + x] ~= maze.wall then
    self.y = self.y + y
    self.x = self.x + x
  end
end

-- Animation part
function entity.animation:newAnimation(name, del)
	self[name] = {tick = 1, time = 0, delay = del, imgs = {}}
end

function entity.animation:addFrame(name, img)
	self[name].imgs[#self[name].imgs+1] = love.graphics.newImage(img)
end

function entity.animation:Wait(dt)
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

function entity.animation:setAnimation(name)
	self.current = name
	self[name].tick = 1
	self[name].time = 0
end

function entity.animation:getAnimation()
	return self.current
end

function entity:Draw()
	love.graphics.draw(self.animation[self.animation.current].imgs[self.animation[self.animation.current].tick], self.x*cluster, self.y*cluster)
end

return entity