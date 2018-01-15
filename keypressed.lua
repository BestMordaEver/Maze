local foo = function (k)
  if k == 'escape' then 
    love.event.quit()
  elseif k == keyPreset.air then
    magic.air:cast()
  elseif k == keyPreset.earth then
    magic.earth:cast()
  elseif k == keyPreset.fire then
    magic.fire:cast()
  elseif k == keyPreset.light then 
    magic.light:cast()
  elseif k == keyPreset.darkness then
    magic.darkness:cast()
  elseif k == 'l' then
    camera:scale(0.5)
  elseif k == 'k' then
    camera:scale(2)
  end
end
return foo