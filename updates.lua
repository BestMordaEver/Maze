for i, e in pairs(E) do 
	e.animation:Wait(t)
end 

local lvX, lvY = 0, 0
--[[
if love.keyboard.isDown('down') then lvY = 1 end 
if love.keyboard.isDown('up') then lvY = lvY - 1 end 
if love.keyboard.isDown('right') then lvX = 1 end 
if love.keyboard.isDown('left') then lvX = lvX - 1 end 

hero:tryMovement(lvX, lvY, maze)
]] -- push to move

camera:setPosition((hero.x - maze.width/2)*cluster, (hero.y - maze.height/2)*cluster)