for i = -heightRange + math.floor(hero.y) < 1 and 1 or -heightRange + math.floor(hero.y), heightRange + math.floor(hero.y) do
	if i == maze.height + 1 then break end -- We draw only these, who fit in screen 
	for j = -widthRange + math.floor(hero.x) < 1 and 1 or -widthRange + math.floor(hero.x), widthRange + math.floor(hero.x) do
		if j == maze.width + 1 then break end 
    local shit = maze.content[i*maze.width + j]
    if shit == maze.wall then 
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
    elseif shit == maze.chest then
      love.graphics.setColor(196, 75, 0)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
    elseif shit == maze.chestUsed then
      love.graphics.setColor(196, 75, 0)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      love.graphics.setColor(0, 0, 0)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y+cluster.y/3, cluster.x, cluster.y/10)
    elseif shit == maze.key then
      love.graphics.setColor(0, 128, 196)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
    elseif shit == maze.decoKey then
      love.graphics.setColor(0, 64, 128)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
    elseif shit == maze.pass or shit == maze.room then 
      love.graphics.setColor(64, 64, 64)
      love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
    end
  end
end

--hero:draw()
if magic.earth.isActive then 
  love.graphics.setColor(0, 255, 0) 
elseif magic.darkness.isActive then 
  love.graphics.setColor(128, 0, 128)
else love.graphics.setColor(0, 255, 255) end
love.graphics.rectangle('fill', hero.x*cluster.x + cluster.x/4, hero.y*cluster.y + cluster.y/4, cluster.x/2, cluster.y/2)

love.graphics.setColor(128, 0, 128, 196)
for _, shad in pairs(S) do
  love.graphics.rectangle('fill', shad.x*cluster.x, shad.y*cluster.y, cluster.x, cluster.y)
  --shad:draw()
end

if magic.air.isActive then 
  love.graphics.setColor(0, 255, 255)
  love.graphics.rectangle('fill', magic.air.x*cluster.x, magic.air.y*cluster.y, cluster.x, cluster.y)
end

if magic.fire.isActive then
  love.graphics.setColor(255, 128, 0, 128)
  love.graphics.rectangle('fill', magic.fire.x*cluster.x, magic.fire.y*cluster.y, cluster.x, cluster.y)
end

if magic.light.isActive then
  love.graphics.setColor(255, 255, 255, 128)
  for key, _ in pairs(magic.light.souls) do
    --local _, _, x, y = key:find('(%d+) (%d+)')
    --x, y = tonumber(x), tonumber(y)
    --love.graphics.rectangle('fill', x*cluster.x, y*cluster.y, cluster.x, cluster.y)
  end  

end