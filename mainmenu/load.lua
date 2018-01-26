menuB = B
collectionB = {}
settingsB = {}

B.newgameButton = button('New game', width/3, height/4, width/3, height*0.08)
B.loadgameButton = button('Load game', width/3, height*0.35, width/3, height*0.08)
B.collectionButton = button('Collection', width/3, height*0.45, width/3, height*0.08)
B.settingsButton = button('Settings', width/3, height*0.55, width/3, height*0.08)
B.quitButton = button('Quit', width/3, height*0.65, width/3, height*0.08)

B.newgameButton.action = function()
  B = {}
  gameState = 'ingame'
end

B.loadgameButton.action = function()
  B = {}
  gameState = 'ingame'
end

B.collectionButton.action = function()
  B = collectionB
end

B.settingsButton.action = function()
  B = settingsB
end

B.quitButton.action = love.event.quit

B = {}

B.escapeButton = button('Back', width/6, height*9/10, width/12, height/20)

B.escapeButton.action = function()
  B = menuB
end

collectionB = B

B = {}

B.escapeButton = button('Back', width/6, height*9/10, width/12, height/20)

B.escapeButton.action = function()
  B = menuB
end

settingsB = B

B = menuB