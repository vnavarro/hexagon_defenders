Utils = {}

Utils.screenWidth = love.graphics.getWidth()
Utils.screenHeight = love.graphics.getHeight()

Utils.rotateAroundCenter = (angle) ->
    love.graphics.translate(screenWidth/2, screenHeight/2)
    love.graphics.rotate(angle)
    love.graphics.translate(-screenWidth/2, -screenHeight/2)

return Utils