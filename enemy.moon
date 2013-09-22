Utils = require "utils"

LEFT, TOP, RIGHT, BOTTOM = 1,2,3,4

class Enemy
  new:() =>
    math.randomseed(os.time())
    @color = {r:math.random(0,255),g:math.random(0,255),b:math.random(0,255)}
    @angle = math.random(0,2*math.pi)
    @width,@height = 20,20
    @generatePosition!
    @speed = 50
    @isDead = false

  generatePosition: =>
    @side = math.random(4)
    xLowerLimit, xUpperLimit, yLowerLimit, yUpperLimit = 0
    if @side == LEFT then
      xLowerLimit, xUpperLimit = -(@width*2),0
      yLowerLimit, yUpperLimit = @height,Utils.screenHeight-@height
    else if @side == TOP then
      xLowerLimit, xUpperLimit = 0,Utils.screenWidth
      yLowerLimit, yUpperLimit = -(@height*2),0
    else if @side == RIGHT then
      xLowerLimit, xUpperLimit = Utils.screenWidth,Utils.screenWidth+(@width*2)
      yLowerLimit, yUpperLimit = 0,Utils.screenHeight
    else if @side == BOTTOM then
      xLowerLimit, xUpperLimit = 0,Utils.screenWidth
      yLowerLimit, yUpperLimit = Utils.screenHeight,Utils.screenHeight+(@height*2)

    @x,@y = math.random(xLowerLimit,xUpperLimit), math.random(yLowerLimit,yUpperLimit)

  destroy: =>
    @isDead = true

  draw: =>
    return if @isDead

    love.graphics.setColor(@color.r, @color.g, @color.b)
    love.graphics.rectangle("fill", @x, @y, @width, @height)

  update:(dt)=>
    return if @isDead
    @move dt

  move:(dt) =>
    dx = Utils.screenCenterX - @x
    dy = Utils.screenCenterY - @y
    length = math.sqrt dx*dx + dy*dy
     -- normalize (make it 1 unit length)
    dx /= length 
    dy /= length
    -- scale to our desired speed
    dx *= (@speed * dt)
    dy *= (@speed * dt)
    @x += dx
    @y += dy
    -- if @side == LEFT then
    --   -- @x += @speed * dt

    --   dx = Utils.screenCenterX - @x
    --   dy = Utils.screenCenterY - @y
    --   length = math.sqrt dx*dx + dy*dy
    --    -- normalize (make it 1 unit length)
    --   dx /= length 
    --   dy /= length
    --   -- scale to our desired speed
    --   dx *= (@speed * dt)
    --   dy *= (@speed * dt)
    --   @x += dx
    --   @y += dy

    -- else if @side == TOP then
    --   -- @x -= @speed * dt
    -- else if @side == RIGHT then
    --   @x -= @speed * dt
    -- else if @side == BOTTOM then
    --   @x -= @speed * dt
