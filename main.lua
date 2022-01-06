local Dominoe, DominoeValue
do
  local _obj_0 = require("Dominoe")
  Dominoe, DominoeValue = _obj_0.Dominoe, _obj_0.DominoeValue
end
local Game
Game = require("Game").Game
local DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET
do
  local _obj_0 = require("Util")
  DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET = _obj_0.DOMINOE_WIDTH, _obj_0.DOMINOE_HEIGHT, _obj_0.HALF_IMAGE_OFFSET
end
local pi
pi = math.pi
game = Game()
game:start_game()
love.load = function()
  print("love loaded")
  return love.graphics.setBackgroundColor(6 / 255, 47 / 255, 14 / 255, 1)
end
love.draw = function()
  return game:draw()
end
love.update = function(dt)
  return game:update(dt)
end
love.mousepressed = function(x, y, button)
  return game:mousepressed(x, y, button)
end
