Ship = require "ship"
Enemy = require "enemy"
Utils = require "Utils"

--Game Variables
squareRotation = 0
squarePositon = {x: 10,y: 10}
circleRadius = 100
step = 0
angle = 0
shoot = false
sAngle = 0

rotateAroundCenter = (angle) ->
    love.graphics.translate(Utils.screenWidth/2, Utils.screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-Utils.screenWidth/2, -Utils.screenHeight/2)

isInsidePlanet = (sprite) ->
  math.pow((sprite.x - Utils.screenCenterX),2) + math.pow((sprite.y - Utils.screenCenterY),2) < math.pow(circleRadius,2)

spX = Utils.screenWidth/2 - 10  + ((circleRadius+20)*math.sin(step))
spY = Utils.screenHeight/2 - 10 - ((circleRadius+20)*math.cos(step))
spXOld, spYOld = spX,spY

hexaShip = Ship(spX,spY)
enemy = Enemy()

love.update = (dt) -> 
  if love.keyboard.isDown("left") 
    hexaShip\goLeft!
  else if love.keyboard.isDown("right")
    hexaShip\goRight!
  hexaShip\update dt

  if isInsidePlanet enemy then
    print "Inside"
    -- TODO: planet class
    -- planet\removeEnergy!
    -- end
    enemy\destroy!
  else
    enemy\update dt
    -- print "Enemy:",enemy.x,enemy.y


--http://www.mathsisfun.com/algebra/line-equation-2points.html
--http://www.brasilescola.com/matematica/distancia-entre-dois-pontos.htm

--http://www.physicsclassroom.com/mmedia/circmot/ucm.cfm
--http://stackoverflow.com/questions/3273396/animate-sprite-along-a-curve-path-in-xna
--http://www.physicsclassroom.com/class/circles/u6l1e.cfm
--http://physics.stackexchange.com/questions/10777/position-in-circular-motion
--http://fooplot.com/#W3sidHlwZSI6MiwiZXF4IjoiMnNpbihzKSIsImVxeSI6IjJjb3MocykiLCJjb2xvciI6IiNmZjAwMDAiLCJzbWluIjoiMCIsInNtYXgiOiIycGkiLCJzc3RlcCI6Ii4wMSJ9LHsidHlwZSI6MywiZXEiOltbInNpbigxKSIsImNvcygxKSJdLFsiMiIsIjIiXV0sImNvbG9yIjoiIzAwMDAwMCJ9LHsidHlwZSI6MTAwMCwid2luZG93IjpbIi01Ljg4IiwiNy4xMiIsIi0zLjciLCI0LjMiXX1d
love.draw = ->  
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle( "fill", Utils.screenWidth/2, Utils.screenHeight/2, circleRadius, 100 )

  hexaShip\draw!
  enemy\draw!
  
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












