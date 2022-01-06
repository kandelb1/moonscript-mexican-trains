local Dominoe
Dominoe = require("Dominoe").Dominoe
local Entity
Entity = require("Entity").Entity
local DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET
do
  local _obj_0 = require("Util")
  DOMINOE_HEIGHT, DOMINOE_WIDTH, HALF_IMAGE_OFFSET = _obj_0.DOMINOE_HEIGHT, _obj_0.DOMINOE_WIDTH, _obj_0.HALF_IMAGE_OFFSET
end
local insert, unpack
do
  local _obj_0 = table
  insert, unpack = _obj_0.insert, _obj_0.unpack
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    set_new_double = function(self, double)
      self.current_double = double
    end,
    clear = function(self)
      self.dominoes = { }
      self.is_open = false
    end,
    draw = function(self)
      local x = self.x
      local y = self.y
      if #self.dominoes == 0 then
        love.graphics.rectangle("line", x - (DOMINOE_WIDTH / 2), y - (DOMINOE_HEIGHT / 2), DOMINOE_WIDTH, DOMINOE_HEIGHT)
        return 
      end
      local draw_index = #self.dominoes - 3
      if draw_index <= 1 then
        draw_index = 2
      end
      do
        local dominoe = self.dominoes[draw_index - 1]
        dominoe:set_position(x, y)
        dominoe:draw()
      end
      for i = draw_index, #self.dominoes do
        do
          local dominoe = self.dominoes[i]
          if dominoe:is_double() then
            y = y + (DOMINOE_WIDTH / 2) + (DOMINOE_HEIGHT / 2)
          elseif self.dominoes[i - 1]:is_double() then
            y = y + (DOMINOE_WIDTH / 2) + (DOMINOE_HEIGHT / 2)
          else
            y = y + DOMINOE_HEIGHT
          end
          dominoe:set_position(x, y)
          dominoe:draw()
        end
      end
      love.graphics.setPointSize(15)
      if self.is_open then
        love.graphics.setColor(0, 1, 0, 1)
      else
        love.graphics.setColor(1, 0, 0, 1)
      end
      love.graphics.points(self.x, self.y - HALF_IMAGE_OFFSET - 20)
      return love.graphics.setColor(1, 1, 1, 1)
    end,
    rotate_to_fit = function(self, dominoe)
      if dominoe:is_double() then
        dominoe.flip = 2
      elseif dominoe.bot_half == self:get_exposed_dval() then
        dominoe.flip = 1
      else
        dominoe.flip = 0
      end
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
      if dominoe.flip == 1 then
        return dominoe.top_half
      else
        return dominoe.bot_half
      end
    end,
    can_connect = function(self, dominoe, double_val)
      if #self.dominoes == 0 and dominoe:can_connect(double_val) then
        return true
      end
      if dominoe:can_connect(self:get_exposed_dval()) then
        return true
      else
        return false
      end
    end,
    get_number_of_doubles = function(self)
      return #(function()
        local _accum_0 = { }
        local _len_0 = 1
        local _list_0 = self.dominoes
        for _index_0 = 1, #_list_0 do
          local dominoe = _list_0[_index_0]
          if dominoe:is_double() then
            _accum_0[_len_0] = dominoe
            _len_0 = _len_0 + 1
          end
        end
        return _accum_0
      end)()
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, current_double)
      self.current_double = current_double
      self.dominoes = { }
      self.is_open = false
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
