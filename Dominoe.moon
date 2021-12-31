import enum from require "enum"
import Entity from require "Entity"
import get_image_from_dvalue, base, HALF_IMAGE_OFFSET, DOMINOE_WIDTH, DOMINOE_HEIGHT from require "Util"
import pi from math

export DominoeValue = enum {"Blank", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve"}

test_boolean = (bool, pos_val, neg_val) -> pos_val if bool else neg_val

export class Dominoe extends Entity
  new: (@top_half, @bot_half) =>
    @top_img = get_image_from_dvalue @top_half
    if @top_half == @bot_half
      @bot_img = @top_img
    else
      @bot_img = get_image_from_dvalue @bot_half
    @flipped = false

  draw: =>
    love.graphics.push!
    love.graphics.translate(@x, @y)
    love.graphics.rotate(pi) if @flipped -- draw the dominoe upside down if @flipped == true  
    love.graphics.draw(base, 0, 0, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
    unless @top_half == DominoeValue.Blank
      love.graphics.draw(@top_img, 0, 0, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
    unless @bot_half == DominoeValue.Blank
      love.graphics.draw(@bot_img, 0, HALF_IMAGE_OFFSET, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
    -- love.graphics.rectangle("line", -DOMINOE_WIDTH / 2, -DOMINOE_HEIGHT / 2, DOMINOE_WIDTH, DOMINOE_HEIGHT)
    love.graphics.pop!

  __tostring: => "Dominoe [#{@top_half}|#{@bot_half}]"

  -- can this dominoe connect with the given dominoe value?
  can_connect: (dominoe_val) => true if @top_half == dominoe_val or @bot_half == dominoe_val else false

  -- returns true if this dominoe is a double (both values are the same), false otherwise
  is_double: => @top_half == @bot_half


{ :Dominoe, :DominoeValue }