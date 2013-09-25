Ship = require "ship"
Enemy = require "enemy"
Utils = require "utils"
Planet = require "planet"

--Game Variables
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

isInsidePlanet = (sprite) ->
  math.pow((sprite.x - Utils.screenCenterX),2) + math.pow((sprite.y - Utils.screenCenterY),2) < math.pow(circleRadius,2)

generateEnemy = ->
  enemy = Enemy()
  enemiesList[#enemiesList+1] = enemy

spX = Utils.screenWidth/2 - 10  + ((circleRadius+20)*math.sin(step))
spY = Utils.screenHeight/2 - 10 - ((circleRadius+20)*math.cos(step))
spXOld, spYOld = spX,spY

hexaShip = Ship(spX,spY)
planet = Planet()

love.update = (dt) -> 
  if love.keyboard.isDown("left") 
    hexaShip\goLeft!
  elseif love.keyboard.isDown("right")
    hexaShip\goRight!
  hexaShip\update dt

  timerCurrent = love.timer.getTime()
  if timerCurrent - timerStart >= timerCountdown then
    generateEnemy!
    timerStart = love.timer.getTime()

  for i=#enemiesList,1,-1 do    
    currentEnemy = enemiesList[i]
    if isInsidePlanet currentEnemy then
      planet\hit!
      currentEnemy\destroy!
      table.remove(enemiesList,i)         
    else
      for i=#hexaShip.shoots,1,-1 do
        if currentEnemy.isDead == false and currentEnemy\collidesWithSprite hexaShip.shoots[i] then
          print "Should destroy enemy and bullet!"
          currentEnemy\destroy!
          table.remove(enemiesList,i)
          hexaShip\markBulletToDestroy i
      currentEnemy\update dt      

love.draw = ->  
  planet\draw!

  hexaShip\draw!
  for i=#enemiesList,1,-1 do
    enemiesList[i]\draw!
  
  if shoot then
    hexaShip\shoot!
    shoot = false

  love.graphics.printf "Hex-a-gon energy:", 10, 20, 250, "left"
  love.graphics.printf planet.energy, 150, 20, 100, "left"


love.keypressed = (key,u) ->
   --Debug
  if key == "lctrl" then --set to whatever key you want to use
    debug.debug()  
  if key == " " then
    shoot = true












