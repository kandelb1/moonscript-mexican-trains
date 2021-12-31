local Train
Train = require("Train").Train
local Dominoe, DominoeValue
do
  local _obj_0 = require("Dominoe")
  Dominoe, DominoeValue = _obj_0.Dominoe, _obj_0.DominoeValue
end
local HumanPlayer, AIPlayer
do
  local _obj_0 = require("Player")
  HumanPlayer, AIPlayer = _obj_0.HumanPlayer, _obj_0.AIPlayer
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
          local dominoe = Dominoe(num_to_dval(i), num_to_dval(j))
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
    start_game = function(self)
      self.current_double = DominoeValue.Twelve
      local p1 = HumanPlayer("Jeff", self.trains[1])
      for i = 1, 13 do
        p1:give_dominoe(self:pick_bone())
      end
      insert(self.players, p1)
      self.active_player = p1
      return print("p1's score is " .. tostring(p1:calculate_score()))
    end,
    next_round = function(self)
      local _list_0 = self.players
      for _index_0 = 1, #_list_0 do
        local player = _list_0[_index_0]
        local score = player:calculate_score()
        print("Player " .. tostring(player.name) .. " has a score of " .. tostring(score) .. " this round.")
      end
      self.current_double = DominoeValue.Eleven
      local _list_1 = self.trains
      for _index_0 = 1, #_list_1 do
        local train = _list_1[_index_0]
        train:set_new_double(self.current_double)
      end
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
      return self.active_player:draw()
    end,
    update = function(self, dt)
      local _list_0 = self.players
      for _index_0 = 1, #_list_0 do
        local player = _list_0[_index_0]
        player:update(dt)
      end
    end,
    mousepressed = function(self, x, y, button)
      if self.active_player.__class == HumanPlayer then
        return self.active_player:mousepressed(x, y, button)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.current_double = DominoeValue.Twelve
      self.players = { }
      self.active_player = nil
      local test_train = Train(self.current_double)
      test_train:set_position(100, 100)
      test_train:add_dominoe(Dominoe(DominoeValue.Twelve, DominoeValue.Seven))
      test_train:add_dominoe(Dominoe(DominoeValue.Seven, DominoeValue.Three))
      local test_train_2 = Train(self.current_double)
      test_train_2:set_position(200, 100)
      self.trains = {
        test_train,
        test_train_2
      }
      self.bone_pile = self:initialize_dominoes()
      return print("I have " .. tostring(#self.bone_pile) .. " dominoes!")
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
