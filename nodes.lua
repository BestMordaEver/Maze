UpdateNode = {
  entities = {}, 
  new = function (entity, name, foo)
    if UpdateNode.entities[name] then error ("Update entity " .. name .. " already exists") end
    entity.update = foo
    UpdateNode.entities[name] = entity
    return entity
  end,
  
  remove = function (name)
    UpdateNode.entities[name] = nil
  end,
  
  find = function (name)
    return UpdateNode.entities[name]
  end
}

DrawNode = {
  new = function (entity, name, x, y, width, height, sprites, static)
    entity.x, entity.y, entity.dir = x, y, "right"
    entity.width, entity.height = width, height
    entity.sprites, entity.static = sprites, static
    DrawNode.entities[name] = entity
    return entity
  end,
  
  newAnimation = function (entity, name, delay, frames)
    if not entity.animation then 
      entity.animation = {}
      entity.currentAnimation = ""
      entity.setAnimation = function (self, name)
        self.currentAnimation = name
        self.animation[name].time, self.animation[name].current = 0, 1
      end
    end
    entity.animation[name] = {frames = frames, delay = delay, timer = 0, current = 1}
    
    UpdateNode.new(entity.animation[name], name, 
      function (self, dt)
        while self.timer > self.delay do
          self.timer = self.timer - self.delay
          self.current = self.current == #frames and 1 or self.current + 1
        end
        self.timer = self.timer + dt
      end
    )
  end,
  
  remove = function (name)
    DrawNode.entities[name] = nil
  end,
  
  find = function (name)
    return DrawNode.entities[name]
  end
}

GUINode = {
  button = {}, label = {}, slider = {}, checkbox = {}, group = {},
  
  newLabel = function (name, x, y, text, font, image)
    GUINode.label[name] = {x=x, y=y, font=font, image=image}
    GUINode.updateText("label", name, text)
  end,
  
  newButton = function (name, foo, x, y, width, height, text, font, imgPassive, imgFocused, imgPress)
    GUINode.button[name] = {foo=foo, x=x, y=y, width=width, height=height, font=font, imgPassive=imgPassive, imgFocused=imgFocused, imgPress=imgPress}
    GUINode.updateText("button", name, text)
  end,
  
  newSlider = function (name, x, y, width, height, sliderWidth, sliderHeight, pos, maxPos, imgLine, imgSlider)
    GUINode.slider[name] = {x=x, y=y, width=width, height=height, sliderWidth=sliderWidth, sliderHeight=sliderHeight, pos=pos, maxPos=maxPos, imgLine=imgLine, imgSlider=imgSlider}
  end,
  
  newCheckbox = function (name, x, y, width, height, checked, img, check)
    GUINode.checkbox[name] = {x=x, y=y, width=width, height=height, checked=checked, img=img, check=check}
  end,
  
  newGroup = function (name, x, y, img)
    GUINode.group[name] = {x=x, y=y, img=img}
  end,
  
  updateText = function (element, name, text)
    local b = GUINode[element][name]
    b.text = love.graphics.newText(b.font, text)
    b.textx, b.texty = b.x + (b.width - b.font:getWidth(text))/2, b.y + (b.height - b.font:getHeight())/2
  end,
  
  appendText = function (element, name, text, x,y, r,g,b)
    local e = GUINode[element][name]
    
  end,
  
  draw = function ()
    for _, g in pairs(GUINode.group) do
      love.graphics.draw(g.img, g.x, g.y)
    end
    
    local x,y = love.mouse.getPosition()
    for _, b in pairs(GUINode.button) do
      if x>b.x and x<b.x+b.width and y>b.y and y<b.y+b.height then
        if love.mouse.isDown(1) then 
          love.graphics.draw(b.imgPress, b.x, b.y)
        else
          love.graphics.draw(b.imgFocused, b.x, b.y)
        end
      else
        love.graphics.draw(b.imgPassive, b.x, b.y)
      end
      love.graphics.draw(b.text, b.textx, b.texty)
    end
    
    for _, s in pairs(GUINode.slider) do
      love.graphics.draw(s.imgLine, s.x, s.y)
      love.graphics.draw(s.imgSlider, s.x - s.sliderWidth + s.pos/s.maxPos*s.width, s.y)
    end
    
    for _, c in pairs(GUINode.checkbox) do
      love.graphics.draw(c.img, c.x, c.y)
      if c.checked then love.graphics.draw(c.check, c.x, c.y) end
    end
    
    for _, l in pairs(GUINode.label) do
      if l.img then love.graphics.draw(l.img, l.x, l.y) end
      if l.text then love.graphics.draw(l.text, l.x, l.y) end
    end
  end,
  
  find = function (name)
    return GUINode.button[name] or GUINode.label[name] or GUINode.slider[name] or GUINode.checkbox[name] or GUINode.group[name]
  end,
  
  remove = function (name)
    GUINode.button[name], GUINode.label[name], GUINode.slider[name], GUINode.checkbox[name], GUINode.group[name] = nil, nil, nil, nil, nil
  end
}


local mt = {
  __call = function(self, name)
    return self.find(name)
  end
}

setmetatable(DrawNode, mt)
setmetatable(UpdateNode, mt)
setmetatable(GUINode, mt)