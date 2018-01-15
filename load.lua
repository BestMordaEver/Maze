--love.window.setMode(800, 600, {fullscreen = false})
love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

light = Light({ambient = {0, 0, 0}})

camera = love.filesystem.load('camera.lua')()
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
time = 0

widthRange = math.floor(width/cluster.x/2+1) -- This is how much game has to draw
heightRange = math.floor(height/cluster.y/2+1) -- so it will fit the monitor

maze = love.filesystem.load('maze.lua')()
maze:new(51, 51)
maze:Generate()
maze:mapWays()
maze:decorate()
entity = love.filesystem.load('entity.lua')
E = {}
love.filesystem.load('hero.lua')()
magic = love.filesystem.load('magic.lua')()
shadow = love.filesystem.load('shadow.lua')
S = {}
watchlist, watchdogs = {}, {up = 20, down = 20, left = 20, right = 20, inside = 0}
function watchdogs:set()
  self.up, self.down, self.left, self.right = 20, 20, 20, 20
end
shadowTime = 0

for i=1, maze.roomCount do
  shadow()
  if S[i] == nil then break end
end

update = love.filesystem.load('update.lua')()
keypressed = love.filesystem.load('keypressed.lua')()
draw = love.filesystem.load('draw.lua')
drawinterface = love.filesystem.load('drawinterface.lua')
keyPreset = love.filesystem.load('keypresets.lua')()
keyPreset:wasd()