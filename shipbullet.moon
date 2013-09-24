Utils = require "utils"

class ShipBullet
  new:(sX,sY,sAngle) =>
    @x = sX
    @y = sY
    @speed = 220
    @angle = sAngle
    @width = 5
    @height = 5
    @destroy = false

  draw: =>
    -- Utils.rotateAroundCenter(@angle)
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", @x+10, @y, @width, @height)
    -- Utils.rotateAroundCenter(-@angle)

  update: (dt) =>    
    currentSpeed = (@speed * dt)
    -- @y -= currentSpeed
    @move dt

  shouldDie: =>    
    return @destroy if @destroy
    @destroy = @y < -200 or @y > Utils.screenWidth + 100
    return @destroy

  move:(dt) =>
    @x += @speed * dt * math.sin @angle
    @y -= @speed * dt * math.cos @angle