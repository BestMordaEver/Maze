light = Light({ambient = {0, 0, 0}})
  
flip = true
time = 0

maze:new(51, 51)
maze:Generate()
maze:mapWays()
maze:decorate()

E = {}
hero = love.filesystem.load('hero.lua')()
magic:new()

S = {}
watchlist, watchdogs = {}, {up = 20, down = 20, left = 20, right = 20, inside = 0}
shadowTime = 0

for i=1, maze.roomCount do
  shadow()
  if S[i] == nil then break end
end