love.window.setMode(0, 0, {fullscreen = false})
width, height = love.window.getMode()

local a = love.filesystem.load('camera.lua')
camera = a()

clusterX = 45
clusterY = 45

widthRange = math.floor(width/clusterX/2+2) -- This is how much game has to draw
heightRange = math.floor(height/clusterY/2+2) -- so it will fit the monitor

a = love.filesystem.load('maze.lua')
maze = a()
maze:new(57, 31)
maze:Generate()

entity = love.filesystem.load('entity.lua')
E = {}

hero = entity()
hero:new(2, 2, 'man', 'idle')
hero.animation:newAnimation('idle', 1)
hero.animation:addFrame('idle', 'Men/MatveyIdle1.png')
hero.animation:setAnimation('idle')

drawing = love.filesystem.load('drawing.lua')
keys = love.filesystem.load('keys.lua')
updates = love.filesystem.load('updates.lua')