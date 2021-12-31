import DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET from require "Util"

export class Mouse
  new: (@player) =>
    @selected = nil
    @x = nil
    @y = nil

  update: (dt) =>
    @x = love.mouse.getX!
    @y = love.mouse.getY!
    @selected\set_position(@x, @y) if @selected

  draw: => @selected\draw! if @selected

  did_click_train: (x, y) =>
    for train in *game.trains
      train_x = train.x - (DOMINOE_WIDTH / 2)
      train_y = train.y - (HALF_IMAGE_OFFSET)
      height = if #train.dominoes == 0
        DOMINOE_HEIGHT
      else
        #train.dominoes * DOMINOE_HEIGHT
      if x >= train_x and x <= train_x + DOMINOE_WIDTH and y >= train_y and y <= train_y + height
        return train
    return false

  did_click_hand: (x, y) =>
    index = 0
    answer = nil
    for dominoe in *@player.hand
      dominoe_x = dominoe.x - (DOMINOE_WIDTH / 2)
      dominoe_y = dominoe.y - (DOMINOE_HEIGHT / 2)
      if x >= dominoe_x and x <= dominoe_x + DOMINOE_WIDTH and y >= dominoe_y and y <= dominoe_y + DOMINOE_HEIGHT
        print "clicked on this dominoe #{dominoe}"
        -- @player\take_dominoe(index)
        answer = dominoe
        break
      index = index + 1
    return answer
  
  click_mouse: (x, y, button) =>
    if button == 1
      if @selected
        train = @did_click_train(x, y)
        if train and train\can_connect(@selected, game.current_double)
          @player\remove_dominoe(@selected)
          print "adding #{@selected} to the train"
          train\add_dominoe(@selected)
        @selected = nil
      else
        dominoe = @did_click_hand(x, y)
        @selected = dominoe if dominoe
    elseif button == 2
      @selected.flipped = not @selected.flipped if @selected
        
        
{ :Mouse }