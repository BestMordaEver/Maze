local room = {height, width, exitX = 0, exitY = 0, 
	wall = 0, pass = 1, exit = 2, room = 3, chest = 4, aAltar = 5, uAltar = 6}
local sanity = 0 -- Zero for no cycles, use wisely

local function deadend(x,y) -- Checking for deadend
	local count = 0

	if x == room.width - 1 or room[y][x + 2] ~= room.wall then 
		count = count + 1 
	end
	if y == room.height - 1 or room[y + 2][x] ~= room.wall then 
		count = count + 1 
	end
	if x == 2 or room[y][x - 2] ~= room.wall then 
		count = count + 1 
	end
	if y == 2 or room[y - 2][x] ~= room.wall then 
		count = count + 1 
	end
	return count == 4
end

local function ended() -- Checking if room is exited
	local exit = true
	for i = 2, room.height - 1, 2 do 
		for j = 2, room.width - 1, 2 do
			if room[i][j] == room.wall then exit = false end 
		end
	end
	return exit
end

function room:new(width, height)
	self.width = width 
	self.height = height 

	for i = 1, self.height do -- The place is filled with walls
		self[i] = {}
		for j = 1, self.width do 
			self[i][j] = {}
			self[i][j] = self.wall
		end
	end
end

function room:Generate()

	local x,y

	local roomCount = math.floor((self.width * self.height) / 80)
	local check = 0

	for l = 1, roomCount do -- Room pre-generation routine
		repeat -- Basically - they must generate before maze
			
			local rHeight, rWidth = 2 * love.math.random(1, 2), 2 * love.math.random(1, 2)
			local b = true
			check = check + 1
			if check == 10000 then break end -- In case shit happens 
			
			repeat -- Choose the center point of room
				x = 2*love.math.random(1, (self.width - 1)/2) + 2
				x = rWidth == 4 and x or x + 1
				y = 2*love.math.random(1, (self.height - 1)/2) + 2
				y = rHeight == 4 and y or y + 1
			until not (x < rWidth + 2 or x > self.width - rWidth - 2 or y < rHeight + 2 or y > self.height - rHeight - 2)

			for i = y - rHeight/2 - 2, y + rHeight/2 + 2 do -- Check for touching another rooms
				for j = x - rWidth/2 - 2, x + rWidth/2 + 2  do 
					if self[i][j] == self.room then 
						i = y + rHeight/2
						j = x + rWidth/2
						b = false
					end 
				end 
			end 

			if b then -- If we didn`t touch room - this happens
				for i = y - rHeight/2, y + rHeight/2 do 
					for j = x - rWidth/2, x + rWidth/2 do 
						maze[i][j] = self.room
					end 
				end 
	
				b = love.math.random(0, 3) -- Exit position
				if b == 0 then 
					self[y + rHeight/2 + 1][x - rWidth/2 + 2*(love.math.random(1, rWidth/2))] = self.room
				elseif b == 1 then 
					self[y - rHeight/2 - 1][x - rWidth/2 + 2*(love.math.random(1, rWidth/2))] = self.room
				elseif b == 2 then 
					self[y - rHeight/2 + 2*(love.math.random(1, rHeight/2))][x + rWidth/2 + 1] = self.room
				elseif b == 3 then 
					self[y - rHeight/2 + 2*(love.math.random(1, rHeight/2))][x - rWidth/2 - 1] = self.room
				end
			end 
			
		until b
	end 

	x, y, check = 2, 2, 0
	local direction = 0
	self[y][x] = self.pass -- Droppin`

	repeat -- Main cycle

		direction = love.math.random(0,3)
								-- Jumpin`
		if direction == 0 and x ~= self.width - 1 and self[y][x+2] ~= self.room and (self[y][x+2] ~= self.pass or check%sanity == 0) then 
			self[y][x+1] = self.pass 
			x = x + 2 
		elseif direction == 1 and x ~= 2 and self[y][x-2] ~= self.room and (self[y][x-2] ~= self.pass or check%sanity == 0) then 
			self[y][x-1] = self.pass 
			x = x - 2 
		elseif direction == 2 and y ~= self.height - 1 and self[y+2][x] ~= self.room and (self[y+2][x] ~= self.pass or check%sanity == 0) then 
			self[y+1][x] = self.pass 
			y = y + 2
		elseif direction == 3 and y ~= 2 and self[y-2][x] ~= self.room and (self[y-2][x] ~= self.pass or check%sanity == 0) then 
			self[y-1][x] = self.pass 
			y = y - 2
	 		end
		 	
		self[y][x] = self.pass -- Diggin`
	
		if deadend(x,y) then -- Gettin` dafuq outta here
		repeat	
	 		x = 2 * love.math.random(1, (self.width - 1) / 2)
	 		y = 2 * love.math.random(1, (self.height - 1) / 2)	 	
	 	until self[y][x] == self.pass
	 	end

	 	check = check + 1

	until check%1000 == 0 and ended()

  for i = 3, maze.height-2, 2 do -- To erase insanity results
    for j = 3, maze.width-2, 2 do
      if maze[i][j+1] == maze.pass and maze[i][j-1] == maze.pass and maze[i+1][j] == maze.pass and maze[i-1][j] == maze.pass then
        maze[i][j] = maze.pass
      end
    end
  end
  

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

	self[self.exitY][self.exitX] = self.exit
end

function room:GenerateEmpty()
	for i = 2, self.height - 1 do
		for j = 2, self.width - 1 do 
			self[i][j] = self.pass
		end 
	end
end

return room