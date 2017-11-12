for i, e in pairs(E) do 
	e.animation:Wait(t)
end 

local lvX, lvY = 0, 0

if love.keyboard.isDown('down') then lvY = 2 end 
if love.keyboard.isDown('up') then lvY = lvY - 2 end 
if love.keyboard.isDown('right') then lvX = 2 end 
if love.keyboard.isDown('left') then lvX = lvX - 2 end 

--camera:setPosition((hero.x+0.5) - width/2 + cluster/2, (hero.y+0.5) - height/2 + cluster/2)