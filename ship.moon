Utils = require "utils"
ShipBullet = require "shipbullet"

class Ship
  new: (sX,sY) =>
    @x = sX
    @y = sY
    @angle = 0
    @shoots = {}

  draw: =>
    Utils.rotateAroundCenter(@angle)
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", @x, @y, 20, 20)     
    Utils.rotateAroundCenter(-@angle)
    for i=1,#@shoots do
      @shoots[i]\draw!

  update: (dt) =>
    for i=#@shoots,1,-1 do
      bullet = @shoots[i]
      if bullet\shouldDie! then
        table.remove(@shoots,i)
      else 
        bullet\update dt

  goRight: =>
    @angle += 0.05
    @angle = @angle % (2*math.pi)

  goLeft: =>
    @angle -= 0.05
    @angle = @angle % (2*math.pi)
    
  shoot: =>
    @shoots[#@shoots+1] = ShipBullet(@x,@y-25,@angle)
