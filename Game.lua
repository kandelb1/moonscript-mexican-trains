local Train
Train = require("Train").Train
local Dominoe
Dominoe = require("Dominoe").Dominoe
local HumanPlayer, AIPlayer
do
  local _obj_0 = require("Player")
  HumanPlayer, AIPlayer = _obj_0.HumanPlayer, _obj_0.AIPlayer
end
local DOMINOE_WIDTH
DOMINOE_WIDTH = require("Util").DOMINOE_WIDTH
local UI, BoxElement, TextElement
do
  local _obj_0 = require("UI")
  UI, BoxElement, TextElement = _obj_0.UI, _obj_0.BoxElement, _obj_0.TextElement
end
local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
do
  local _class_0
  local _base_0 = {
    initialize_dominoes = function(self)
      local dominoes = { }
      for i = 0, 12 do
        for j = i, 12 do
          local dominoe = Dominoe(i, j)
          insert(dominoes, dominoe)
        end
      end
      local length = #dominoes
      local r, tmp = nil
      for i = 1, length do
        r = love.math.random(i, length)
        tmp = dominoes[i]
        dominoes[i] = dominoes[r]
        dominoes[r] = tmp
      end
      return dominoes
    end,
    initialize_ui = function(self)
      self.ui = UI()
      local bone_pile_element = BoxElement(25, 20, 120, 60)
      return self.ui:add_element("bone_pile", bone_pile_element)
    end,
    start_game = function(self)
      self.current_double = 12
      local p1 = HumanPlayer("Jeff", self.trains[1])
      for i = 1, 13 do
        p1:give_dominoe(self:pick_bone())
      end
      insert(self.players, p1)
      print("players is " .. tostring(#self.players) .. " long")
      self.active_player_index = 1
      local p2 = AIPlayer(self.trains[2])
      print("made ai player " .. tostring(p2.name))
      for i = 1, 13 do
        p2:give_dominoe(self:pick_bone())
      end
      insert(self.players, p2)
      local p3 = AIPlayer(self.trains[3])
      print("made ai player " .. tostring(p3.name))
      for i = 1, 13 do
        p3:give_dominoe(self:pick_bone())
      end
      insert(self.players, p3)
      return print("players is " .. tostring(#self.players) .. " long")
    end,
    pick_bone = function(self)
      return remove(self.bone_pile)
    end,
    draw = function(self)
      local _list_0 = self.trains
      for _index_0 = 1, #_list_0 do
        local train = _list_0[_index_0]
        train:draw()
      end
      self.players[self.active_player_index]:draw()
      self.ui:draw()
      local draw_centered_text
      draw_centered_text = function(text, x, y, size)
        love.graphics.setFont(size)
        local width = love.graphics.getFont():getWidth(text)
        love.graphics.print(text, x - (width / 2), y)
        return love.graphics.setFont(UI.normal_font)
      end
      local draw_centered_rectangle
      draw_centered_rectangle = function(x, y, width, height, color)
        love.graphics.push()
        love.graphics.translate(x - (width / 2), y - (height / 2))
        love.graphics.setColor(color)
        love.graphics.rectangle("line", 0, 0, width, height)
        love.graphics.setColor(1, 1, 1, 1)
        return love.graphics.pop()
      end
      local x = 230
      for i, player in pairs(self.players) do
        draw_centered_text(player.name, x, 30, UI.big_font)
        draw_centered_text("Hand: " .. tostring(#player.hand), x, 50, UI.small_font)
        if self.active_player_index == i then
          draw_centered_rectangle(x, 50, 100, 60, {
            1,
            1,
            0,
            1
          })
        end
        x = x + 180
      end
      do
        local bone_pile = self.ui.elements["bone_pile"]
        local center_x, center_y = bone_pile:get_center_point()
        draw_centered_text(tostring(#self.bone_pile) .. " dominoes left", center_x, center_y - 10, UI.small_font)
        draw_centered_text("click to draw", center_x, center_y + 5, UI.small_font)
        return bone_pile
      end
    end,
    next_round = function(self)
      self.active_player_index = 1
      local _list_0 = self.players
      for _index_0 = 1, #_list_0 do
        local player = _list_0[_index_0]
        local score = player:calculate_score()
        print("Player " .. tostring(player.name) .. " has a score of " .. tostring(score) .. " this round.")
      end
      self.current_double = self.current_double - 1
      print("New double is " .. tostring(self.current_double))
      if self.current_double == -1 then
        print("GAME OVER!!")
      end
      local _list_1 = self.trains
      for _index_0 = 1, #_list_1 do
        local train = _list_1[_index_0]
        train:clear()
        train:set_new_double(self.current_double)
      end
    end,
    advance_player_index = function(self)
      self.active_player_index = self.active_player_index + 1
      if self.active_player_index > #self.players then
        self.active_player_index = 1
      end
    end,
    end_turn = function(self)
      do
        local player = self.players[self.active_player_index]
        player:reset_move()
        self:advance_player_index()
        return player
      end
    end,
    update = function(self, dt)
      do
        local active_player = self.players[self.active_player_index]
        active_player:update(dt)
        if active_player.move_ready then
          local move = active_player.move
          local result = self:process_move(active_player, move)
          if result then
            self:end_turn()
          end
          if #active_player.hand == 0 then
            self:next_round()
          end
          insert(self.move_list, move)
        end
        return active_player
      end
    end,
    process_move = function(self, player, move)
      if move:is_draw() then
        if not (#self.bone_pile == 0) then
          print("Player " .. tostring(player.name) .. " is drawing")
          player:give_dominoe(self:pick_bone())
        end
        player.train.is_open = true
        return true
      end
      if move.train == player.train then
        move.train.is_open = false
      end
      if move:is_double() then
        print("Player " .. tostring(player.name) .. " is playing a double!")
        player:remove_dominoe(move.dominoe)
        move.train:add_dominoe(move.dominoe)
        player:reset_move()
        return false
      else
        if move.train == self.supplemental and #self.supplemental.dominoes == 0 then
          print("Player " .. tostring(player.name) .. " is starting the supplemental!")
        else
          print("Player " .. tostring(player.name) .. " is playing a move!")
        end
        player:remove_dominoe(move.dominoe)
        move.train:add_dominoe(move.dominoe)
        return true
      end
    end,
    mousepressed = function(self, x, y, button)
      do
        local active_player = self.players[self.active_player_index]
        if active_player.__class == HumanPlayer then
          active_player:mousepressed(x, y, button)
        end
        return active_player
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.current_double = 12
      self.players = { }
      self.active_player_index = 0
      local test_train = Train(self.current_double)
      test_train:set_position(400, 160)
      test_train:add_dominoe(Dominoe(12, 7))
      test_train:add_dominoe(Dominoe(7, 7))
      test_train:add_dominoe(Dominoe(7, 4))
      local test_train_2 = Train(self.current_double)
      test_train_2:set_position(550, 160)
      test_train_2:add_dominoe(Dominoe(12, 6))
      local test_train_3 = Train(self.current_double)
      test_train_3:set_position(700, 160)
      test_train_3:add_dominoe(Dominoe(12, 2))
      self.trains = {
        test_train,
        test_train_2,
        test_train_3
      }
      self.supplemental = Train(self.current_double)
      self.supplemental:set_position(700, 160)
      self.bone_pile = self:initialize_dominoes()
      self:initialize_ui()
      self.move_list = { }
    end,
    __base = _base_0,
    __name = "Game"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Game = _class_0
end
return {
  Game = Game
}
