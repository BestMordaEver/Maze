love.window.setMode(0, 0, {fullscreen = true})
width, height = love.window.getMode()

local a = love.filesystem.load('camera.lua')
camera = a()
print('camera done')

cluster = 32

a = love.filesystem.load('maze.lua')
maze = a()
maze:new(57, 31)
maze:Generate()
print('maze generated')

maze.canvas = love.graphics.newCanvas((maze.width+1)*cluster, (maze.height+1)*cluster)
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
print('maze drawn')

entity = love.filesystem.load('entity.lua')
E = {}

hero = entity()
hero:new(2, 2, 'man', 'idle')

camera:setPosition((hero.x - maze.width/2)*cluster, (hero.y - maze.height/2)*cluster)
print('hero done')

drawing = love.filesystem.load('drawing.lua')
keys = love.filesystem.load('keys.lua')
updates = love.filesystem.load('updates.lua')