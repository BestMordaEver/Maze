love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

camera = dofile('camera.lua')

clusterX = 45
clusterY = 45
time = 0

widthRange = math.floor(width/clusterX/2+2) -- This is how much game has to draw
heightRange = math.floor(height/clusterY/2+2) -- so it will fit the monitor

maze = dofile('maze.lua')
maze:new(57, 35)
maze:Generate()
maze:mapWays()

entity = loadfile('entity.lua')
E = {}
dofile('hero.lua')
shadow = loadfile('shadow.lua')
S = {}

for i=1, math.floor((maze.width * maze.height) / 80) do
  shadow()
  S[i]:ready()
end

update = dofile('update.lua')
keypressed = dofile('keypressed.lua')
draw = dofile('draw.lua')