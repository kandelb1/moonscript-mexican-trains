import Dominoe from require "Dominoe"
import Entity from require "Entity"
import DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET from require "Util"
import insert from table

export class Train extends Entity
  new: (@current_double) =>
    @dominoes = {}
  
  set_new_double: (double) => @current_double = double
  
  draw: =>
    x = @x
    y = @y
    if #@dominoes == 0
      -- draw a rectangle to show that a dominoe can be put there
      love.graphics.rectangle("line", @x - (DOMINOE_WIDTH / 2), @y - (DOMINOE_HEIGHT / 2), DOMINOE_WIDTH, DOMINOE_HEIGHT)
      return
    for dominoe in *@dominoes
      dominoe\set_position(x, y)
      dominoe\draw!
      y = y + DOMINOE_HEIGHT

  rotate_to_fit: (dominoe) =>
    dominoe.flipped = dominoe.bot_half == @get_exposed_dval!

  add_dominoe: (dominoe) =>
    @rotate_to_fit(dominoe)
    insert @dominoes, dominoe

  get_last_dominoe: => @dominoes[#@dominoes]

  -- get the dominoe value that is exposed at the end of the train.
  -- if the train is empty, then return whatever the current_double is
  get_exposed_dval: => 
    dominoe = @get_last_dominoe!
    if not dominoe return @current_double
    if dominoe.flipped
      return dominoe.top_half
    else
      return dominoe.bot_half    

  -- can the given dominoe connect to the end of this train?
  -- if the train is empty, the first dominoe must have a value that matches the current double
  can_connect: (dominoe, double_val) =>
    true if #@dominoes == 0 and dominoe\can_connect double_val
    true if dominoe\can_connect @get_exposed_dval! else false
    



{ :Train }