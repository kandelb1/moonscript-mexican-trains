import insert from table

test_bool = (bool, pos_val, neg_val) -> pos_val if bool else neg_val

export class BaseElement
  new: (@x, @y, @callback) =>
  
  did_click: (x, y) => error "Function not implemented in base class"

  execute: => @callback! if @callback

export class TextElement
  new: (x, y, @text, @font, @centered, @callback) =>
    super(x, y, @callback)

  draw: => 
    love.graphics.setFont(@font)
    if @centered
      width = love.graphics.getFont!\getWidth(@text)
      love.graphics.print(@text, @x - (width / 2), @y)
    else
      love.graphics.print(@text, @x, @y)

export class BoxElement extends BaseElement
  new: (x, y, @width, @height, @callback) =>
    super(x, y, @callback)
    @fill = false

  draw: => love.graphics.rectangle(test_bool(@fill, "fill", "line"), @x, @y, @width, @height)

  did_click: (x, y) => x >= @x and x <= @x + @width and y >= @y and y <= @y + @height

  set_fill: (fill) => @fill = fill

  get_center_point: =>
    center_x = @x + (@width / 2)
    center_y = @y + (@height / 2)
    return center_x, center_y

export class UI
  huge_font: love.graphics.newFont(24)
  big_font: love.graphics.newFont(18)
  normal_font: love.graphics.getFont!
  small_font: love.graphics.newFont(13)

  new: () => 
    @elements = {}
    @names = {}

  add_element: (name, element) => 
    @elements[name] = element
    insert(@names, name)

  draw: =>
    for name in *@names
      @elements[name]\draw!

  update: (dt) =>
    for name in *@names
      @elements[name]\update dt

  click_mouse: (x, y) =>
    for name in *@names
      with element = @elements[name]
        element.execute! if element\did_click(x, y)
  
{ :UI, :BaseElement, :BoxElement, :TextElement }