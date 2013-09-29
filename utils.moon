Utils = {}

Utils.screenWidth = love.graphics.getWidth()
Utils.screenHeight = love.graphics.getHeight()
Utils.screenCenterX = Utils.screenWidth/2
Utils.screenCenterY = Utils.screenHeight/2

Utils.GAME_STATUS = {
  MENU: 1,
  GAME: 2,
  PAUSE: 3,
  GAMEOVER: 4
}
Utils.gameStatus = Utils.GAME_STATUS.MENU

Utils.rotateAroundCenter = (angle) ->
    love.graphics.translate(Utils.screenWidth/2, Utils.screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-Utils.screenWidth/2, -Utils.screenHeight/2)

return Utils