local enum
enum = require("enum").enum
local Entity
Entity = require("Entity").Entity
local get_image_from_dvalue, base, HALF_IMAGE_OFFSET, DOMINOE_WIDTH, DOMINOE_HEIGHT
do
  local _obj_0 = require("Util")
  get_image_from_dvalue, base, HALF_IMAGE_OFFSET, DOMINOE_WIDTH, DOMINOE_HEIGHT = _obj_0.get_image_from_dvalue, _obj_0.base, _obj_0.HALF_IMAGE_OFFSET, _obj_0.DOMINOE_WIDTH, _obj_0.DOMINOE_HEIGHT
end
local pi
pi = math.pi
DominoeValue = enum({
  "Blank",
  "One",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine",
  "Ten",
  "Eleven",
  "Twelve"
})
local test_boolean
test_boolean = function(bool, pos_val, neg_val)
  if bool then
    return pos_val
  else
    return neg_val
  end
end
do
  local _class_0
  local _parent_0 = Entity
  local _base_0 = {
    draw = function(self)
      love.graphics.push()
      love.graphics.translate(self.x, self.y)
      if self.flipped then
        love.graphics.rotate(pi)
      end
      love.graphics.draw(base, 0, 0, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
      if not (self.top_half == DominoeValue.Blank) then
        love.graphics.draw(self.top_img, 0, 0, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
      end
      if not (self.bot_half == DominoeValue.Blank) then
        love.graphics.draw(self.bot_img, 0, HALF_IMAGE_OFFSET, 0, 1, 1, DOMINOE_WIDTH, DOMINOE_HEIGHT / 2)
      end
      return love.graphics.pop()
    end,
    __tostring = function(self)
      return "Dominoe [" .. tostring(self.top_half) .. "|" .. tostring(self.bot_half) .. "]"
    end,
    can_connect = function(self, dominoe_val)
      if self.top_half == dominoe_val or self.bot_half == dominoe_val then
        return true
      else
        return false
      end
    end,
    is_double = function(self)
      return self.top_half == self.bot_half
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, top_half, bot_half)
      self.top_half, self.bot_half = top_half, bot_half
      self.top_img = get_image_from_dvalue(self.top_half)
      if self.top_half == self.bot_half then
        self.bot_img = self.top_img
      else
        self.bot_img = get_image_from_dvalue(self.bot_half)
      end
      self.flipped = false
    end,
    __base = _base_0,
    __name = "Dominoe",
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
  Dominoe = _class_0
end
return {
  Dominoe = Dominoe,
  DominoeValue = DominoeValue
}
