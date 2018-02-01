Light = require 'Light' -- God bless this man

love.window.setMode(800, 600, {fullscreen = false})
--love.window.setMode(0, 0, {fullscreen = true})
width, height = love.window.getMode()

B = {}
button = love.filesystem.load('button.lua')()

ingameLoad = love.filesystem.load('ingame/load.lua')
ingameUpdate = love.filesystem.load('ingame/update.lua')()
ingameKeypressed = love.filesystem.load('ingame/keypressed.lua')()
ingameDraw = love.filesystem.load('ingame/draw.lua')
mainmenuLoad = love.filesystem.load('mainmenu/load.lua')
mainmenuUpdate = love.filesystem.load('mainmenu/update.lua')()
mainmenuKeypressed = love.filesystem.load('mainmenu/keypressed.lua')()
mainmenuDraw = love.filesystem.load('mainmenu/draw.lua')
pauseLoad = love.filesystem.load('pause/load.lua')
pauseUpdate = love.filesystem.load('pause/update.lua')()
pauseKeypressed = love.filesystem.load('pause/keypressed.lua')()
pauseDraw = love.filesystem.load('pause/draw.lua')
drawinterface = love.filesystem.load('drawinterface.lua')
keyPreset = love.filesystem.load('keypresets.lua')()
keyPreset:wasd()
gameState = 'mainmenu'

camera = love.filesystem.load('camera.lua')()
cluster = {}
cluster.x = 64
cluster.y = 64
cluster.s = 1
cluster.max = 1
cluster.min = 0.6

widthRange = math.floor(width/cluster.x/2/cluster.min+1) -- This is how much game has to draw
heightRange = math.floor(height/cluster.y/2/cluster.min+1) -- so it will fit the monitor
maze = love.filesystem.load('maze.lua')()
light = Light({ambient = {0, 0, 0}})
entity = love.filesystem.load('entity.lua')
magic = love.filesystem.load('magic.lua')()
shadow = love.filesystem.load('shadow.lua')
