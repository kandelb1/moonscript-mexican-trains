local DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET
do
  local _obj_0 = require("Util")
  DOMINOE_WIDTH, DOMINOE_HEIGHT, HALF_IMAGE_OFFSET = _obj_0.DOMINOE_WIDTH, _obj_0.DOMINOE_HEIGHT, _obj_0.HALF_IMAGE_OFFSET
end
do
  local _class_0
  local _base_0 = {
    update = function(self, dt)
      self.x = love.mouse.getX()
      self.y = love.mouse.getY()
      if self.selected then
        return self.selected:set_position(self.x, self.y)
      end
    end,
    draw = function(self)
      if self.selected then
        return self.selected:draw()
      end
    end,
    did_click_train = function(self, x, y)
      local _list_0 = game.trains
      for _index_0 = 1, #_list_0 do
        local train = _list_0[_index_0]
        local train_x = train.x - (DOMINOE_WIDTH / 2)
        local train_y = train.y - (HALF_IMAGE_OFFSET)
        local height
        if #train.dominoes == 0 then
          height = DOMINOE_HEIGHT
        else
          height = #train.dominoes * DOMINOE_HEIGHT
        end
        if x >= train_x and x <= train_x + DOMINOE_WIDTH and y >= train_y and y <= train_y + height then
          return train
        end
      end
      return false
    end,
    did_click_hand = function(self, x, y)
      local index = 0
      local answer = nil
      local _list_0 = self.player.hand
      for _index_0 = 1, #_list_0 do
        local dominoe = _list_0[_index_0]
        local dominoe_x = dominoe.x - (DOMINOE_WIDTH / 2)
        local dominoe_y = dominoe.y - (DOMINOE_HEIGHT / 2)
        if x >= dominoe_x and x <= dominoe_x + DOMINOE_WIDTH and y >= dominoe_y and y <= dominoe_y + DOMINOE_HEIGHT then
          print("clicked on this dominoe " .. tostring(dominoe))
          answer = dominoe
          break
        end
        index = index + 1
      end
      return answer
    end,
    click_mouse = function(self, x, y, button)
      if button == 1 then
        if self.selected then
          local train = self:did_click_train(x, y)
          if train and train:can_connect(self.selected, game.current_double) then
            self.player:remove_dominoe(self.selected)
            print("adding " .. tostring(self.selected) .. " to the train")
            train:add_dominoe(self.selected)
          end
          self.selected = nil
        else
          local dominoe = self:did_click_hand(x, y)
          if dominoe then
            self.selected = dominoe
          end
        end
      elseif button == 2 then
        if self.selected then
          self.selected.flipped = not self.selected.flipped
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, player)
      self.player = player
      self.selected = nil
      self.x = nil
      self.y = nil
    end,
    __base = _base_0,
    __name = "Mouse"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Mouse = _class_0
end
return {
  Mouse = Mouse
}
