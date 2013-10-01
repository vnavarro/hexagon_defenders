Utils = require "utils"
Ship = require "ship"
Planet = require "planet"
Enemy = require "enemy"

class Level

  new: (menuCallback) =>    
    @circleRadius = 100
    @step = 0
    @angle = 0
    @shoot = false
    @sAngle = 0
    @score = 0

    @timerStart = love.timer.getTime()
    @timerCountdown = 4

    @accelTimer = love.timer.getTime()
    @accelTimerCountdown = 10

    @counter = 0
    @counterLimit = 2

    @enemiesList = {}

    spX = Utils.screenWidth/2 - 10  + ((@circleRadius+20)*math.sin(@step))
    spY = Utils.screenHeight/2 - 10 - ((@circleRadius+20)*math.cos(@step))

    @hexaShip = Ship(spX,spY)
    @planet = Planet!
    @hudFont = love.graphics.newFont("Hexa.ttf",18)

  generateEnemy: =>
    enemy = Enemy!
    @enemiesList[#@enemiesList+1] = enemy

  isInsidePlanet: (sprite) =>
    math.pow((sprite.x - Utils.screenCenterX),2) + math.pow((sprite.y - Utils.screenCenterY),2) < math.pow(@circleRadius,2)

  updateScore: =>
    @score += 10

  keypressed: (key) =>
    if key == " "
      @shoot = true
    if key == "p"
      if Utils.gameStatus == Utils.GAME_STATUS.PAUSE
        Utils.gameStatus = Utils.GAME_STATUS.GAME
      else
        Utils.gameStatus = Utils.GAME_STATUS.PAUSE
    if key == "escape"
      openMenu!
  
  update: (dt) =>
    @timerCurrent = love.timer.getTime()
    return if Utils.gameStatus != Utils.GAME_STATUS.GAME

    if @shoot then
      @hexaShip\shoot!
      @shoot = false

    if love.keyboard.isDown("left") 
      @hexaShip\goLeft!
    elseif love.keyboard.isDown("right")
      @hexaShip\goRight!
    @hexaShip\update dt    
    
    if @timerCurrent - @accelTimer >= @accelTimerCountdown then
      @generateEnemy!
      @timerStart = love.timer.getTime()

    if @timerCurrent - @accelTimer >= @accelTimerCountdown then
      @generateEnemy!
      @accelTimer = love.timer.getTime()

    for i=#@enemiesList,1,-1 do    
      @currentEnemy = @enemiesList[i]
      if @isInsidePlanet @currentEnemy then
        @planet\hit!
        @currentEnemy\destroy!
        table.remove(@enemiesList,i)         
      else
        for i=#@hexaShip.shoots,1,-1 do
          if @currentEnemy.isDead == false and @currentEnemy\collidesWithSprite @hexaShip.shoots[i] then
            print "Should destroy enemy and bullet!"
            @currentEnemy\destroy!
            table.remove(@enemiesList,i)
            @hexaShip\markBulletToDestroy i
            @updateScore!
        @currentEnemy\update dt 

    if @planet.energy <= 0
      Utils.gameStatus = Utils.GAME_STATUS.GAMEOVER
      openMenu!

  drawHud: =>
    love.graphics.setFont @hudFont
    love.graphics.setColor(255,255,255)
    love.graphics.printf "Decagon energy:", 10, 20, 240, "left"
    love.graphics.printf @planet.energy, 145, 20, 100, "left"
    love.graphics.printf "Score:", 200, 20, 100, "left" 
    love.graphics.printf @score, 250, 20, 100, "left" 

  draw: =>
    -- return if Utils.gameStatus != Utils.GAME_STATUS.GAME

    @planet\draw!

    @hexaShip\draw!
    for i=#@enemiesList,1,-1 do
      @enemiesList[i]\draw!

    @drawHud!