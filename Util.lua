base = love.graphics.newImage("img/base.png")
local one = love.graphics.newImage("img/one.png")
local two = love.graphics.newImage("img/two.png")
local three = love.graphics.newImage("img/three.png")
local four = love.graphics.newImage("img/four.png")
local five = love.graphics.newImage("img/five.png")
local six = love.graphics.newImage("img/six.png")
local seven = love.graphics.newImage("img/seven.png")
local eight = love.graphics.newImage("img/eight.png")
local nine = love.graphics.newImage("img/nine.png")
local ten = love.graphics.newImage("img/ten.png")
local eleven = love.graphics.newImage("img/eleven.png")
local twelve = love.graphics.newImage("img/twelve.png")
DOMINOE_WIDTH = base:getWidth() / 2
DOMINOE_HEIGHT = base:getHeight()
HALF_IMAGE_OFFSET = DOMINOE_HEIGHT / 2
get_image_from_dvalue = function(dominoe_val)
  local _exp_0 = dominoe_val
  if DominoeValue.One == _exp_0 then
    return one
  elseif DominoeValue.Two == _exp_0 then
    return two
  elseif DominoeValue.Three == _exp_0 then
    return three
  elseif DominoeValue.Four == _exp_0 then
    return four
  elseif DominoeValue.Five == _exp_0 then
    return five
  elseif DominoeValue.Six == _exp_0 then
    return six
  elseif DominoeValue.Seven == _exp_0 then
    return seven
  elseif DominoeValue.Eight == _exp_0 then
    return eight
  elseif DominoeValue.Nine == _exp_0 then
    return nine
  elseif DominoeValue.Ten == _exp_0 then
    return ten
  elseif DominoeValue.Eleven == _exp_0 then
    return eleven
  elseif DominoeValue.Twelve == _exp_0 then
    return twelve
  end
end
num_to_dval = function(num)
  local _exp_0 = num
  if 0 == _exp_0 then
    return DominoeValue.Blank
  elseif 1 == _exp_0 then
    return DominoeValue.One
  elseif 2 == _exp_0 then
    return DominoeValue.Two
  elseif 3 == _exp_0 then
    return DominoeValue.Three
  elseif 4 == _exp_0 then
    return DominoeValue.Four
  elseif 5 == _exp_0 then
    return DominoeValue.Five
  elseif 6 == _exp_0 then
    return DominoeValue.Six
  elseif 7 == _exp_0 then
    return DominoeValue.Seven
  elseif 8 == _exp_0 then
    return DominoeValue.Eight
  elseif 9 == _exp_0 then
    return DominoeValue.Nine
  elseif 10 == _exp_0 then
    return DominoeValue.Ten
  elseif 11 == _exp_0 then
    return DominoeValue.Eleven
  elseif 12 == _exp_0 then
    return DominoeValue.Twelve
  end
end
dval_to_num = function(dominoe_val)
  local _exp_0 = dominoe_val
  if DominoeValue.Blank == _exp_0 then
    return 0
  elseif DominoeValue.One == _exp_0 then
    return 1
  elseif DominoeValue.Two == _exp_0 then
    return 2
  elseif DominoeValue.Three == _exp_0 then
    return 3
  elseif DominoeValue.Four == _exp_0 then
    return 4
  elseif DominoeValue.Five == _exp_0 then
    return 5
  elseif DominoeValue.Six == _exp_0 then
    return 6
  elseif DominoeValue.Seven == _exp_0 then
    return 7
  elseif DominoeValue.Eight == _exp_0 then
    return 8
  elseif DominoeValue.Nine == _exp_0 then
    return 9
  elseif DominoeValue.Ten == _exp_0 then
    return 10
  elseif DominoeValue.Eleven == _exp_0 then
    return 11
  elseif DominoeValue.Twelve == _exp_0 then
    return 12
  end
end
return {
  get_image_from_dvalue = get_image_from_dvalue,
  base = base,
  DOMINOE_WIDTH = DOMINOE_WIDTH,
  DOMINOE_HEIGHT = DOMINOE_HEIGHT,
  HALF_IMAGE_OFFSET = HALF_IMAGE_OFFSET,
  num_to_dval = num_to_dval,
  dval_to_num = dval_to_num
}
