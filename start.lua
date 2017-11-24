love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

local a = love.filesystem.load('camera.lua')
camera = a()

clusterX = 45
clusterY = 45
time = 0

widthRange = math.floor(width/clusterX/2+2) -- This is how much game has to draw
heightRange = math.floor(height/clusterY/2+2) -- so it will fit the monitor

a = love.filesystem.load('maze.lua')
maze = a()
maze:new(57, 35)
maze:Generate()
maze:mapWays()

entity = love.filesystem.load('entity.lua')
E = {}
shadow = love.filesystem.load('shadow.lua')
S = {}

shadows = {}
for i=1, math.floor((maze.width * maze.height) / 80) do
  shadow()
  S[i]:ready()
end

hero = entity()
hero:new(maze.ways.x, maze.ways.y, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')
function hero:tryMovement(x, y)
  local shit = maze[self.y + y][self.x + x]
  if shit == maze.wall then
    return false
  elseif shit == maze.pass then
    self:moveRel(x, y)
  elseif shit == maze.room then
    self:moveRel(x, y)
  elseif shit == maze.exit then
    love.event.quit()
  end
  return true
end

drawing = love.filesystem.load('drawing.lua')
keys = love.filesystem.load('keys.lua')
updates = love.filesystem.load('updates.lua')