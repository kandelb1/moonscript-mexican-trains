do
  local _class_0
  local _base_0 = {
    set_position = function(self, x, y)
      self.x = x
      self.y = y
    end,
    get_center_point = function(self)
      local x = (self.x + (self.width / 2))
      local y = (self.y + (self.height / 2))
      return x, y
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, width, height)
      if x == nil then
        x = 0
      end
      if y == nil then
        y = 0
      end
      if width == nil then
        width = 0
      end
      if height == nil then
        height = 0
      end
      self.x, self.y, self.width, self.height = x, y, width, height
    end,
    __base = _base_0,
    __name = "Entity"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Entity = _class_0
end
return {
  Entity = Entity
}
