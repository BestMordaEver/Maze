--love.window.setMode(800, 600, {fullscreen = false})
love.window.setMode(0, 0, {fullscreen = true})
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