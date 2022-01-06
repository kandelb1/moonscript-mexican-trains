export class Entity
  new: (@x = 0, @y = 0, @width = 0, @height = 0) =>

  set_position: (x, y) =>
    @x = x
    @y = y

  get_center_point: =>
    x = (@x + (@width / 2))
    y = (@y + (@height / 2))
    return x, y

{ :Entity }