walkingFramesRight = {}
walkingFramesLeft = {}
walkingFramesUp = {}
walkingFramesDown = {}
activeFrame = 0
currentFrame = 2
elapsedTime = 0
elapsedTime2 = 0
player_x = 64
player_y = 900
playerSpeed = 200
enemySpeed = 200
isWalking = false
enemy_x = 320 -- 640x640 jest zjebane lokacja poczatkowa
enemy_y = 640
portal_x = 64
portal_y = 64
kickback  = 12
DirectionChange = false

local text = {}

function love.load()
HC = require 'HC'
require 'SpriteFunctions'
--loadfile 'SpriteFunctions.lua'()
scale = 'adaptive'
  rectPlayer = HC.rectangle(player_x,player_y,32,64)
  rectEnemy = HC.rectangle(enemy_x,enemy_y,64,64)

  rectFloor = HC.rectangle(player_x ,player_y - 200,1200,16)
  rectFloor2 = HC.rectangle(player_x + 50,player_y - 500,1200,16)
  rectFloor3 = HC.rectangle(player_x + 100,player_y - 800,1200,16)

  rectPortal = HC.rectangle(player_x + 150,player_y ,64,64)
  rectPortal2 = HC.rectangle(player_x + 24,player_y-264 ,64,64)
  rectPortal3 = HC.rectangle(player_x + 500,player_y-564 ,64,64)

  rectPortalExit = HC.rectangle(player_x + 1200, player_y-864 ,64,64)
  rectPortalReplay = HC.rectangle(player_x + 100, player_y - 864, 64, 64)

  rectBoxUp = HC.rectangle(0,-1,1920,1)       --0,-1, ,
  rectBoxDown = HC.rectangle (0,1080,1920,1) --0,1080,  ,
  rectBoxLeft = HC.rectangle (-1,0,1,1080)    -- ,-1,0, ,
  rectBoxRight = HC.rectangle(1920,0,1,1080)  --1920,0

local PNGs do
    background = love.graphics.newImage("background.png")
    player = love.graphics.newImage("hummy64x64.png")
    enemy = love.graphics.newImage("enemy64x64.png")
    portal = love.graphics.newImage("portal.png")
    portalExit = love.graphics.newImage("portalblue.png")
    portalReplay = love.graphics.newImage("portalyellow.png")
end
local Frames do
    walkingFramesDown[1] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesDown[2] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesDown[3] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesDown[4] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())

    walkingFramesUp[1] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesUp[2] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesUp[3] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesUp[4] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())

    walkingFramesRight[1] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesRight[2] = love.graphics.newQuad(64, 0, 64, 64, player:getDimensions())
    walkingFramesRight[3] = love.graphics.newQuad(128, 0, 64, 64, player:getDimensions())
    walkingFramesRight[4] = love.graphics.newQuad(192, 0, 64, 64, player:getDimensions())
    walkingFramesRight[5] = love.graphics.newQuad(256, 0, 64, 64, player:getDimensions())
    walkingFramesRight[6] = love.graphics.newQuad(640, 0, 64, 64, player:getDimensions())
    walkingFramesRight[7] = love.graphics.newQuad(384, 0, 64, 64, player:getDimensions())
    walkingFramesRight[8] = love.graphics.newQuad(448, 0, 64, 64, player:getDimensions())

    walkingFramesLeft[1] = love.graphics.newQuad(0, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[2] = love.graphics.newQuad(64, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[3] = love.graphics.newQuad(128, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[4] = love.graphics.newQuad(192, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[5] = love.graphics.newQuad(256, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[6] = love.graphics.newQuad(640, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[7] = love.graphics.newQuad(384, 64, 64, 64, player:getDimensions())
    walkingFramesLeft[8] = love.graphics.newQuad(448, 64, 64, 64, player:getDimensions())

    activeFrame = walkingFramesDown[currentFrame]
  end
end

function love.update(dt)

     --end

     while #text > 40 do
          table.remove(text, 1)
      end
      -- FULL SCREEN, ZAMYKAĆ ESC
      if love.keyboard.isDown("escape") then
          love.event.quit(0)
        end
      --if love.keyboard.isDown('r') then
      --  Replay()
      --end
      love.window.setFullscreen(true, "desktop")
    elapsedTime = elapsedTime + dt
    elapsedTime2 = elapsedTime2 + dt

    while  (elapsedTime2 > 0.01) do
          enemy_x = enemy_x + enemySpeed * dt
          rectEnemy:moveTo(enemy_x + 32,enemy_y + 32)
          elapsedTime2 = 0
          if enemy_x > 1000 then
            enemySpeed = -enemySpeed
          end
          if enemy_x < 300 then
            enemySpeed = -enemySpeed
          end
      end


    if love.keyboard.isDown("right") or love.keyboard.isDown('d') then
      if rectPlayer:collidesWith(rectEnemy) then
          EnemyCollision()
      end
      if rectPlayer:collidesWith(rectPortal) then
          PortalCollision()
      end
      if rectPlayer:collidesWith(rectPortal2) then
          PortalCollision1()
      end
      if rectPlayer:collidesWith(rectPortal3) then
          Portal2Collision2()
      end
      if rectPlayer:collidesWith(rectPortalReplay) then
        Replay()
      end
      if rectPlayer:collidesWith(rectBoxLeft) then
        player_x = player_x + kickback
      end
        isWalking = true
        player_x = player_x + playerSpeed * dt
        rectPlayer:moveTo(player_x + 32,player_y +32)
        if (elapsedTime > 0.1) then
            if (currentFrame < 4) then
                currentFrame = currentFrame + 1
            else
                currentFrame = 1
            end
            activeFrame = walkingFramesRight[currentFrame]
            elapsedTime = 0
        end
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown('a') then
      if rectPlayer:collidesWith(rectEnemy) then
          EnemyCollision()
      end
      if rectPlayer:collidesWith(rectPortal) then
          PortalCollision()
      end
      if rectPlayer:collidesWith(rectPortal2) then
          PortalCollision1()
      end
      if rectPlayer:collidesWith(rectPortal3) then
          Portal2Collision2()
      end
      if rectPlayer:collidesWith(rectPortalReplay) then
        Replay()
      end
      if rectPlayer:collidesWith(rectBoxLeft) then
        player_x = player_x + kickback
      end
        isWalking = true
        player_x = player_x - playerSpeed * dt
        rectPlayer:moveTo(player_x + 32,player_y +32)
        if (elapsedTime > 0.1) then
            if (currentFrame < 4) then
                currentFrame = currentFrame + 1
            else
                currentFrame = 1
            end
            activeFrame = walkingFramesLeft[currentFrame]
            elapsedTime = 0
        end

    end
end

function love.draw()

  for i = 0, love.graphics.getWidth() / background:getWidth() do
      for j = 0, love.graphics.getHeight() / background:getHeight() do
          love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
      end
  end
  for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    love.graphics.draw(player,activeFrame, player_x, player_y)
    love.graphics.draw(enemy, enemy_x, enemy_y)
    love.graphics.draw(portal, 216, 900)
    love.graphics.draw(portal, 88, 636 )
    love.graphics.draw(portal, 564, 336)
    love.graphics.draw(portalExit, 1264, 36)
    love.graphics.draw(portalReplay,164, 36 )

    rectFloor:draw('fill')
    rectFloor2:draw('fill')
    rectFloor3:draw('fill')


end

local Functions do

  function Replay()
    text[#text+1] = string.format("U activated another round boiiii.")
    player_x = 64
    player_y = 900
    enemy_x = 320
    enemy_y = 640
  end

  function PortalCollision()
    text[#text+1] = string.format("Portal collision detected! ")
    player_y = player_y - 265
  end

  function PortalCollision1()
    text[#text+1] = string.format("Portal2 collision detected! ")
    player_y = player_y - 300
  end

  function Portal2Collision2()
    text[#text+1] = string.format("Portal3 collision detected! ")
    player_y = player_y - 300
  end

  function EnemyCollision()
      text[#text+1] = string.format("Enemy collision detected!")
      player_x = 64
      player_y = 900
  end
end
