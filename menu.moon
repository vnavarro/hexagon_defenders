Utils = require "utils"

class Menu
  new: (openGameDelegate) =>
    @bgImg = ""
    @generateItens!
    @openGameDelegate = openGameDelegate
    @bg = love.graphics.newImage("mainmenubg.png")
    @creditsFont = love.graphics.newFont("Hexa.ttf",20)
    @menuFont = love.graphics.newFont("Hexa.ttf",30)    

  generateItens: =>
    @items = {}
    @items[#@items+1] = "Endeless mode"
    @items[#@items+1] = "Normal mode"
    -- @items[#@items+1] = "Credits"
    @items[#@items+1] = "Exit"
    @currentSelectedItem = 0

  draw: =>
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(@bg, 0,0)
    for i=1,#@items do
      if i == @currentSelectedItem+1
        love.graphics.setColor(0, 255, 255)
      elseif i > 1 and i != #@items
        love.graphics.setColor(0, 0, 0)
      else
        love.graphics.setColor(255, 255, 255)
      love.graphics.setFont @menuFont
      love.graphics.printf @items[i], 100, 300 + ((i - 1) * 30), Utils.screenWidth, "left"
      @drawCredits!

  drawCredits: =>    
    love.graphics.setFont @creditsFont
    love.graphics.setColor 62,249,0
    love.graphics.printf "Created by Vitor Navarro www.vnavarro.com.br for OGAM August 2013", 0, love.graphics.getHeight! - 55, 800, "center"    
    -- love.graphics.printf "Bouncing Baal music by FoxSynergy", 0, love.graphics.getHeight! - 45, 800, "center"    
    love.graphics.printf "Created with Love2D www.love2d.org", 0, love.graphics.getHeight! - 25, 800, "center" 

  update: =>

  moveup: =>
    @currentSelectedItem -= 1
    @currentSelectedItem %= #@items

  movedown: =>
    @currentSelectedItem += 1
    @currentSelectedItem %= #@items

  enter: =>
    if @items[@currentSelectedItem + 1] == "Endeless mode"
      @openGameDelegate!
    elseif @items[@currentSelectedItem+1] == "Exit"
      love.event.quit()