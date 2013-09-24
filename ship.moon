Utils = require "utils"
ShipBullet = require "shipbullet"

class Ship
  new: (sX,sY) =>
    @x = sX
    @y = sY
    @angle = 0
    @shoots = {}
    @step = 0

  move: =>
    -- @step += 0.05
    -- @step = @step % (2*math.pi)
    spXOld, spYOld = @x,@y
    @x = Utils.screenWidth/2 - 10  + ((100+20)*math.sin(@step))
    @y = Utils.screenHeight/2 - 10 - ((100+20)*math.cos(@step))


    dBC = math.sqrt(math.pow(@x-spXOld,2)+math.pow(@y-spYOld,2))
    aX,aY = Utils.screenWidth/2,Utils.screenHeight/2
    dAC = math.sqrt(math.pow(@x-aX,2)+math.pow(@y-aY,2))
    angularCoeficient = (@y-aY)/(@x-aX)
    tangAngle = 1/angularCoeficient --dBC / dAC    
    -- @angle += math.atan(tangAngle)
    -- @angle = @angle % (2*math.pi)

  rotateAroundCenter:(back) =>
    love.graphics.translate(@x+10,@y+10)
    if back
      love.graphics.rotate(-@angle)
    else
      love.graphics.rotate(@angle)
    love.graphics.translate(-(@x+10),-(@y+10))


  draw: =>
    for i=1,#@shoots do
      @shoots[i]\draw!
    @rotateAroundCenter false
    
    love.graphics.setColor(255, 255, 0)
    love.graphics.rectangle("fill", @x, @y, 20, 20)     

    @rotateAroundCenter true

    -- love.graphics.translate(@x+10,@y+10)
    -- love.graphics.rotate(-@angle)    
    -- love.graphics.translate(-(@x+10),-(@y+10))    

  update: (dt) =>
    for i=#@shoots,1,-1 do
      bullet = @shoots[i]
      if bullet\shouldDie! or bullet.destroy then
        @destroyBullet i
      else 
        bullet\update dt

  goRight: =>
    @angle += 0.025
    @angle = @angle % (2*math.pi)

    @step += 0.025
    @step = @step % (2*math.pi)
    @move!

  goLeft: =>
    @angle -= 0.025
    @angle = @angle % (2*math.pi)

    @step -= 0.025
    @step = @step % (2*math.pi)
    @move!
    
  shoot: =>
    @shoots[#@shoots+1] = ShipBullet(@x,@y,@angle)

  destroyBullet: (position) =>
    @markBulletToDestroy position
    table.remove(@shoots,position)

  markBulletToDestroy: (position) =>
    @shoots[position].destroy = true
