local insert
insert = table.insert
local test_bool
test_bool = function(bool, pos_val, neg_val)
  if bool then
    return pos_val
  else
    return neg_val
  end
end
do
  local _class_0
  local _base_0 = {
    did_click = function(self, x, y)
      return error("Function not implemented in base class")
    end,
    execute = function(self)
      if self.callback then
        return self:callback()
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, callback)
      self.x, self.y, self.callback = x, y, callback
    end,
    __base = _base_0,
    __name = "BaseElement"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  BaseElement = _class_0
end
do
  local _class_0
  local _base_0 = {
    draw = function(self)
      love.graphics.setFont(self.font)
      if self.centered then
        local width = love.graphics.getFont():getWidth(self.text)
        return love.graphics.print(self.text, self.x - (width / 2), self.y)
      else
        return love.graphics.print(self.text, self.x, self.y)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, x, y, text, font, centered, callback)
      self.text, self.font, self.centered, self.callback = text, font, centered, callback
      return _class_0.__parent.__init(self, x, y, self.callback)
    end,
    __base = _base_0,
    __name = "TextElement"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  TextElement = _class_0
end
do
  local _class_0
  local _parent_0 = BaseElement
  local _base_0 = {
    draw = function(self)
      return love.graphics.rectangle(test_bool(self.fill, "fill", "line"), self.x, self.y, self.width, self.height)
    end,
    did_click = function(self, x, y)
      return x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
    end,
    set_fill = function(self, fill)
      self.fill = fill
    end,
    get_center_point = function(self)
      local center_x = self.x + (self.width / 2)
      local center_y = self.y + (self.height / 2)
      return center_x, center_y
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, x, y, width, height, callback)
      self.width, self.height, self.callback = width, height, callback
      _class_0.__parent.__init(self, x, y, self.callback)
      self.fill = false
    end,
    __base = _base_0,
    __name = "BoxElement",
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
  BoxElement = _class_0
end
do
  local _class_0
  local _base_0 = {
    huge_font = love.graphics.newFont(24),
    big_font = love.graphics.newFont(18),
    normal_font = love.graphics.getFont(),
    small_font = love.graphics.newFont(13),
    add_element = function(self, name, element)
      self.elements[name] = element
      return insert(self.names, name)
    end,
    draw = function(self)
      local _list_0 = self.names
      for _index_0 = 1, #_list_0 do
        local name = _list_0[_index_0]
        self.elements[name]:draw()
      end
    end,
    update = function(self, dt)
      local _list_0 = self.names
      for _index_0 = 1, #_list_0 do
        local name = _list_0[_index_0]
        self.elements[name]:update(dt)
      end
    end,
    click_mouse = function(self, x, y)
      local _list_0 = self.names
      for _index_0 = 1, #_list_0 do
        local name = _list_0[_index_0]
        do
          local element = self.elements[name]
          if element:did_click(x, y) then
            element.execute()
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.elements = { }
      self.names = { }
    end,
    __base = _base_0,
    __name = "UI"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  UI = _class_0
end
return {
  UI = UI,
  BaseElement = BaseElement,
  BoxElement = BoxElement,
  TextElement = TextElement
}
