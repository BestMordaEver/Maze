local magic = {
  air = {
    cdFinal = 7,
    cd = 7,
    x = 0,
    y = 0,
    isActive = false,
    timeActive = 0.5,
    cast = function(self)
      if self.cd == self.cdFinal then
        self.cd = 0
        self.isActive = true
        self.timeActivated = 0
        if maze.ways[hero.y][hero.x+1] ~= -1 and maze.ways[hero.y][hero.x+1] < maze.ways[hero.y][hero.x] then 
          self.x, self.y = hero.x+1, hero.y
        elseif maze.ways[hero.y][hero.x-1] ~= -1 and maze.ways[hero.y][hero.x-1] < maze.ways[hero.y][hero.x] then 
          self.x, self.y = hero.x-1, hero.y
        elseif maze.ways[hero.y+1][hero.x] ~= -1 and maze.ways[hero.y+1][hero.x] < maze.ways[hero.y][hero.x] then 
          self.x, self.y = hero.x, hero.y+1
        elseif maze.ways[hero.y-1][hero.x] ~= -1 and maze.ways[hero.y-1][hero.x] < maze.ways[hero.y][hero.x] then 
          self.x, self.y = hero.x, hero.y-1
        else 
          self.x, self.y = hero.x, hero.y
        end
      end
    end
  }, 
  water = {
    charges = 0
  }, 
  earth = {
    cdFinal = 15,
    cd = 15,
    isActive = false,
    cast = function(self)
      if self.cd == self.cdFinal then
        self.cd = 0
        self.isActive = true
      end
    end
  }, 
  fire = {
    cdFinal = 10,
    cd = 10,
    x = 0,
    y = 0,
    light = light:newLight(0, 0, 0, 0, 0, 250),
    isActive = false,
    cast = function(self)
      if self.cd == self.cdFinal then
        self.cd = 0
        self.isActive = true
        self.light:setVisible(true)
        self.light:setPosition((hero.x+0.5)*clusterX, (hero.y+0.5)*clusterY)
        self.x = hero.x
        self.y = hero.y
      end
    end
  }, 
  light = {
    cdFinal = 15,
    cd = 15,
    isActive = false,
    stepsTaken = 8,
    stepsMax = 8,
    time = 0,
    souls = {},
    soulsL = {}, 
    cast = function(self)
      if self.cd == self.cdFinal then
        self.cd = 0
        self.isActive = true
        self.stepsTaken = 0
        self.souls = {}
        hero.x = tonumber(tostring(hero.x))
        hero.y = tonumber(tostring(hero.y))
        if maze[hero.y][hero.x+1] == maze.pass or maze[hero.y][hero.x+1] == maze.room then 
          if not self.souls[hero.x+1 .. ' ' .. hero.y] then
            self.soulsL[hero.x+1 .. ' ' .. hero.y] = light:newLight((hero.x+1.5)*clusterX, (hero.y)*clusterY, 255, 255, 255, 250) 
          end
          self.souls[hero.x+1 .. ' ' .. hero.y] = true 
        end
        if maze[hero.y][hero.x-1] == maze.pass or maze[hero.y][hero.x-1] == maze.room then 
          if not self.souls[hero.x-1 .. ' ' .. hero.y] then
            self.soulsL[hero.x-1 .. ' ' .. hero.y] = light:newLight((hero.x-0.5)*clusterX, (hero.y)*clusterY, 255, 255, 255, 250) 
          end
          self.souls[hero.x-1 .. ' ' .. hero.y] = true 
        end
        if maze[hero.y+1][hero.x] == maze.pass or maze[hero.y+1][hero.x] == maze.room then 
          if not self.souls[hero.x .. ' ' .. hero.y+1] then
            self.soulsL[hero.x .. ' ' .. hero.y+1] = light:newLight((hero.x)*clusterX, (hero.y+1.5)*clusterY, 255, 255, 255, 250) 
          end
          self.souls[hero.x .. ' ' .. hero.y+1] = true 
        end
        if maze[hero.y-1][hero.x] == maze.pass or maze[hero.y-1][hero.x] == maze.room then 
          if not self.souls[hero.x .. ' ' .. hero.y-1] then
            self.soulsL[hero.x .. ' ' .. hero.y-1] = light:newLight((hero.x)*clusterX, (hero.y-0.5)*clusterY, 255, 255, 255, 250) 
          end
          self.souls[hero.x .. ' ' .. hero.y-1] = true 
        end
      end
    end
    }, 
  darkness = {},
  update = function (self, dt)
    self.air.cd = self.air.cd >= self.air.cdFinal and self.air.cdFinal or self.air.cd + dt
    self.earth.cd = self.earth.cd >= self.earth.cdFinal and self.earth.cdFinal or self.earth.cd + dt
    self.fire.cd = self.fire.cd >= self.fire.cdFinal and self.fire.cdFinal or self.fire.cd + dt
    self.light.cd = self.light.cd >= self.light.cdFinal and self.light.cdFinal or self.light.cd + dt
    
    if self.air.cd > self.air.timeActive then self.air.isActive = false end
    
    if self.light.stepsTaken == self.light.stepsMax then 
      self.light.isActive = false 
      for key, val in pairs(self.light.soulsL) do
        light:remove(self.light.soulsL[key])
      end
    end
    
    if self.light.isActive then
      self.light.time = self.light.time + dt
      if self.light.time > 0.2 then 
        self.light.stepsTaken = self.light.stepsTaken + 1
        self.light.time = 0
        local T = {}
        for key, val in pairs(self.light.souls) do 
          T[key] = val
        end
        for key, _ in pairs(T) do
          local _, _, x, y = string.find(key, '(%d+) (%d+)')
          x, y = tonumber(x), tonumber(y)
          self.light.soulsL[key]:setVisible(false)
          if maze[y][x+1] == maze.pass or maze[y][x+1] == maze.room then 
            if not self.light.souls[x+1 .. ' ' .. y] then
              self.light.soulsL[x+1 .. ' ' .. y] = light:newLight((x+1.5)*clusterX, (y)*clusterY, 255, 255, 255, 250) 
            end
            self.light.souls[x+1 .. ' ' .. y] = true 
          end
          if maze[y][x-1] == maze.pass or maze[y][x-1] == maze.room then 
            if not self.light.souls[x-1 .. ' ' .. y] then
              self.light.soulsL[x-1 .. ' ' .. y] = light:newLight((x-0.5)*clusterX, (y)*clusterY, 255, 255, 255, 250) 
            end
            self.light.souls[x-1 .. ' ' .. y] = true 
          end
          if maze[y+1][x] == maze.pass or maze[y+1][x] == maze.room then 
            if not self.light.souls[x .. ' ' .. y+1] then
              self.light.soulsL[x .. ' ' .. y+1] = light:newLight((x)*clusterX, (y+1.5)*clusterY, 255, 255, 255, 250) 
            end
            self.light.souls[x .. ' ' .. y+1] = true 
          end
          if maze[y-1][x] == maze.pass or maze[y-1][x] == maze.room then 
            if not self.light.souls[x .. ' ' .. y-1] then
              self.light.soulsL[x .. ' ' .. y-1] = light:newLight((x)*clusterX, (y-0.5)*clusterY, 255, 255, 255, 250) 
            end
            self.light.souls[x .. ' ' .. y-1] = true 
          end
        end
      end
    end
  end
}
magic.fire.light:setColor(255, 64, 0)

return magic