local shadow = entity() -- There you are!

shadow:new(0, 0, cluster, cluster, 'shadow', 'down')

shadow.animation:newAnimation('moving', 0.1)
shadow.animation:setAnimation('moving')
shadow.animation:addFrame('moving','imgs/Men/Shadow1.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow2.png')
shadow.animation:addFrame('moving','imgs/Men/Shadow3.png')

return shadow