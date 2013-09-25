Utils = require "utils"

class Planet

  new: =>
    @energy = 100
    @x = Utils.screenWidth/2
    @y = Utils.screenHeight/2
    @radius = 100
    @segments = 6

  draw: =>
    love.graphics.setColor(255, 255, 255, 50)
    love.graphics.circle( "line", @x, @y, @radius+20, 100 )
    love.graphics.setColor(255, 255, 255, 150)
    love.graphics.circle( "line", @x, @y, @radius+10, 100 )
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle( "fill", @x, @y, @radius, @segments )

  hit: =>
    @energy -= 5

