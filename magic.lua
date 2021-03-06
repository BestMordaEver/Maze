local magic = {
  air = {
    cdFinal = 7,
    cd = 7,
    x = 0,
    y = 0,
    isActive = false,
    timeActive = 0.5,
    cast = function(self)
      if self.cd == self.cdFinal and not magic.darkness.isActive then
        self.cd = 0
        self.isActive = true
        self.timeActivated = 0
        local x = math.floor(hero.x)
        local y = math.floor(hero.y)
        if Maze.ways[y*Maze.width + x+1] ~= -1 and Maze.ways[y*Maze.width + x+1] < Maze.ways[y*Maze.width + x] then 
          self.x, self.y = x+1, y
        elseif Maze.ways[y*Maze.width + x-1] ~= -1 and Maze.ways[y*Maze.width + x-1] < Maze.ways[y*Maze.width + x] then 
          self.x, self.y = x-1, y
        elseif Maze.ways[(y+1)*Maze.width + x] ~= -1 and Maze.ways[(y+1)*Maze.width + x] < Maze.ways[y*Maze.width + x] then 
          self.x, self.y = x, y+1
        elseif Maze.ways[(y-1)*Maze.width + x] ~= -1 and Maze.ways[(y-1)*Maze.width + x] < Maze.ways[y*Maze.width + x] then 
          self.x, self.y = x, y-1
        else 
          self.x, self.y = x, y
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
      if self.cd == self.cdFinal and not magic.darkness.isActive then
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
    isActive = false,
    timeActive = 10, 
    cast = function(self)
      local _, x = math.modf(hero.x)
      local _, y = math.modf(hero.y)
      if self.cd == self.cdFinal and not magic.darkness.isActive and x == 0 and y == 0 then
        self.cd = 0
        self.isActive = true
        self.x = hero.x
        self.y = hero.y
      end
    end
  }, 
  light = {
    cdFinal = 25,
    cd = 25,
    isActive = false,
    stepsTaken = 15,
    stepsMax = 15,
    time = 0,
    souls = {},
    soulsL = {}, 
    cast = function(self)
      if self.cd == self.cdFinal and not magic.darkness.isActive then
        magic.darkness.bad = magic.darkness.bad > 0.8 and 1 or magic.darkness.bad + 0.2
        self.cd = 0
        self.isActive = true
        self.stepsTaken = 0
        self.souls = {}
        local x = math.floor(hero.x)
        local y = math.floor(hero.y)
        if Maze.content[y*Maze.width + x+1] >= Maze.pass then 
          if not self.souls[x+1 .. ' ' .. y] then
            --self.soulsL[x+1 .. ' ' .. y] = light:newLight((x+1.5)*cluster.x, (y)*cluster.y, 255, 255, 255, 250) 
          end
          self.souls[x+1 .. ' ' .. y] = true 
        end
        if Maze.content[y*Maze.width + x-1] >= Maze.pass then 
          if not self.souls[x-1 .. ' ' .. y] then
            --self.soulsL[x-1 .. ' ' .. y] = light:newLight((x-0.5)*cluster.x, (y)*cluster.y, 255, 255, 255, 250) 
          end
          self.souls[x-1 .. ' ' .. y] = true 
        end
        if Maze.content[(y+1)*Maze.width + x] >= Maze.pass then 
          if not self.souls[x .. ' ' .. y+1] then
            --self.soulsL[x .. ' ' .. y+1] = light:newLight((x)*cluster.x, (y+1.5)*cluster.y, 255, 255, 255, 250) 
          end
          self.souls[x .. ' ' .. y+1] = true 
        end
        if Maze.content[(y-1)*Maze.width + x] >= Maze.pass then 
          if not self.souls[x .. ' ' .. y-1] then
            --self.soulsL[x .. ' ' .. y-1] = light:newLight((x)*cluster.x, (y-0.5)*cluster.y, 255, 255, 255, 250) 
          end
          self.souls[x .. ' ' .. y-1] = true 
        end
      end
    end
    }, 
  darkness = {
    bad = 1,
    isActive = false,
    cast = function(self)
      self.isActive = not self.isActive
    end
  },
  update = function (self, dt)
    self.air.cd = self.air.cd >= self.air.cdFinal and self.air.cdFinal or self.air.cd + dt
    self.earth.cd = self.earth.cd >= self.earth.cdFinal and self.earth.cdFinal or self.earth.cd + dt
    self.fire.cd = self.fire.cd >= self.fire.cdFinal and self.fire.cdFinal or self.fire.cd + dt
    self.light.cd = self.light.cd >= self.light.cdFinal and self.light.cdFinal or self.light.cd + dt
    
    if self.air.cd > self.air.timeActive then self.air.isActive = false end
    if self.fire.cd > self.fire.timeActive then self.fire.isActive = false end
    
    if self.darkness.isActive then 
      self.darkness.bad = self.darkness.bad > 0 and self.darkness.bad - dt/10 or 0
    end
    
    if self.darkness.bad < 1 then 
      if Maze.content[hero.y*Maze.width + hero.x] == Maze.room or (self.fire.x == hero.x and self.fire.y == hero.y) then
        self.darkness.bad = self.darkness.bad + dt/20 
      else
        self.darkness.bad = self.darkness.bad + dt/80
      end
    end
    
    if self.light.stepsTaken == self.light.stepsMax then 
      self.light.isActive = false 
      for key, _ in pairs(self.light.soulsL) do
        --light:remove(self.light.soulsL[key])
      end
    end
    
    if self.light.isActive then
      self.light.time = self.light.time + dt
      if self.light.time > 0.1 then 
        self.light.stepsTaken = self.light.stepsTaken + 1
        self.light.time = 0
        local T = {}
        for key, val in pairs(self.light.souls) do 
          T[key] = val
        end
        for key, _ in pairs(T) do
          local _, _, x, y = string.find(key, '(%d+) (%d+)')
          x, y = tonumber(x), tonumber(y)
          if Maze.content[y*Maze.width + x+1] >= Maze.pass then 
            if not self.light.souls[x+1 .. ' ' .. y] then
              --self.light.soulsL[x+1 .. ' ' .. y] = light:newLight((x+1.5)*cluster.x, (y)*cluster.y, 128, 128, 128, 250) 
            end
            self.light.souls[x+1 .. ' ' .. y] = true 
          end
          if Maze.content[y*Maze.width + x-1] >= Maze.pass then 
            if not self.light.souls[x-1 .. ' ' .. y] then
              --self.light.soulsL[x-1 .. ' ' .. y] = light:newLight((x-0.5)*cluster.x, (y)*cluster.y, 128, 128, 128, 250) 
            end
            self.light.souls[x-1 .. ' ' .. y] = true 
          end
          if Maze.content[(y+1)*Maze.width + x] >= Maze.pass then 
            if not self.light.souls[x .. ' ' .. y+1] then
              --self.light.soulsL[x .. ' ' .. y+1] = light:newLight((x)*cluster.x, (y+1.5)*cluster.y, 128, 128, 128, 250) 
            end
            self.light.souls[x .. ' ' .. y+1] = true 
          end
          if Maze.content[(y-1)*Maze.width + x] >= Maze.pass then 
            if not self.light.souls[x .. ' ' .. y-1] then
              --self.light.soulsL[x .. ' ' .. y-1] = light:newLight((x)*cluster.x, (y-0.5)*cluster.y, 128, 128, 128, 250) 
            end
            self.light.souls[x .. ' ' .. y-1] = true 
          end
        end
      end
    end
  end,

  new = function (self)
    self.air.cd, self.air.x, self.air.y, self.air.isActive = self.air.cdFinal, 0, 0, false
    self.water.charges = 0
    self.earth.cd, self.earth.isActive = self.earth.cdFinal, false
    self.fire.cd, self.fire.x, self.fire.y, self.fire.isActive = self.fire.cdFinal, 0, 0, false
    self.light.cd, self.light.isActive, self.light.stepsTaken = self.light.cdFinal, false, self.light.stepsMax
    self.light.time, self.light.souls, self.light.soulsL = 0, {}, {}
    self.darkness.bad, self.darkness.isActive = 1, false
  end
}

return magic