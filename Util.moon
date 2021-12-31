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
    when DominoeValue.One
      one
    when DominoeValue.Two
      two
    when DominoeValue.Three
      three
    when DominoeValue.Four
      four
    when DominoeValue.Five
      five
    when DominoeValue.Six
      six
    when DominoeValue.Seven
      seven
    when DominoeValue.Eight
      eight
    when DominoeValue.Nine
      nine
    when DominoeValue.Ten
      ten
    when DominoeValue.Eleven
      eleven
    when DominoeValue.Twelve
      twelve
      
export num_to_dval = (num) ->
  switch num
    when 0
      DominoeValue.Blank
    when 1
      DominoeValue.One
    when 2
      DominoeValue.Two
    when 3
      DominoeValue.Three
    when 4
      DominoeValue.Four
    when 5
      DominoeValue.Five
    when 6
      DominoeValue.Six
    when 7
      DominoeValue.Seven
    when 8
      DominoeValue.Eight
    when 9
      DominoeValue.Nine
    when 10
      DominoeValue.Ten
    when 11
      DominoeValue.Eleven
    when 12
      DominoeValue.Twelve

export dval_to_num = (dominoe_val) ->
  switch dominoe_val
    when DominoeValue.Blank
      0
    when DominoeValue.One
      1
    when DominoeValue.Two
      2
    when DominoeValue.Three
      3
    when DominoeValue.Four
      4
    when DominoeValue.Five
      5
    when DominoeValue.Six
      6
    when DominoeValue.Seven
      7
    when DominoeValue.Eight
      8
    when DominoeValue.Nine
      9
    when DominoeValue.Ten
      10
    when DominoeValue.Eleven
      11
    when DominoeValue.Twelve
      12

{ :get_image_from_dvalue, :base, :DOMINOE_WIDTH, :DOMINOE_HEIGHT, :HALF_IMAGE_OFFSET, :num_to_dval, :dval_to_num }