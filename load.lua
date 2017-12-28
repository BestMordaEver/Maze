love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

light = Light({ambient = {0, 0, 0}})

camera = love.filesystem.load('camera.lua')()
print('camera ok')
cluster = {}
cluster.x = 45
cluster.y = 45
cluster.xScale = 1
cluster.yScale = 1
cluster.maxX = 1
cluster.maxY = 1
cluster.minX = 0.6
cluster.minY = 0.6
flip = true
<<<<<<< HEAD
love.graphics.scale(0.5, 0.5)
=======
time = 0
>>>>>>> 4da3496c116f3cad7735671197461f5aaf4e6db9

widthRange = math.floor(width/cluster.x/2+1) -- This is how much game has to draw
heightRange = math.floor(height/cluster.y/2+1) -- so it will fit the monitor
time = 0

maze = love.filesystem.load('maze.lua')()
maze:new(101, 101)
maze:Generate()
print('maze ok')
maze:mapWays()
print('map ok')
maze:decorate()

entity = love.filesystem.load('entity.lua')
E = {}
print('entity ok')
love.filesystem.load('hero.lua')()
print('hero ok')
magic = love.filesystem.load('magic.lua')()
shadow = love.filesystem.load('shadow.lua')
S = {}

for i=1, maze.roomCount do
  shadow()
  if S[i] == nil then break end
end
print('shitheads ok')

update = love.filesystem.load('update.lua')()
keypressed = love.filesystem.load('keypressed.lua')()
draw = love.filesystem.load('draw.lua')
