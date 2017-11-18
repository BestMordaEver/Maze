love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

local a = love.filesystem.load('camera.lua')
camera = a()

clusterX = 45
clusterY = 45

a = love.filesystem.load('maze.lua')
maze = a()
maze:new(57, 31)
maze:Generate()

maze.canvas = love.graphics.newCanvas((maze.width+1)*clusterX, (maze.height+1)*clusterY)
love.graphics.setCanvas(maze.canvas)
  love.graphics.clear()
  love.graphics.setBlendMode('alpha')
  love.graphics.setColor(255,255,255)
  for i=1,maze.height do
    for j=1,maze.width do
      if maze[i][j] == maze.wall then 
        love.graphics.rectangle('fill', j*clusterX, i*clusterY, clusterX, clusterY)
        end
    end
  end
love.graphics.setCanvas()

entity = love.filesystem.load('entity.lua')
E = {}

hero = entity()
hero:new(2, 2, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')

camera:setPosition((hero.x - maze.width/2)*clusterX, (hero.y - maze.height/2)*clusterY)

drawing = love.filesystem.load('drawing.lua')
keys = love.filesystem.load('keys.lua')
updates = love.filesystem.load('updates.lua')