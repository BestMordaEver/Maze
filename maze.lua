local maze = {height, width, exitX = 0, exitY = 0, roomCount = 0,
	wall = 0, pass = 5, exit = 2, room = 3, chest = 4, chestUsed = 1, key = 6,
  decoKey = 7,
  light = {}, content = {}}

function maze:deadend(x,y) -- Checking for deadend
	local count = 0

	if x == self.width - 1 or self.content[y*self.width + x + 2] ~= self.wall then 
		count = count + 1 
	end
	if y == self.height - 1 or self.content[(y + 2)*self.width + x] ~= self.wall then 
		count = count + 1 
	end
	if x == 2 or self.content[y*self.width + x - 2] ~= self.wall then 
		count = count + 1 
	end
	if y == 2 or self.content[(y - 2)*self.width + x] ~= self.wall then 
		count = count + 1 
	end
	return count == 4
end

local function ended() -- Checking if room is exited
	local exit = true
	for i = 2, maze.height - 1, 2 do 
		for j = 2, maze.width - 1, 2 do
			if maze.content[i*maze.width + j] == maze.wall then exit = false end 
		end
	end
	return exit
end

local function AddLights()
  for y=1, maze.height do
    for x=1, maze.width do
      if maze.content[y*maze.width + x] == maze.wall then
        maze.light[y*maze.width + x] = light:newRectangle((x+0.5)*cluster.x, (y+0.5)*cluster.y, cluster.x, cluster.y)
      end
    end
  end
end

function maze:new(width, height)
	self.width = width 
	self.height = height

	for i=1, self.height do
    for j=1, self.width do
      self.content[i*self.width + j] = self.wall
    end
	end
end

function maze:Generate()

	local x,y

	local roomCount = math.floor(math.sqrt(self.width * self.height))
	local check = 0
  
	for l = 1, roomCount do -- Room pre-generation routine
		repeat -- Basically - they must generate before maze
			local rHeight, rWidth = 2 * love.math.random(1, 2), 2 * love.math.random(1, 2)
			local b = true
			
			repeat -- Choose the center point of room
				x = 2*love.math.random(1, (self.width - 1)/2) + 2
				x = rWidth == 4 and x or x + 1
				y = 2*love.math.random(1, (self.height - 1)/2) + 2
				y = rHeight == 4 and y or y + 1
        check = check + 1
			until not (x < rWidth + 2 or x > self.width - rWidth - 2 or y < rHeight + 2 or y > self.height - rHeight - 2) or check > 10000
      
      check = check + 1
			if check > 10000 then break end -- In case shit happens 
      
			for i = y - rHeight/2 - 2, y + rHeight/2 + 2 do -- Check for touching another rooms
				for j = x - rWidth/2 - 2, x + rWidth/2 + 2  do 
					if self.content[i*self.width + j] == self.room then 
						i = y + rHeight/2
						j = x + rWidth/2
						b = false
					end 
				end 
			end 
      
			if b then -- If we didn`t touch room - this happens
				for i = y - rHeight/2, y + rHeight/2 do 
					for j = x - rWidth/2, x + rWidth/2 do 
						self.content[i*self.width + j] = self.room
					end 
				end 
        self.content[y*self.width + x] = self.chest
        
				b = love.math.random(0, 3) -- Exit position
				if b == 0 then 
					self.content[(y + rHeight/2 + 1)*self.width + x - rWidth/2 + 2*(love.math.random(1, rWidth/2))] = self.room
				elseif b == 1 then 
					self.content[(y - rHeight/2 - 1)*self.width + x - rWidth/2 + 2*(love.math.random(1, rWidth/2))] = self.room
				elseif b == 2 then 
					self.content[(y - rHeight/2 + 2*(love.math.random(1, rHeight/2)))*self.width + x + rWidth/2 + 1] = self.room
				elseif b == 3 then 
					self.content[(y - rHeight/2 + 2*(love.math.random(1, rHeight/2)))*self.width + x - rWidth/2 - 1] = self.room
				end
        
        self.roomCount = self.roomCount + 1
			end 
			
		until b
	end 
	x, y, check = 2, 2, 0
	local direction = 0
	self.content[y*self.width + x] = self.pass -- Droppin`

	repeat -- Main cycle

		direction = love.math.random(0,3)
								-- Jumpin`
		if direction == 0 and x ~= self.width - 1 and self.content[y*self.width + x+2] ~= self.room and self.content[y*self.width + x+2] ~= self.pass then 
			self.content[y*self.width + x+1] = self.pass 
			x = x + 2 
		elseif direction == 1 and x ~= 2 and self.content[y*self.width + x-2] ~= self.room and self.content[y*self.width + x-2] ~= self.pass then 
			self.content[y*self.width + x-1] = self.pass 
			x = x - 2 
		elseif direction == 2 and y ~= self.height - 1 and self.content[(y+2)*self.width + x] ~= self.room and self.content[(y+2)*self.width + x] ~= self.pass then 
			self.content[(y+1)*self.width + x] = self.pass 
			y = y + 2
		elseif direction == 3 and y ~= 2 and self.content[(y-2)*self.width + x] ~= self.room and self.content[(y-2)*self.width + x] ~= self.pass then 
			self.content[(y-1)*self.width + x] = self.pass 
			y = y - 2
	 		end
		 	
		self.content[y*self.width + x] = self.pass -- Diggin`
	
		if self:deadend(x,y) then -- Gettin` dafuq outta here
		repeat	
	 		x = 2 * love.math.random(1, (self.width - 1) / 2)
	 		y = 2 * love.math.random(1, (self.height - 1) / 2)	 	
	 	until self.content[y*self.width + x] == self.pass
	 	end
    
	 	check = check + 1

	until check%1000 == 0 and ended()

 	-- Here is end
	if direction == 0 then
		self.exitX = self.width
		self.exitY = 2 * love.math.random(1, (self.height - 1) / 2)
	elseif direction == 1 then
		self.exitX = 1
		self.exitY = 2 * love.math.random(1, (self.height - 1) / 2)
	elseif direction == 2 then
		self.exitX = 2 * love.math.random(1, (self.width - 1) / 2)
		self.exitY = self.height
	elseif direction == 3 then 
		self.exitX = 2 * love.math.random(1, (self.width - 1) / 2)
		self.exitY = 1
	end

	self.content[self.exitY*self.width + self.exitX] = self.exit
  
  AddLights()
end

function maze:GenerateEmpty()
	for i = 2, self.height - 1 do
		for j = 2, self.width - 1 do 
			self[i*self.width + j] = self.pass
		end 
	end
  AddLights()
end

local function mapEnded()
  local exit = true
	for i = 2, maze.height - 1, 2 do 
		for j = 2, maze.width - 1, 2 do
			exit = exit and maze.ways[i*self.width + j] ~= 0
		end
	end
	return exit
end

function maze:mapWays()
  self.ways = {}
  for i = 1, self.height do 
    for j = 1, self.width do
      if self.content[i*self.width + j] == self.pass or self.content[i*self.width + j] == self.room then
        self.ways[i*self.width + j] = 0
      else
        self.ways[i*self.width + j] = -1
      end
    end
  end
  
  local W = {}
  W[1] = {}
  if self.exitX == self.width then 
    W[1].x = self.exitX - 1
  elseif self.exitX == 1 then
    W[1].x = 2
  else
    W[1].x = self.exitX
  end
  
  if self.exitY == self.height then 
    W[1].y = self.exitY - 1
  elseif self.exitY == 1 then
    W[1].y = 2
  else
    W[1].y = self.exitY
  end
  W[1].c = 1
  
  local count = 0
  
  repeat
    count = count + 1 
    for key, val in pairs(W) do
      self.ways[val.y*self.width + val.x] = val.c
      if self.ways[val.y*self.width + val.x+1] == 0 then table.insert(W, {y = val.y, x = val.x+1, c = val.c+1}) end
      if self.ways[val.y*self.width + val.x-1] == 0 then table.insert(W, {y = val.y, x = val.x-1, c = val.c+1}) end
      if self.ways[(val.y+1)*self.width + val.x] == 0 then table.insert(W, {y = val.y+1, x = val.x, c = val.c+1}) end
      if self.ways[(val.y-1)*self.width + val.x] == 0 then table.insert(W, {y = val.y-1, x = val.x, c = val.c+1}) end
      self.ways.max = val.c
      self.ways.x = val.x
      self.ways.y = val.y
      W[key] = nil
    end
    
  until count%1000 == 0 and mapEnded
end

function maze:decorate()
  for i=1, self.roomCount*1.5 do 
    local x, y
    repeat
      x, y = math.random(1, self.width), math.random(1, self.height)
    until self.content[y*self.width + x] == self.pass
    self.content[y*self.width + x] = self.key
  end
end
return maze