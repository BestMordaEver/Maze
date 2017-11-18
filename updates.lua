for i, e in pairs(E) do 
	e.animation:wait(t)
end 

local lvX, lvY = 0, 0
--[[
if love.keyboard.isDown('down') then lvY = 1 end 
if love.keyboard.isDown('up') then lvY = lvY - 1 end 
if love.keyboard.isDown('right') then lvX = 1 end 
if love.keyboard.isDown('left') then lvX = lvX - 1 end 

hero:tryMovement(lvX, lvY, maze)
]] -- push to move

camera:setPosition((hero.x+1)*clusterX - love.graphics.getWidth()/2, (hero.y+1)*clusterY - love.graphics.getHeight()/2)