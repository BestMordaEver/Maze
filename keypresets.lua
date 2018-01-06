local keyPreset = {
  left, right, up, down, air, earth, fire, darkness, light,
  arrows = function (self)
    self.left = 'left'
    self.right = 'right'
    self.up = 'up'
    self.down = 'down'
    self.air = 'q'
    self.earth = 'w'
    self.fire = 'e'
    self.darkness = 'd'
    self.light = 'f'
  end,
  wasd = function (self)
    self.left = 'a'
    self.right = 'd'
    self.up = 'w'
    self.down = 's'
    self.air = 'q'
    self.earth = 'e'
    self.fire = 'r'
    self.darkness = 'c'
    self.light = 'f'
  end
}
return keyPreset