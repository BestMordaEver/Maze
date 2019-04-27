flip = true
time = 0

Maze.generate(11, 11)

Maze.mapWays()

E = {}
hero = love.filesystem.load('hero.lua')()
magic:new()

S = {}
watchlist, watchdogs = {}, {up = 20, down = 20, left = 20, right = 20, inside = 0}
shadowTime = 0

for i=1, Maze.roomCount do
  shadow()
  if S[i] == nil then break end
end