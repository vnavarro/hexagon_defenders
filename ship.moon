Utils = require "utils"

class Ship
  new: (sX,sY) =>
    @x = sX
    @y = sY
    @angle = 0

  draw: =>
    Utils.rotateAroundCenter(@angle)
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", @x, @y, 20, 20) 
    Utils.rotateAroundCenter(-@angle)

  update: (dt) =>

  goRight: =>
    @angle += 0.05
    @angle = @angle % (2*math.pi)

  goLeft: =>
    @angle -= 0.05
    @angle = @angle % (2*math.pi)
    