import Dominoe, DominoeValue from require "Dominoe"
import Game from require "Game"
-- import Mouse from require "Mouse"
-- import Train from require "Train"
import DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET from require "Util"
import pi from math

export game = Game!
game\start_game!

love.load = -> 
  print "love loaded"
  love.graphics.setBackgroundColor(6 / 255, 47 / 255, 14 / 255, 1)

base = love.graphics.newImage("img/Base.png")
five = love.graphics.newImage("img/Five.png")
four = love.graphics.newImage("img/Four.png")

love.draw = -> 
  game\draw!

love.update = (dt) -> 
  game\update dt

love.mousepressed = (x, y, button) ->
  game\mousepressed(x, y, button)