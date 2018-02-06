menuB = {}
B = menuB
collectionB = {}
settingsB = {}
pauseB = {}

menuB.newgameButton = button('New game', width/3, height/4, width/3, height*0.08, 
  function ()
    B = {}
    ingameLoad()
    gameState = 'ingame'
  end)

menuB.loadgameButton = button('Load game', width/3, height*0.35, width/3, height*0.08,
  function ()
    B = {}
    ingameLoad()
    gameState = 'ingame'
  end)

menuB.collectionButton = button('Collection', width/3, height*0.45, width/3, height*0.08,
  function ()
    LastB = B
    B = collectionB
  end)

menuB.settingsButton = button('Settings', width/3, height*0.55, width/3, height*0.08, 
  function ()
    LastB = B
    B = settingsB
  end)

menuB.quitButton = button('Quit', width/3, height*0.65, width/3, height*0.08, love.event.quit)

giveButton(collectionB)

giveButton(settingsB)

pauseB.continueButton = button('Continue', width/3, height*0.35, width/3, height*0.08, 
  function ()
    B = {}
    gameState = 'ingame'
  end)

pauseB.settingsButton = button('Settings', width/3, height*0.45, width/3, height*0.08,
  function ()
    LastB = B
    B = settingsB
  end)

pauseB.quitButton = button('To main menu', width/3, height*0.55, width/3, height*0.08,
  function ()
    B = menuB
    gameState = 'mainmenu'
  end)