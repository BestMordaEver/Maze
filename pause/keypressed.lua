local foo = function (k)
  if k == 'escape' then
    if B.backButton then 
      B.backButton.action()
    else
      B = {}
      gameState = 'ingame'
    end
  end
end
return foo