export class Move
  new: (@train, @dominoe) =>
    @draw = false
    @double = false
    @double = @dominoe\is_double! if @dominoe

  make_draw: =>
    @draw = true
    return self

  is_draw: => @draw

  is_double: => @double

  __tostring: => "Placing dominoe #{@dominoe} on train with dval #{@train\get_exposed_dval!}"

{ :Move }
  