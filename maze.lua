Maze = {height, width, exitX = 0, exitY = 0, roomCount = 0,
  wall = 0, chestUsed = 1, exit = 2, chest = 3,  -- collision
  pass = 4, room = 5, key = 6, decoKey = 7, -- no collision
  __call = function(self, x, y, val) 
    if val then 
      self[y*Maze.width + x] = val
    else
      return self[y*Maze.width + x] 
    end
  end,
  visibility = {}, content = setmetatable({}, Maze), ways = {},

  ended = function () 
    for i = 2, Maze.height - 1, 2 do 
      for j = 2, Maze.width - 1, 2 do
        if Maze.content(i, j) == Maze.wall then return false end 
      end
    end
    return true
  end, 

  deadend = function (x,y)
    return (x == Maze.width - 1 or Maze.content(x + 2, y) ~= Maze.wall) and
    (y == Maze.height - 1 or Maze.content(x, y + 2) ~= Maze.wall) and
    (x == 2 or Maze.content(x - 2, y) ~= Maze.wall) and
    (y == 2 or Maze.content(x, y - 2) ~= Maze.wall)
  end,

  generate = function (width, height)
    Maze.width = width 
    Maze.height = height
    Maze.exitX = 0
    Maze.exitY = 0
    Maze.roomCount = 0

    for i=1, Maze.height do
      for j=1, Maze.width do
        Maze.content(i, j, Maze.wall)
        Maze.visibility(i, j, false)
        Maze.ways(i, j, 0)
      end
    end

    local x,y

    local roomCount = math.floor(math.sqrt(Maze.width * Maze.height))
    local check = 0

    for l = 1, roomCount do -- Room pre-generation routine
      repeat -- Basically - they must generate before Maze
        local rHeight, rWidth = 2 * love.math.random(1, 2), 2 * love.math.random(1, 2)
        local b = true

        repeat -- Choose the center point of room
          x = 2*love.math.random(1, (Maze.width - 1)/2) + 2
          x = rWidth == 4 and x or x + 1
          y = 2*love.math.random(1, (Maze.height - 1)/2) + 2
          y = rHeight == 4 and y or y + 1
          check = check + 1
        until not (x < rWidth + 2 or x > Maze.width - rWidth - 2 or y < rHeight + 2 or y > Maze.height - rHeight - 2) or check > 10000

        check = check + 1
        if check > 10000 then break end -- In case shit happens 

        for i = y - rHeight/2 - 2, y + rHeight/2 + 2 do -- Check for touching another rooms
          for j = x - rWidth/2 - 2, x + rWidth/2 + 2  do 
            if Maze.content(j, i) == Maze.room then 
              i = y + rHeight/2
              j = x + rWidth/2
              b = false
            end 
          end 
        end 

        if b then -- If we didn`t touch room - this happens
          for i = y - rHeight/2, y + rHeight/2 do 
            for j = x - rWidth/2, x + rWidth/2 do 
              Maze.content(j, i, Maze.room)
            end 
          end 
          Maze.content(x, y, Maze.chest)

          b = love.math.random(0, 3) -- Exit position
          if b == 0 then 
            Maze.content(x - rWidth/2 + 2*(love.math.random(1, rWidth/2)), y + rHeight/2 + 1, Maze.room)
          elseif b == 1 then 
            Maze.content(x - rWidth/2 + 2*(love.math.random(1, rWidth/2)), y - rHeight/2 - 1, Maze.room)
          elseif b == 2 then 
            Maze.content(x + rWidth/2 + 1, y - rHeight/2 + 2*(love.math.random(1, rHeight/2)), Maze.room)
          elseif b == 3 then 
            Maze.content(x - rWidth/2 - 1, y - rHeight/2 + 2*(love.math.random(1, rHeight/2)), Maze.room)
          end

          Maze.roomCount = Maze.roomCount + 1
        end 
      until b
    end 

    x, y, check = 2, 2, 0
    local direction = 0
    Maze.content(x, y, Maze.pass) -- Droppin`

    repeat -- Main cycle

      direction = love.math.random(0,3)
      -- Jumpin`
      if direction == 0 and x ~= Maze.width - 1 and Maze.content(x+2, y) ~= Maze.room and Maze.content(x+2, y) ~= Maze.pass then 
        Maze.content(x+1, y, Maze.pass)
        x = x + 2 
      elseif direction == 1 and x ~= 2 and Maze.content(x-2, y) ~= Maze.room and Maze.content(x-2, y) ~= Maze.pass then 
        Maze.content(x-1, y, Maze.pass)
        x = x - 2 
      elseif direction == 2 and y ~= Maze.height - 1 and Maze.content(x, y+2) ~= Maze.room and Maze.content(x, y+2) ~= Maze.pass then 
        Maze.content(x, y+1, Maze.pass)
        y = y + 2
      elseif direction == 3 and y ~= 2 and Maze.content(x, y-2) ~= Maze.room and Maze.content(x, y-2) ~= Maze.pass then 
        Maze.content(x, y-1, Maze.pass)
        y = y - 2
      end

      Maze.content(x, y, Maze.pass)  -- Diggin`

      if Maze.deadend(x,y) then -- Gettin` dafuq outta here
        repeat	
          x = 2 * love.math.random(1, (Maze.width - 1) / 2)
          y = 2 * love.math.random(1, (Maze.height - 1) / 2)
        until Maze.content(x, y) == Maze.pass
      end

      check = check + 1
    until check%1000 == 0 and Maze.ended()
    
    -- Here is end
    if direction == 0 then
      Maze.exitX = Maze.width
      Maze.exitY = 2 * love.math.random(1, (Maze.height - 1) / 2)
    elseif direction == 1 then
      Maze.exitX = 1
      Maze.exitY = 2 * love.math.random(1, (Maze.height - 1) / 2)
    elseif direction == 2 then
      Maze.exitX = 2 * love.math.random(1, (Maze.width - 1) / 2)
      Maze.exitY = Maze.height
    elseif direction == 3 then 
      Maze.exitX = 2 * love.math.random(1, (Maze.width - 1) / 2)
      Maze.exitY = 1
    end

    Maze.content(Maze.exitX, Maze.exitY, Maze.exit)
  end,

  mapWays = function ()
    for i = 1, Maze.height do 
      for j = 1, Maze.width do
        if Maze.content(j, i) == Maze.pass or Maze.content(j, i) == Maze.room then
          Maze.ways(j, i, 0)
        else
          Maze.ways(j, i, -1)
        end
      end
    end

    local W = {}
    W[1] = {}
    if Maze.exitX == Maze.width then 
      W[1].x = Maze.exitX - 1
    elseif Maze.exitX == 1 then
      W[1].x = 2
    else
      W[1].x = Maze.exitX
    end

    if Maze.exitY == Maze.height then 
      W[1].y = Maze.exitY - 1
    elseif Maze.exitY == 1 then
      W[1].y = 2
    else
      W[1].y = Maze.exitY
    end
    W[1].c = 1

    repeat
      for key, val in pairs(W) do
        Maze.ways(val.x, val.y, val.c)
        if Maze.ways(val.x+1, val.y) == 0 then table.insert(W, {y = val.y, x = val.x+1, c = val.c+1}) end
        if Maze.ways(val.x-1, val.y) == 0 then table.insert(W, {y = val.y, x = val.x-1, c = val.c+1}) end
        if Maze.ways(val.x, val.y+1) == 0 then table.insert(W, {y = val.y+1, x = val.x, c = val.c+1}) end
        if Maze.ways(val.x, val.y-1) == 0 then table.insert(W, {y = val.y-1, x = val.x, c = val.c+1}) end
        Maze.ways.max = val.c
        Maze.ways.x = val.x
        Maze.ways.y = val.y
        table.remove(W, key)
      end
    until #W == 0
  end,

  findAbsolute = function (x1, y1, x2, y2)
    x1 = math.modf(x1)
    y1 = math.modf(y1)
    x2 = math.modf(x2)
    y2 = math.modf(y2)
    if (x1 == x2 and y1 == y2) or Maze.content(x2, y2) == Maze.wall then return 0, 'inside' end
    local steps, count = 0, 0

    local A, B, dir = {}, {}, ''
    B[1] = {x = x1, y = y1, c = 0}

    repeat
      for _, val in pairs(B) do
        if count > 10000 then return 0, 'inside' end
        x1, y1 = val.x, val.y
        if x1 == x2 and y1 == y2 then break end
        if x1+1 == x2 and y1 == y2 then dir = 'left' end
        if x1-1 == x2 and y1 == y2 then dir = 'right' end
        if x1 == x2 and y1+1 == y2 then dir = 'up' end
        if x1 == x2 and y1-1 == y2 then dir = 'down' end

        A[y1*Maze.width + x1] = val.c
        steps = val.c + 1
        count = count + 1
        if not A[y1*Maze.width + x1+1] and Maze.ways[y1*Maze.width + x1+1] ~= -1 then 
          table.insert(B, {x = x1+1, y = y1, c = val.c+1}) 
        end
        if not A[y1*Maze.width + x1-1] and Maze.ways[y1*Maze.width + x1-1] ~= -1 then 
          table.insert(B, {x = x1-1, y = y1, c = val.c+1}) 
        end
        if not A[(y1+1)*Maze.width + x1] and Maze.ways[(y1+1)*Maze.width + x1] ~= -1 then 
          table.insert(B, {x = x1, y = y1+1, c = val.c+1}) 
        end
        if not A[(y1-1)*Maze.width + x1] and Maze.ways[(y1-1)*Maze.width + x1] ~= -1 then 
          table.insert(B, {x = x1, y = y1-1, c = val.c+1}) 
        end
      end
    until x1 == x2 and y1 == y2

    return steps, dir
  end,

  update = function ()
    for i=1, Maze.height do
      for j=1, Maze.width do
        Maze.visibility[i*Maze.width + j] = false
      end
    end

    local x,y = math.floor(hero.x),math.floor(hero.y)
    Maze.visibility[y*Maze.width + x] = true

    repeat
      y = y + 1
      Maze.visibility[y*Maze.width + x - 1] = true
      Maze.visibility[y*Maze.width + x] = true
      Maze.visibility[y*Maze.width + x + 1] = true
    until Maze.content[y*Maze.width + x] == Maze.wall

    x,y = math.floor(hero.x),math.floor(hero.y)
    repeat
      y = y - 1
      Maze.visibility[y*Maze.width + x - 1] = true
      Maze.visibility[y*Maze.width + x] = true
      Maze.visibility[y*Maze.width + x + 1] = true
    until Maze.content[y*Maze.width + x] == Maze.wall
    x,y = math.floor(hero.x),math.floor(hero.y)

    repeat
      x = x + 1
      Maze.visibility[(y-1)*Maze.width + x] = true
      Maze.visibility[y*Maze.width + x] = true
      Maze.visibility[(y+1)*Maze.width + x] = true
    until Maze.content[y*Maze.width + x] == Maze.wall
    x,y = math.floor(hero.x),math.floor(hero.y)

    repeat
      x = x - 1
      Maze.visibility[(y-1)*Maze.width + x] = true
      Maze.visibility[y*Maze.width + x] = true
      Maze.visibility[(y+1)*Maze.width + x] = true
    until Maze.content[y*Maze.width + x] == Maze.wall
  end
}

setmetatable(Maze.content, Maze)
setmetatable(Maze.ways, Maze)
setmetatable(Maze.visibility, Maze)