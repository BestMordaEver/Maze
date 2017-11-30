local foo = function (k)
  if k == 'escape' then 
    love.event.quit()
  elseif k == 'd' then -- press to move
    hero:tryMovement(1, 0)
  elseif k == 'a' then
    hero:tryMovement(-1, 0)
  elseif k == 'w' then
    hero:tryMovement(0, -1)
  elseif k == 's' then
    hero:tryMovement(0, 1)
  elseif k == 'q' then
    magic.air:cast()
  elseif k == 'e' then
    magic.earth:cast()
  elseif k == 'r' then
    magic.fire:cast()
  elseif k == 'f' then 
    magic.light:cast()
  end
end
return foo