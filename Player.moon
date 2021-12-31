import Train from require "Train"
import dval_to_num from require "Util"
import insert, remove from table
import Mouse from require "Mouse"

sum = (numbers) ->
  total = 0
  for num in *numbers
    total = total + num
  return total

export class BasePlayer extends Entity
  new: (@name, @train) =>
    @hand = {}

  update: (dt) => error "Not implemented in base class."
  
  draw: => error "Not implemented in base class."

  give_dominoe: (dominoe) => 
    dominoe\set_position(100 + (#@hand * 60), 600)
    insert(@hand, dominoe)

  take_dominoe: (index = 1) => remove(@hand, index)

  calculate_score: => sum [dval_to_num(d.top_half) + dval_to_num(d.bot_half) for d in *@hand]
    
  print_hand: =>
    print "Player #{@name} printing hand..."
    for dominoe in *@hand
      print dominoe
  
export class HumanPlayer extends BasePlayer
  new: (...) =>
    super ...
    @mouse = Mouse(self)

  update: (dt) => @mouse\update dt

  -- draw this player's hand at the bottom of the screen
  draw: =>
    @mouse\draw!
    x = 100
    y = 600
    for dominoe in *@hand
      -- dominoe\set_position(x, y)
      dominoe\draw!
      x = x + 60
    
  mousepressed: (x, y, button) => @mouse\click_mouse(x, y, button)

  -- removes a specific dominoe from the hand
  remove_dominoe: (dominoe) =>
    for i, d in pairs(@hand)
      if d == dominoe
        print "removing"
        remove @hand, i
        break

export class AIPlayer extends BasePlayer
  new: =>

  update: (dt) =>

  -- do nothing
  draw: =>

{ :HumanPlayer, :AIPlayer }