local foo = function (k)
  if k == 'escape' then 
    love.event.quit()
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