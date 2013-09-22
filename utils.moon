Utils = {}

Utils.screenWidth = love.graphics.getWidth()
Utils.screenHeight = love.graphics.getHeight()
Utils.screenCenterX = Utils.screenWidth/2
Utils.screenCenterY = Utils.screenHeight/2

Utils.rotateAroundCenter = (angle) ->
    love.graphics.translate(Utils.screenWidth/2, Utils.screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-Utils.screenWidth/2, -Utils.screenHeight/2)

return Utils