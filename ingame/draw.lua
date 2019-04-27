for i = -heightRange + math.floor(hero.y) < 1 and 1 or -heightRange + math.floor(hero.y), heightRange + math.floor(hero.y) do
	if i == Maze.height + 1 then break end -- We draw only these, who fit in screen 
	for j = -widthRange + math.floor(hero.x) < 1 and 1 or -widthRange + math.floor(hero.x), widthRange + math.floor(hero.x) do
    if j == Maze.width + 1 then break end 
    if Maze.visibility[i*Maze.width + j] then 
      local shit = Maze.content[i*Maze.width + j]
      
      if shit == Maze.wall then 
        love.graphics.setColor(255, 255, 255)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      elseif shit == Maze.chest then
        love.graphics.setColor(196, 75, 0)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      elseif shit == Maze.chestUsed then
        love.graphics.setColor(196, 75, 0)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y+cluster.y/3, cluster.x, cluster.y/10)
      elseif shit == Maze.key then
        love.graphics.setColor(0, 128, 196)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      elseif shit == Maze.decoKey then
        love.graphics.setColor(0, 64, 128)
        love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      elseif shit == Maze.pass or shit == Maze.room then 
        --love.graphics.setColor(64, 64, 64)
        --love.graphics.rectangle('fill', j*cluster.x, i*cluster.y, cluster.x, cluster.y)
      end
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
  if Maze.visibility[math.floor(shad.y)*Maze.width + math.floor(shad.x)] then 
    love.graphics.rectangle('fill', shad.x*cluster.x, shad.y*cluster.y, cluster.x, cluster.y)
  --shad:draw()
  end
end

if magic.air.isActive then 
  love.graphics.setColor(0, 255, 255)
  love.graphics.rectangle('fill', magic.air.x*cluster.x, magic.air.y*cluster.y, cluster.x, cluster.y)
end

if magic.light.isActive then
  love.graphics.setColor(255, 255, 255, 128)
  for key, _ in pairs(magic.light.souls) do
    --local _, _, x, y = key:find('(%d+) (%d+)')
    --x, y = tonumber(x), tonumber(y)
    --love.graphics.rectangle('fill', x*cluster.x, y*cluster.y, cluster.x, cluster.y)
  end  

end