Utils = require "utils"
Menu = require "menu"
Level = require "level"

GAME_SCREENS = {menu: 0,game: 1,ranking: 2}

-- Game Variables
local currentScreenObject
local currentScreen
local bgMusic
local audioOn

isAtMenu = ->
  currentScreen ==  GAME_SCREENS.menu

setAtGame = ->
  currentScreen =  GAME_SCREENS.game

setAtMenu = ->
  currentScreen =  GAME_SCREENS.menu

openGame = ->
  Utils.gameStatus = Utils.GAME_STATUS.GAME
  currentScreenObject = Level()

openMenu = ->
  -- start\stop!
  -- start\rewind!        
  setAtMenu!
  currentScreenObject = Menu openGame

love.load = ->  
  -- font = love.graphics.newImageFont("resources/imagefont.png"," abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"")
  -- font = love.graphics.newFont("resources/Boxy-Bold.ttf",20)  
  -- love.graphics.setFont(font)
  audioOn = true
  -- bgMusic = love.audio.newSource("resources/bouncing_baal.mp3")
  -- bgMusic\setLooping true
  -- bgMusic\setVolume 0.65
  -- die = love.audio.newSource("resources/die.wav", "static")
  -- foodPick = love.audio.newSource("resources/food_pick.wav", "static")
  -- start = love.audio.newSource("resources/start.wav", "static")
  -- love.audio.play(bgMusic)  
  openMenu!  

love.update = (dt) ->
  currentScreenObject\update(dt)

love.draw = ->  
  currentScreenObject\draw!

love.keypressed = (key,u) ->
  if key == "lctrl" then --set to whatever key you want to use
    debug.debug()  
  if Utils.gameStatus == Utils.GAME_STATUS.GAME    
    currentScreenObject\keypressed (key)
  if Utils.gameStatus == Utils.GAME_STATUS.MENU
    if key == "down"
      currentScreenObject\movedown!
    elseif key == "up"
      currentScreenObject\moveup!
    elseif key == "return"
      currentScreenObject\enter!
  if key == "s" then    
    audioOn = not audioOn
    if audioOn then      
      bgMusic\setVolume 0.65
      die\setVolume 1.0
      foodPick\setVolume 1.0
      start\setVolume 1.0
    else
      bgMusic\setVolume 0
      die\setVolume 0
      foodPick\setVolume 0
      start\setVolume 0
    
