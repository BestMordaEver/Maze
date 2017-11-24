if k == 'escape' then 
	love.event.quit()
elseif k == 'right' then -- press to move
  hero:tryMovement(1, 0)
elseif k == 'left' then
  hero:tryMovement(-1, 0)
elseif k == 'up' then
  hero:tryMovement(0, -1)
elseif k == 'down' then
  hero:tryMovement(0, 1)
end