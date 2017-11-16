if k == 'escape' then 
	love.event.quit()
elseif k == 'right' then -- press to move
  hero:tryMovement(1, 0, maze)
elseif k == 'left' then
  hero:tryMovement(-1, 0, maze)
elseif k == 'up' then
  hero:tryMovement(0, -1, maze)
elseif k == 'down' then
  hero:tryMovement(0, 1, maze)
end 