Utils = require "utils"

class ShipBullet
  new:(sX,sY,sAngle) =>
    @x = sX
    @y = sY
    @speed = 200
    @angle = sAngle

  draw: =>
    Utils.rotateAroundCenter(@angle)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", @x, @y, 20, 20)
    Utils.rotateAroundCenter(-@angle)

  update: (dt) =>
    currentSpeed = (@speed * dt)
    @y -= currentSpeed

  shouldDie: =>    
    -- math.abs(@y) > Utils.screenWidth
    @y < -200 or @y > Utils.screenWidth + 100
