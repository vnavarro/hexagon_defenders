Ship = require "ship"

--Game Variables
squareRotation = 0
squarePositon = {x: 10,y: 10}
circleRadius = 100
step = 0
export screenWidth = love.graphics.getWidth()
export screenHeight = love.graphics.getHeight()
angle = 0
shoot = false
sAngle = 0

rotateAroundCenter = (angle) ->
    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-screenWidth/2, -screenHeight/2)

spX = screenWidth/2 - 10  + ((circleRadius+20)*math.sin(step))
spY = screenHeight/2 - 10 - ((circleRadius+20)*math.cos(step))
spXOld, spYOld = spX,spY

hexaShip = Ship(spX,spY)

love.update = (dt) -> 
  if love.keyboard.isDown("left") 
    hexaShip\goLeft!
  else if love.keyboard.isDown("right")
    hexaShip\goRight!
  hexaShip\update dt


--http://www.mathsisfun.com/algebra/line-equation-2points.html
--http://www.brasilescola.com/matematica/distancia-entre-dois-pontos.htm

--http://www.physicsclassroom.com/mmedia/circmot/ucm.cfm
--http://stackoverflow.com/questions/3273396/animate-sprite-along-a-curve-path-in-xna
--http://www.physicsclassroom.com/class/circles/u6l1e.cfm
--http://physics.stackexchange.com/questions/10777/position-in-circular-motion
--http://fooplot.com/#W3sidHlwZSI6MiwiZXF4IjoiMnNpbihzKSIsImVxeSI6IjJjb3MocykiLCJjb2xvciI6IiNmZjAwMDAiLCJzbWluIjoiMCIsInNtYXgiOiIycGkiLCJzc3RlcCI6Ii4wMSJ9LHsidHlwZSI6MywiZXEiOltbInNpbigxKSIsImNvcygxKSJdLFsiMiIsIjIiXV0sImNvbG9yIjoiIzAwMDAwMCJ9LHsidHlwZSI6MTAwMCwid2luZG93IjpbIi01Ljg4IiwiNy4xMiIsIi0zLjciLCI0LjMiXX1d
love.draw = ->  
  hexaShip\draw!

  love.graphics.setColor(255, 255, 255)
  love.graphics.circle( "fill", screenWidth/2, screenHeight/2, circleRadius, 100 )
  
  if shoot then
    hexaShip\shoot!
    shoot = false


love.keypressed = (key,u) ->
   --Debug
  if key == "lctrl" then --set to whatever key you want to use
    debug.debug()  
  if key == " " then
    shoot = true
    print "shoot"
  if key == "return" then
    -- step += 0.05
    -- step = step % (2*math.pi)
    -- spXOld, spYOld = spX,spY
    -- spX = screenWidth/2 - 10  + ((circleRadius+20)*math.sin(step))
    -- spY = screenHeight/2 - 10 - ((circleRadius+20)*math.cos(step))
    dBC = math.sqrt(math.pow(spX-spXOld,2)+math.pow(spY-spYOld,2))
    aX,aY = screenWidth/2,screenHeight/2
    dAC = math.sqrt(math.pow(spX-aX,2)+math.pow(spY-aY,2))
    angularCoeficient = (spY-aY)/(spX-aX)
    tangAngle = 1/angularCoeficient --dBC / dAC
    angle += 0.05 --math.atan(tangAngle)
    angle = angle % (2*math.pi)
    print angle,math.deg(angle)












