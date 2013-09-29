Utils = require "utils"

class Menu
  new: (openGameDelegate) =>
    @bgImg = ""
    @generateItens!
    @openGameDelegate = openGameDelegate

  generateItens: =>
    @items = {}
    @items[#@items+1] = "Endeless mode"
    @items[#@items+1] = "Normal mode"
    @items[#@items+1] = "Credits"
    @items[#@items+1] = "Exit"
    @currentSelectedItem = 0

  draw: =>
    for i=1,#@items do
      if i == @currentSelectedItem+1
        love.graphics.setColor(0, 255, 255)
      else
        love.graphics.setColor(255, 255, 255)
      love.graphics.printf @items[i], 0, 400 + ((i - 1) * 20), Utils.screenWidth, "center"
      love.graphics.printf @currentSelectedItem, 0, 350, Utils.screenWidth, "center"

  update: =>

  moveup: =>
    @currentSelectedItem -= 1
    @currentSelectedItem %= #@items

  movedown: =>
    @currentSelectedItem += 1
    @currentSelectedItem %= #@items

  enter: =>
    if @currentSelectedItem + 1 == #@items - 3
      @openGameDelegate!
    elseif @currentSelectedItem + 1 == #@items - 2      
      --TODO: NOT PLAYABLE
      print 2
    elseif @currentSelectedItem + 1 == #@items - 1
      --TODO: NOT PLAYABLE
      print 3
    elseif @currentSelectedItem + 1 == #@items
      love.event.quit()