--love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

light = Light({ambient = {0, 0, 0}, 
  refractionStrength = 0,
  reflectionStrength = 0,
  reflectionVisibility = 0,
  shadowblur = 0.2,
  glowBlur = 1})

camera = love.filesystem.load('camera.lua')()
print('camera ok')
clusterX = 45
clusterY = 45
flip = true

widthRange = math.floor(width/clusterX/2+2) -- This is how much game has to draw
heightRange = math.floor(height/clusterY/2+2) -- so it will fit the monitor

maze = love.filesystem.load('maze.lua')()
maze:new(51, 51)
maze:Generate()
print('maze ok')
maze:mapWays()
print('map ok')

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

update = love.filesystem.load('update.lua')(dt)
keypressed = love.filesystem.load('keypressed.lua')(key)
draw = love.filesystem.load('draw.lua')
