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

timerStart = love.timer.getTime()
timerCountdown = 4

counter = 0
counterLimit = 2

enemiesList = {}

rotateAroundCenter = (angle) ->
    love.graphics.translate(Utils.screenWidth/2, Utils.screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-Utils.screenWidth/2, -Utils.screenHeight/2)

isInsidePlanet = (sprite) ->
  math.pow((sprite.x - Utils.screenCenterX),2) + math.pow((sprite.y - Utils.screenCenterY),2) < math.pow(circleRadius,2)

generateEnemy = ->
  enemy = Enemy()
  enemiesList[#enemiesList+1] = enemy

spX = Utils.screenWidth/2 - 10  + ((circleRadius+20)*math.sin(step))
spY = Utils.screenHeight/2 - 10 - ((circleRadius+20)*math.cos(step))
spXOld, spYOld = spX,spY

hexaShip = Ship(spX,spY)

love.update = (dt) -> 
  if love.keyboard.isDown("left") 
    hexaShip\goLeft!
  else if love.keyboard.isDown("right")
    hexaShip\goRight!
  hexaShip\update dt

  timerCurrent = love.timer.getTime()
  if timerCurrent - timerStart >= timerCountdown then
    generateEnemy!
    timerStart = love.timer.getTime()

  for i=#enemiesList,1,-1 do    
    currentEnemy = enemiesList[i]
    if isInsidePlanet currentEnemy then
      -- TODO: planet class
      -- planet\removeEnergy!
      -- end    
      currentEnemy\destroy!
      table.remove(enemiesList,i)   
    else
      currentEnemy\update dt

love.draw = ->  
  love.graphics.setColor(255, 255, 255)
  love.graphics.circle( "fill", Utils.screenWidth/2, Utils.screenHeight/2, circleRadius, 100 )

  hexaShip\draw!
  for i=#enemiesList,1,-1 do
    enemiesList[i]\draw!
  
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












