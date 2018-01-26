light = Light({ambient = {0, 0, 0}})

camera = love.filesystem.load('camera.lua')()
cluster = {}
cluster.x = 64
cluster.y = 64
cluster.s = 1
cluster.max = 1
cluster.min = 0.6
flip = true
time = 0

widthRange = math.floor(width/cluster.x/2/cluster.min+1) -- This is how much game has to draw
heightRange = math.floor(height/cluster.y/2/cluster.min+1) -- so it will fit the monitor

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
shadowTime = 0

for i=1, maze.roomCount do
  shadow()
  if S[i] == nil then break end
end
