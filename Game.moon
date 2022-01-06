import Train from require "Train"
import Dominoe from require "Dominoe"
import HumanPlayer, AIPlayer from require "Player"
import DOMINOE_WIDTH from require "Util"
import UI, BoxElement, TextElement from require "UI"
import insert, remove from table


-- draw player names at top, and the amount of dominoes they have
-- highlight whose turn it currently is

-- controls when you pick up a dominoe:
  -- left click to place
  -- right click to rotate

  -- maybe when you mouse over a train, highlight the slot it should go in
    -- ie. if  the dominoe is a double, make it sideways

-- big_font = love.graphics.newFont(18)
-- normal_font = love.graphics.getFont!
-- small_font = love.graphics.newFont(13)

export class Game
  new: =>
    @current_double = 12
    @players = {}
    @active_player_index = 0
    test_train = Train(@current_double)
    test_train\set_position(400, 160)
    test_train\add_dominoe(Dominoe(12, 7))
    test_train\add_dominoe(Dominoe(7, 7))
    test_train\add_dominoe(Dominoe(7, 4))
    test_train_2 = Train(@current_double)
    test_train_2\set_position(550, 160)
    test_train_2\add_dominoe(Dominoe(12, 6))
    test_train_3 = Train(@current_double)
    test_train_3\set_position(700, 160)
    test_train_3\add_dominoe(Dominoe(12, 2))
    @trains = { test_train, test_train_2, test_train_3 }
    @supplemental = Train(@current_double)
    @supplemental\set_position(700, 160)
    @bone_pile = @initialize_dominoes!
    @initialize_ui!
    @move_list = {}


  initialize_dominoes: =>
    dominoes = {}
    -- there are 91 dominoes total in mexican trains
    -- so there are 7 groups of 13 dominoes
    -- https://www.thesprucecrafts.com/double-12-dominoes-410915
    for i = 0, 12
      for j = i, 12
        dominoe = Dominoe(i, j)
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

  initialize_ui: =>
    @ui = UI!
    bone_pile_element = BoxElement(25, 20, 120, 60)
    @ui\add_element("bone_pile", bone_pile_element)
  
  start_game: =>
    -- initialize current_double to 12
    @current_double = 12

    -- will also hard code players for now.
    p1 = HumanPlayer("Jeff", @trains[1])
    for i = 1, 13
      p1\give_dominoe @pick_bone!
    insert @players, p1
    print "players is #{#@players} long"
    @active_player_index = 1
    p2 = AIPlayer(@trains[2])
    print "made ai player #{p2.name}"
    for i = 1, 13
      p2\give_dominoe @pick_bone!
    insert @players, p2
    p3 = AIPlayer(@trains[3])
    print "made ai player #{p3.name}"
    for i = 1, 13
      p3\give_dominoe @pick_bone!
    insert @players, p3
    print "players is #{#@players} long"
    
  -- remove a dominoe from the end of the bone pile
  pick_bone: => remove @bone_pile

  draw: =>
    -- draw the trains
    for train in *@trains
      train\draw!
    -- draw the player's hand (if it is a human player)
    @players[@active_player_index]\draw!

    -- draw the ui
    @ui\draw!

    -- helper function for printing text centered at a point
    draw_centered_text = (text, x, y, size) -> 
      love.graphics.setFont(size)
      width = love.graphics.getFont!\getWidth(text)
      love.graphics.print(text, x - (width / 2), y)
      love.graphics.setFont(UI.normal_font)

  -- helper function for drawing a rectangle centered at a point
    draw_centered_rectangle = (x, y, width, height, color) ->
      love.graphics.push!
      love.graphics.translate(x - (width / 2), y - (height / 2))
      love.graphics.setColor(color)
      love.graphics.rectangle("line", 0, 0, width, height)
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.pop!


    -- draw player names + info at the top of the screen.
    -- highlight the active player in the list
    x = 230
    for i, player in pairs(@players)
      draw_centered_text(player.name, x, 30, UI.big_font)
      draw_centered_text("Hand: #{#player.hand}", x, 50, UI.small_font)
      draw_centered_rectangle(x, 50, 100, 60, { 1, 1, 0, 1}) if @active_player_index == i -- actually implement @active_player_index
      x = x + 180

    -- draw the text in the bone pile
    with bone_pile = @ui.elements["bone_pile"]
      center_x, center_y = bone_pile\get_center_point!
      draw_centered_text("#{#@bone_pile} dominoes left", center_x, center_y - 10, UI.small_font)
      draw_centered_text("click to draw", center_x, center_y + 5, UI.small_font)

  -- add up the points of the players to keep score, and go to the next double
  next_round: => 
    @active_player_index = 1
    -- calculate scores for each player
    for player in *@players
      score = player\calculate_score!
      print "Player #{player.name} has a score of #{score} this round."
    @current_double = @current_double - 1
    print "New double is #{@current_double}"
    -- figure this out later
    if @current_double == -1
      print "GAME OVER!!"
    for train in *@trains -- update the trains
      train\clear!
      train\set_new_double(@current_double)

  advance_player_index: =>
    @active_player_index = @active_player_index + 1
    if @active_player_index > #@players
      @active_player_index = 1    

  end_turn: =>
    with player = @players[@active_player_index]
      player\reset_move!
      @advance_player_index!

  update: (dt) =>
    with active_player = @players[@active_player_index]
      active_player\update(dt)
      if active_player.move_ready
        move = active_player.move
        result = @process_move(active_player, move)
        @end_turn! if result
        if #active_player.hand == 0
          @next_round!
        insert(@move_list, move)

  -- now, if you play a double and can't cover it, you have to draw. and then your train becomes 'open' to the public.
  -- we also need to implement the supplemental that anyone can do anytime
  process_move: (player, move) =>
    if move\is_draw!
      unless #@bone_pile == 0
        print "Player #{player.name} is drawing"
        player\give_dominoe(@pick_bone!)
      player.train.is_open = true
      return true
    if move.train == player.train
      move.train.is_open = false
    if move\is_double!
      print "Player #{player.name} is playing a double!"
      player\remove_dominoe(move.dominoe)
      move.train\add_dominoe(move.dominoe)
      player\reset_move!
      return false
    else
      if move.train == @supplemental and #@supplemental.dominoes == 0
        print "Player #{player.name} is starting the supplemental!"
      else
        print "Player #{player.name} is playing a move!"
      player\remove_dominoe(move.dominoe)
      move.train\add_dominoe(move.dominoe)
      return true

  mousepressed: (x, y, button) => 
    with active_player = @players[@active_player_index]
      active_player\mousepressed(x, y, button) if active_player.__class == HumanPlayer
    

{ :Game }