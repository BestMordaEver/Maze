local foo = function(text, x, y, sx, sy)
  local button = {text = text, x = x, y = y, sx = sx, sy = sy, dx = x + sx, dy = y + sy}
  
  function button:draw()
    local x, y = love.mouse.getPosition()
    if x > self.x and x < self.dx and y > self.y and y < self.dy then
      if love.mouse.isDown(1) then
        love.graphics.setColor(196, 196, 196)
      else 
        love.graphics.setColor(224, 224, 224)
      end
    else
      love.graphics.setColor(255, 255, 255)
    end
    love.graphics.rectangle('fill', self.x, self.y, self.sx, self.sy)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf(self.text, self.x, 
      math.floor(self.y + self.sy/2 - love.graphics.getFont():getHeight(self.text)/2), self.sx, 'center')
  end
  
  return button
end
return foo