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
  if 1 == _exp_0 then
    return one
  elseif 2 == _exp_0 then
    return two
  elseif 3 == _exp_0 then
    return three
  elseif 4 == _exp_0 then
    return four
  elseif 5 == _exp_0 then
    return five
  elseif 6 == _exp_0 then
    return six
  elseif 7 == _exp_0 then
    return seven
  elseif 8 == _exp_0 then
    return eight
  elseif 9 == _exp_0 then
    return nine
  elseif 10 == _exp_0 then
    return ten
  elseif 11 == _exp_0 then
    return eleven
  elseif 12 == _exp_0 then
    return twelve
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
