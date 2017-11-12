love.window.setMode(0, 0, {fullscreen = true})
width, height = love.window.getMode()

local a = love.filesystem.load('camera.lua')
camera = a()

cluster = 32

widthRange = math.floor(width / cluster / 2 + 2) -- This is how much game has to draw
heightRange = math.floor(height / cluster / 2 + 2) -- so it will fit the monitor

a = love.filesystem.load('maze.lua')
maze = a()
maze:new(51, 51)
maze:Generate()

maze.canvas = love.graphics.newCanvas(maze.width, maze.height)
love.graphics.setCanvas(maze.canvas)
  love.graphics.clear()
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(255,255,255)
  for i=1,maze.height do
    for j=1,maze.width do
      if maze[i][j] == maze.wall then 
        love.graphics.rectangle('fill', j*cluster, i*cluster, cluster, cluster)
        end
    end
  end
love.graphics.setCanvas()
--camera:setPosition(maze.width/2, maze.height/2)

entity = love.filesystem.load('entity.lua')
E = {}

hero = entity()
hero:new(2*cluster, 2*cluster, 'man', 'idle')

drawing = love.filesystem.load('drawing.lua')
keys = love.filesystem.load('keys.lua')
updates = love.filesystem.load('updates.lua')