local Train
Train = require("Train").Train
local dval_to_num
dval_to_num = require("Util").dval_to_num
local insert, remove
do
  local _obj_0 = table
  insert, remove = _obj_0.insert, _obj_0.remove
end
local Mouse
Mouse = require("Mouse").Mouse
local sum
sum = function(numbers)
  local total = 0
  for _index_0 = 1, #numbers do
    local num = numbers[_index_0]
    total = total + num
  end
  return total
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    update = function(self, dt)
      return error("Not implemented in base class.")
    end,
    draw = function(self)
      return error("Not implemented in base class.")
    end,
    give_dominoe = function(self, dominoe)
      dominoe:set_position(100 + (#self.hand * 60), 600)
      return insert(self.hand, dominoe)
    end,
    take_dominoe = function(self, index)
      if index == nil then
        index = 1
      end
      return remove(self.hand, index)
    end,
    calculate_score = function(self)
      return sum((function()
        local _accum_0 = { }
        local _len_0 = 1
        local _list_0 = self.hand
        for _index_0 = 1, #_list_0 do
          local d = _list_0[_index_0]
          _accum_0[_len_0] = dval_to_num(d.top_half) + dval_to_num(d.bot_half)
          _len_0 = _len_0 + 1
        end
        return _accum_0
      end)())
    end,
    print_hand = function(self)
      print("Player " .. tostring(self.name) .. " printing hand...")
      local _list_0 = self.hand
      for _index_0 = 1, #_list_0 do
        local dominoe = _list_0[_index_0]
        print(dominoe)
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, name, train)
      self.name, self.train = name, train
      self.hand = { }
    end,
    __base = _base_0,
    __name = "BasePlayer",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  BasePlayer = _class_0
end
do
  local _class_0
  local _parent_0 = BasePlayer
  local _base_0 = {
    update = function(self, dt)
      return self.mouse:update(dt)
    end,
    draw = function(self)
      self.mouse:draw()
      local x = 100
      local y = 600
      local _list_0 = self.hand
      for _index_0 = 1, #_list_0 do
        local dominoe = _list_0[_index_0]
        dominoe:draw()
        x = x + 60
      end
    end,
    mousepressed = function(self, x, y, button)
      return self.mouse:click_mouse(x, y, button)
    end,
    remove_dominoe = function(self, dominoe)
      for i, d in pairs(self.hand) do
        if d == dominoe then
          print("removing")
          remove(self.hand, i)
          break
        end
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      _class_0.__parent.__init(self, ...)
      self.mouse = Mouse(self)
    end,
    __base = _base_0,
    __name = "HumanPlayer",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  HumanPlayer = _class_0
end
do
  local _class_0
  local _parent_0 = BasePlayer
  local _base_0 = {
    update = function(self, dt) end,
    draw = function(self) end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "AIPlayer",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  AIPlayer = _class_0
end
return {
  HumanPlayer = HumanPlayer,
  AIPlayer = AIPlayer
}
