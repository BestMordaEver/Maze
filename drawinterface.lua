local si, sc = width > height and height or width, 3
local s = si/sc
love.graphics.setColor(0, 255, 255)
love.graphics.polygon('fill', s/5, s/2, s*2/5, s*2/5, s*2/5, s*3/5)
love.graphics.polygon('fill', s*4/5, s/2, s*3/5, s*3/5, s*3/5, s*2/5)
love.graphics.polygon('fill', s/2, s/5, s*2/5, s*2/5, s*3/5, s*2/5)
love.graphics.polygon('fill', s/2, s*4/5, s*2/5, s*3/5, s*3/5, s*3/5)

love.graphics.setColor(128, 0, 128)
local k = watchdogs.left/10
if k < 1 then
  love.graphics.polygon('fill', s/5, s/2, s*(2-k)/5, s*(3/5-k/10), s*(2-k)/5, s*(2/5+k/10))
end
k = watchdogs.right/10
if k < 1 then
  love.graphics.polygon('fill', s*4/5, s/2, s*(3+k)/5, s*(3/5-k/10), s*(3+k)/5, s*(2/5+k/10))
end
k = watchdogs.up/10
if k < 1 then
  love.graphics.polygon('fill', s/2, s/5, s*(2/5+k/10), s*(2-k)/5, s*(3/5-k/10), s*(2-k)/5)
end
k = watchdogs.down/10
if k < 1 then
  love.graphics.polygon('fill', s/2, s*4/5, s*(2/5+k/10), s*(3+k)/5, s*(3/5-k/10), s*(3+k)/5)
end