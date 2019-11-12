walkingFramesRight = {}
walkingFramesLeft = {}
walkingFramesUp = {}
walkingFramesDown = {}
activeFrame = 0
currentFrame = 2
elapsedTime = 0
elapsedTime2 = 0

playerSpeed = 200
enemySpeed = 200
isWalking = false

enemy_x = 640 -- 640x640 jest zjebane lokacja poczatkowa
enemy_y = 640

player_x = 64
player_y = 900

floor_x = 64
floor_y = 700
floor2_x = 114
floor2_y = 400
floor3_x = 164
floor3_y = 100

portal_x = 0
portal_y = 0
--portalReplay_x =
--portalReplay_y =
--portalExit_x =
--portalExit_y =

kickback  = 12
DirectionChange = false

local text = {}
local audio = love.audio.newSource('music/banditradio.mp3','static')
local NANI = love.audio.newSource('music/NANI.mp3', 'static')
function love.load()
    audio:setLooping(true)
    audio:play()

HC = require 'HC'
require 'SpriteFunctions'
--loadfile 'SpriteFunctions.lua'()
--scale = 'adaptive'
  rectPlayer = HC.rectangle(player_x,player_y,32,64)
  rectEnemy = HC.rectangle(enemy_x,enemy_y,64,64)

  rectFloor = HC.rectangle(floor_x, floor_y, 1200, 16)
  rectFloor2 = HC.rectangle(floor2_x, floor2_y, 1200, 16)
  rectFloor3 = HC.rectangle(floor3_x, floor3_y, 1200,16)

  rectPortal = HC.rectangle(portal_x + 214,portal_y + 900 ,64, 64) --214 900
  rectPortal2 = HC.rectangle(portal_x + 88, portal_y + 636 ,64, 64) -- 88 636
  rectPortal3 = HC.rectangle(portal_x + 564,portal_y + 336 ,64, 64) -- 564 336

  rectPortalExit = HC.rectangle(portal_x + 1264,portal_y + 36, 64, 64) --1264 36
  rectPortalReplay = HC.rectangle(portal_x + 164,portal_x +  36, 64, 64) -- 164 36
  rectPortalReplay1 =HC.rectangle(portal_x + 500,portal_y + 336 ,64 ,64 ) -- 500 336

  rectBoxUp = HC.rectangle(0,-1,1920,1)       --0,-1, ,
  rectBoxDown = HC.rectangle (0,1080,1920,1) --0,1080,  ,
  rectBoxLeft = HC.rectangle (-40,0,1,1080)    -- -33,0, ,
  rectBoxRight = HC.rectangle(1960,0,1,1080)  --1920,0

local PNGs do
    background = love.graphics.newImage("images/background.png")
    player = love.graphics.newImage("images/hummy64x64.png")
    enemy = love.graphics.newImage("images/enemy64x64.png")
    portal = love.graphics.newImage("images/portal.png")
    portalExit = love.graphics.newImage("images/portalblue.png")
    portalReplay = love.graphics.newImage("images/portalyellow.png")
    platform = love.graphics.newImage("images/trawa.png")
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

     while #text > 40 do
          table.remove(text, 1)
      end
      -- FULL SCREEN, ZAMYKAĆ ESC
      if love.keyboard.isDown("escape") then
          love.event.quit(0)
        end
      if love.keyboard.isDown('r') then
        Replay()
      end
      if love.keyboard.isDown('m') then
        player_x = 1200
        player_y = 36
      end
      love.window.setFullscreen(true, "desktop")
    elapsedTime = elapsedTime + dt
    elapsedTime2 = elapsedTime2 + dt

    while  (elapsedTime2 > 0.01) do
          enemy_x = enemy_x + enemySpeed * dt
          rectEnemy:moveTo(enemy_x + 32,enemy_y + 32)
          elapsedTime2 = 0
          if enemy_x > 1000 then -- 1000
            enemySpeed = -enemySpeed
          end
          if enemy_x < 300 then --300
            enemySpeed = -enemySpeed
          end
      end

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
    if rectPlayer:collidesWith(rectPortalReplay) or rectPlayer:collidesWith(rectPortalReplay1) then
      Replay()
    end

    if rectPlayer:collidesWith(rectBoxRight) then
      player_x = player_x - 1920
    end
    if rectPlayer:collidesWith(rectBoxLeft) then
      player_x = player_x + 1920
    end
    if love.keyboard.isDown("right") or love.keyboard.isDown('d') then
      if rectPlayer:collidesWith(rectPortalExit) then
        Wait()
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
      if rectPlayer:collidesWith(rectPortalExit) then
        love.event.quit(0)
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

--for k = 2,28 do
--  love.graphics.draw(platform, k * platform:getWidth(), floor3_y)
--  love.graphics.draw(platform, (k-1) * platform:getWidth(), floor2_y)
--  love.graphics.draw(platform, (k-2) * platform:getWidth(), floor_y)
--end

  for i = 1,#text do
        love.graphics.setColor(255,255,255, 255 - (i-1) * 6)
        love.graphics.print(text[#text - (i-1)], 10, i * 15)
    end

    love.graphics.draw(player,activeFrame, player_x, player_y)
    love.graphics.draw(enemy, enemy_x, enemy_y)
    love.graphics.draw(portal, portal_x  + 216,portal_y + 900)
    love.graphics.draw(portal, portal_x + 88,portal_y +  636 )
    love.graphics.draw(portal, portal_x + 564,portal_y +  336)
    love.graphics.draw(portalExit, portal_x + 1264,portal_y +  36)
    love.graphics.draw(portalReplay,portal_x + 164, portal_y + 36 )
    love.graphics.draw(portalReplay,portal_x + 500,portal_y + 336)
    love.graphics.draw(platform, floor_x, floor_y)



    rectFloor:draw('line')
    rectFloor2:draw('line')
    rectFloor3:draw('line')
    rectPortal:draw('line')
    rectPortal2:draw('line')
    rectPortal3:draw('line')
    rectPortalExit:draw('line')
    rectPortalReplay:draw('line')
    rectPortalReplay1:draw('line')
    rectEnemy:draw('line')


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
      NANI:play()
      player_x = 64
      player_y = 900
  end

  function Wait()
    --enemy_y = 900 -- przesuwa zjeba na dol
    floor_x = 700
    floor_y = 1000
    rectFloor:moveTo(floor_x + 600, floor_y + 8 ) -- nie ruszac 600 i 8 bo upierdole łapy przy barach

  end

end
