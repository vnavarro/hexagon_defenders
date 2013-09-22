Utils = require "utils"

class ShipBullet
  new:(sX,sY,sAngle) =>
    @x = sX
    @y = sY
    @speed = 200
    @angle = sAngle
    @width = 10
    @height = 10

  draw: =>
    Utils.rotateAroundCenter(@angle)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", @x+@width/2, @y, @width, @height)
    Utils.rotateAroundCenter(-@angle)

  update: (dt) =>
    currentSpeed = (@speed * dt)
    @y -= currentSpeed

  shouldDie: =>    
    -- math.abs(@y) > Utils.screenWidth
    @y < -200 or @y > Utils.screenWidth + 100
