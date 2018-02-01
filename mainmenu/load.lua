menuB = {}
B = menuB
collectionB = {}
settingsB = {}

menuB.newgameButton = button('New game', width/3, height/4, width/3, height*0.08)
menuB.loadgameButton = button('Load game', width/3, height*0.35, width/3, height*0.08)
menuB.collectionButton = button('Collection', width/3, height*0.45, width/3, height*0.08)
menuB.settingsButton = button('Settings', width/3, height*0.55, width/3, height*0.08)
menuB.quitButton = button('Quit', width/3, height*0.65, width/3, height*0.08)

menuB.newgameButton.action = function()
  B = {}
  gameState = 'transfer'
end

menuB.loadgameButton.action = function()
  B = {}
  gameState = 'transfer'
end

menuB.collectionButton.action = function()
  B = collectionB
end

menuB.settingsButton.action = function()
  B = settingsB
end

menuB.quitButton.action = love.event.quit

collectionB.escapeButton = button('Back', width/6, height*9/10, width/12, height/20)

collectionB.escapeButton.action = function()
  B = menuB
end

settingsB.escapeButton = button('Back', width/6, height*9/10, width/12, height/20)

settingsB.escapeButton.action = function()
  B = menuB
end