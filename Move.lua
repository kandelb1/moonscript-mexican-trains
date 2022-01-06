do
  local _class_0
  local _base_0 = {
    make_draw = function(self)
      self.draw = true
      return self
    end,
    is_draw = function(self)
      return self.draw
    end,
    is_double = function(self)
      return self.double
    end,
    __tostring = function(self)
      return "Placing dominoe " .. tostring(self.dominoe) .. " on train with dval " .. tostring(self.train:get_exposed_dval())
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, train, dominoe)
      self.train, self.dominoe = train, dominoe
      self.draw = false
      self.double = false
      if self.dominoe then
        self.double = self.dominoe:is_double()
      end
    end,
    __base = _base_0,
    __name = "Move"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Move = _class_0
end
return {
  Move = Move
}
