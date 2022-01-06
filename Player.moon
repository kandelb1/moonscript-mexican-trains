import Train from require "Train"
import dval_to_num from require "Util"
import insert, remove from table
import Mouse from require "Mouse"
import Move from require "Move"

sum = (numbers) ->
  total = 0
  for num in *numbers
    total = total + num
  return total

export class BasePlayer extends Entity
  new: (@name, @train) =>
    @hand = {}
    @move_ready = false
    @move = nil

  update: (dt) => error "Not implemented in base class."
  
  draw: => error "Not implemented in base class."

  give_dominoe: (dominoe) => 
    dominoe\set_position(100 + (#@hand * 60), 700)
    insert(@hand, dominoe)

  take_dominoe: (index = 1) => remove(@hand, index)

  -- removes a specific dominoe from the hand
  remove_dominoe: (dominoe) =>
    for i, d in pairs(@hand)
      if d == dominoe
        remove @hand, i
        break

  calculate_score: => sum [d.top_half + d.bot_half for d in *@hand]
  
  has_move_ready: => @move_ready

  complete_move: (move) =>
    @move = move
    @move_ready = true

  reset_move: =>
    @move_ready = false
    @move = nil
    
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


bot_names = {"Jeff", "Arnold", "Megan", "Bob", "Jessica", "Frank", "Ethan", "Freddy", "Melissa", "Seth", "Morgan"}

export class AIPlayer extends BasePlayer
  new: (train) =>
    random_name = bot_names[love.math.random(1, #bot_names)]
    super(random_name, train)

  update: (dt) => @think_of_move!

  think_of_move: =>
    print "Player #{@name} thinking of move..."
    love.timer.sleep(0.25)

    -- let's just try to play on our own train for now
    for dominoe in *@hand
      if @train\can_connect(dominoe, game.current_double)
        @complete_move(Move(@train, dominoe))
        return
    
    -- try to play on other open trains
    open_trains = [train for train in *game.trains when train.is_open]
    for dominoe in *@hand
      for train in *open_trains
        if train\can_connect(dominoe, game.current_double)
          @complete_move(Move(train, dominoe))
          return

    -- otherwise, just draw
    @complete_move(Move!\make_draw!)
    return false

  end_turn: => print "ending turn."
  
  -- do nothing
  draw: =>

{ :HumanPlayer, :AIPlayer }