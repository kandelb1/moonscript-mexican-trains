import Train from require "Train"
import Dominoe, DominoeValue from require "Dominoe"
import HumanPlayer, AIPlayer from require "Player"
import insert, remove from table

export class Game
  new: =>
    @current_double = DominoeValue.Twelve
    @players = {}
    @active_player = nil
    test_train = Train(@current_double)
    test_train\set_position(100, 100)
    test_train\add_dominoe Dominoe(DominoeValue.Twelve, DominoeValue.Seven)
    test_train\add_dominoe Dominoe(DominoeValue.Seven, DominoeValue.Three)
    test_train_2 = Train(@current_double)
    test_train_2\set_position(200, 100)
    @trains = { test_train, test_train_2 }
    @bone_pile = @initialize_dominoes!
    print "I have #{#@bone_pile} dominoes!"
    -- for dominoe in *@bone_pile
    --   print dominoe


  initialize_dominoes: =>
    dominoes = {}
    -- there are 91 dominoes total in mexican trains
    -- so there are 7 groups of 13 dominoes
    -- https://www.thesprucecrafts.com/double-12-dominoes-410915
    for i = 0, 12
      for j = i, 12
        dominoe = Dominoe(num_to_dval(i), num_to_dval(j))
        insert dominoes, dominoe

    -- shuffle the dominoes. https://love2d.org/forums/viewtopic.php?t=326  
    length = #dominoes
    r, tmp = nil
    for i = 1, length
      r = love.math.random(i, length)
      tmp = dominoes[i]
      dominoes[i] = dominoes[r]
      dominoes[r] = tmp
    return dominoes
  
  -- initialize current_double to Twelve
  start_game: =>
    @current_double = DominoeValue.Twelve
    -- will also hard code players for now.
    p1 = HumanPlayer("Jeff", @trains[1])
    for i = 1, 13
      p1\give_dominoe @pick_bone!
    insert @players, p1
    @active_player = p1
    -- p1\print_hand!
    print "p1's score is #{p1\calculate_score!}"
  
  -- add up the points of the players to keep score, and go to the next double
  next_round: => 
    -- calculate scores for each player
    for player in *@players
      score = player\calculate_score!
      print "Player #{player.name} has a score of #{score} this round."
    @current_double = DominoeValue.Eleven --hard coded in for now
    for train in *@trains -- update the trains
      train\set_new_double @current_double

  -- remove a dominoe from the end of the bone pile
  pick_bone: => remove @bone_pile

  draw: =>
    for train in *@trains
      train\draw!
    @active_player\draw!
  
  update: (dt) =>
    for player in *@players
      player\update dt
    
  mousepressed: (x, y, button) => @active_player\mousepressed(x, y, button) if @active_player.__class == HumanPlayer
    

{ :Game }