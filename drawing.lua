love.graphics.setColor(255, 255, 255, 255)
love.graphics.setBlendMode("alpha", "premultiplied")
love.graphics.draw(maze.canvas)

hero:draw()
--love.graphics.setColor(0, 255, 255)
--love.graphics.rectangle('fill', hero.x*cluster + cluster/4, hero.y*cluster + cluster/4, cluster/2, cluster/2)