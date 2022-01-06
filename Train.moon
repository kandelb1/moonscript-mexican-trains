import Dominoe from require "Dominoe"
import Entity from require "Entity"
import DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET from require "Util"
import insert, unpack from table

export class Train extends Entity
  new: (@current_double) =>
    @dominoes = {}
    @is_open = false -- whether this train is open or not.
  
  set_new_double: (double) => @current_double = double

  clear: => 
    @dominoes = {}
    @is_open = false
  
  draw: =>
    x = @x
    y = @y
    if #@dominoes == 0
      -- draw a rectangle to show that a dominoe can be put there
      love.graphics.rectangle("line", x - (DOMINOE_WIDTH / 2), y - (DOMINOE_HEIGHT / 2), DOMINOE_WIDTH, DOMINOE_HEIGHT)
      return
    
    draw_index = #@dominoes - 3
    draw_index = 2 if draw_index <= 1      
    with dominoe = @dominoes[draw_index - 1]
      dominoe\set_position(x, y)
      dominoe\draw!
    for i = draw_index, #@dominoes
      with dominoe = @dominoes[i]
        -- print "#{i}, #{dominoe}"
        if dominoe\is_double!
          y = y + (DOMINOE_WIDTH / 2) + (DOMINOE_HEIGHT / 2)
        elseif @dominoes[i - 1]\is_double!
          y = y + (DOMINOE_WIDTH / 2) + (DOMINOE_HEIGHT / 2)  
        else
          y = y + DOMINOE_HEIGHT
        dominoe\set_position(x, y)
        dominoe\draw!

    -- draw the open status of the train
    love.graphics.setPointSize(15)
    if @is_open
      love.graphics.setColor(0, 1, 0, 1)
    else
      love.graphics.setColor(1, 0, 0, 1)
    love.graphics.points(@x, @y - HALF_IMAGE_OFFSET - 20)
    love.graphics.setColor(1, 1, 1, 1)
  
  rotate_to_fit: (dominoe) =>
    if dominoe\is_double!
      dominoe.flip = 2 
    elseif dominoe.bot_half == @get_exposed_dval!
      dominoe.flip = 1
    else
      dominoe.flip = 0

  add_dominoe: (dominoe) =>
    @rotate_to_fit(dominoe)
    insert(@dominoes, dominoe)
    -- print "train is now:"
    -- for i, dominoe in pairs(@dominoes)
    --   print "#{i}, #{dominoe}"

  get_last_dominoe: => @dominoes[#@dominoes]

  -- get the dominoe value that is exposed at the end of the train.
  -- if the train is empty, then return whatever the current_double is
  get_exposed_dval: => 
    dominoe = @get_last_dominoe!
    if not dominoe return @current_double
    if dominoe.flip == 1
      return dominoe.top_half
    else
      return dominoe.bot_half

  -- can the given dominoe connect to the end of this train?
  -- if the train is empty, the first dominoe must have a value that matches the current double
  can_connect: (dominoe, double_val) =>
    return true if #@dominoes == 0 and dominoe\can_connect double_val
    return true if dominoe\can_connect @get_exposed_dval! else false

  get_number_of_doubles: => #[dominoe for dominoe in *@dominoes when dominoe\is_double!]


{ :Train }