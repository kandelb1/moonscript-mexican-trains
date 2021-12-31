local Dominoe
Dominoe = require("Dominoe").Dominoe
local Entity
Entity = require("Entity").Entity
local DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET
do
  local _obj_0 = require("Util")
  DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET = _obj_0.DOMINOE_HEIGHT, _obj_0.DOMINOE_WIDTH, _obj_0.HALF_IMAGE_OFFSET
end
local insert
insert = table.insert
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    set_new_double = function(self, double)
      self.current_double = double
    end,
    draw = function(self)
      local x = self.x
      local y = self.y
      if #self.dominoes == 0 then
        love.graphics.rectangle("line", self.x - (DOMINOE_WIDTH / 2), self.y - (DOMINOE_HEIGHT / 2), DOMINOE_WIDTH, DOMINOE_HEIGHT)
        return 
      end
      local _list_0 = self.dominoes
      for _index_0 = 1, #_list_0 do
        local dominoe = _list_0[_index_0]
        dominoe:set_position(x, y)
        dominoe:draw()
        y = y + DOMINOE_HEIGHT
      end
    end,
    rotate_to_fit = function(self, dominoe)
      dominoe.flipped = dominoe.bot_half == self:get_exposed_dval()
    end,
    add_dominoe = function(self, dominoe)
      self:rotate_to_fit(dominoe)
      return insert(self.dominoes, dominoe)
    end,
    get_last_dominoe = function(self)
      return self.dominoes[#self.dominoes]
    end,
    get_exposed_dval = function(self)
      local dominoe = self:get_last_dominoe()
      if not dominoe then
        return self.current_double
      end
      if dominoe.flipped then
        return dominoe.top_half
      else
        return dominoe.bot_half
      end
    end,
    can_connect = function(self, dominoe, double_val)
      if #self.dominoes == 0 and dominoe:can_connect(double_val) then
        local _ = true
      end
      if dominoe:can_connect(self:get_exposed_dval()) then
        return true
      else
        return false
      end
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, current_double)
      self.current_double = current_double
      self.dominoes = { }
    end,
    __base = _base_0,
    __name = "Train",
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
  Train = _class_0
end
return {
  Train = Train
}
