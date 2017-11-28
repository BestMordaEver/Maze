local magic = {
  air = {
    cdFinal = 10,
    cd = 10,
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
    cdFinal = 20,
    cd = 20,
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
    isActive = false
  }, 
  light = {
    cdFinal = 10,
    cd = 10,
    }, 
  darkness = {},
  update = function (self, dt)
    print(self.earth.isActive)
    self.air.cd = self.air.cd >= self.air.cdFinal and self.air.cdFinal or self.air.cd + dt
    self.earth.cd = self.earth.cd >= self.earth.cdFinal and self.earth.cdFinal or self.earth.cd + dt
    self.fire.cd = self.fire.cd >= self.fire.cdFinal and self.fire.cdFinal or self.fire.cd + dt
    self.light.cd = self.light.cd >= self.light.cdFinal and self.light.cdFinal or self.light.cd + dt
    
    if self.air.cd > self.air.timeActive then self.air.isActive = false end
    if maze[hero.y][hero.x] == maze.wall then self.earth.isActive = false end
  end
  }

return magic