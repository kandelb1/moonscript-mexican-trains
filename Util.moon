export base = love.graphics.newImage("img/base.png")
one = love.graphics.newImage("img/one.png")
two = love.graphics.newImage("img/two.png")
three = love.graphics.newImage("img/three.png")
four = love.graphics.newImage("img/four.png")
five = love.graphics.newImage("img/five.png")
six = love.graphics.newImage("img/six.png")
seven = love.graphics.newImage("img/seven.png")
eight = love.graphics.newImage("img/eight.png")
nine = love.graphics.newImage("img/nine.png")
ten = love.graphics.newImage("img/ten.png")
eleven = love.graphics.newImage("img/eleven.png")
twelve = love.graphics.newImage("img/twelve.png")

export DOMINOE_WIDTH = base\getWidth! / 2
export DOMINOE_HEIGHT = base\getHeight!
-- export HALF_IMAGE_OFFSET = 46
export HALF_IMAGE_OFFSET = DOMINOE_HEIGHT / 2

export get_image_from_dvalue = (dominoe_val) ->
  switch dominoe_val
    when 1
      one
    when 2
      two
    when 3
      three
    when 4
      four
    when 5
      five
    when 6
      six
    when 7
      seven
    when 8
      eight
    when 9
      nine
    when 10
      ten
    when 11
      eleven
    when 12
      twelve

{ :get_image_from_dvalue, :base, :DOMINOE_WIDTH, :DOMINOE_HEIGHT, :HALF_IMAGE_OFFSET, :num_to_dval, :dval_to_num }