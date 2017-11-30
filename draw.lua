love.graphics.setColor(255,255,255)

for i = -heightRange + hero.y, heightRange + hero.y do-- We draw only these, who fit in screen  
	i = i < 1 and 1 or i
	if i == maze.height + 1 then break end
	for j = -widthRange + hero.x, widthRange + hero.x  do
		j = j < 1 and 1 or j
		if j == maze.width + 1 then break end 
    if maze[i][j] == maze.wall then 
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle('fill', j*clusterX, i*clusterY, clusterX, clusterY)
    end
  end
end

--hero:draw()
if magic.earth.isActive then love.graphics.setColor(0, 255, 0) else love.graphics.setColor(0, 255, 255) end
love.graphics.rectangle('fill', hero.x*clusterX + clusterX/4, hero.y*clusterY + clusterY/4, clusterX/2, clusterY/2)

love.graphics.setColor(128, 0, 128, 128)
for _, shad in pairs(S) do
  love.graphics.rectangle('fill', shad.x*clusterX, shad.y*clusterY, clusterX, clusterY)
  --shad:draw()
end

if magic.air.isActive then 
  love.graphics.setColor(0, 255, 255)
  love.graphics.rectangle('fill', magic.air.x*clusterX, magic.air.y*clusterY, clusterX, clusterY)
end

if magic.fire.isActive then
  love.graphics.setColor(255, 64, 0)
  love.graphics.rectangle('fill', magic.fire.x*clusterX, magic.fire.y*clusterY, clusterX, clusterY)
end

if magic.light.isActive then
  love.graphics.setColor(255, 255, 255, 128)
  for key, _ in pairs(magic.light.souls) do
    local _, _, x, y = key:find('(%d+) (%d+)')
    x, y = tonumber(x), tonumber(y)
    love.graphics.rectangle('fill', x*clusterX, y*clusterY, clusterX, clusterY)
  end
end