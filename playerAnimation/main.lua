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

mightAsWellJump = -300

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
floor4_x = 1
floor4_y = 964
floor5_x = 9999999
floor5_y = 9999999
floor6_x = 9999999
floor6_y = 9999999
floorWidth = 32

portal_x = 214
portal_y = 900
portal2_x = 88
portal2_y = 636
portal3_x = 564
portal3_y = 336
portal4_x = 1264
portal4_y = 36

portalReplay_x = 164
portalReplay_y = 36
portalReplay2_x = 500
portalReplay2_y = 336
portalExit_x = 9999999
portalExit_y = 9999999

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


  rectPlayer = HC.rectangle(player_x,player_y,32,64)
  rectEnemy = HC.rectangle(enemy_x,enemy_y,64,64)

  rectFloor = HC.rectangle(floor_x, floor_y, 1200, floorWidth)
  rectFloor2 = HC.rectangle(floor2_x, floor2_y, 1200, floorWidth)
  rectFloor3 = HC.rectangle(floor3_x, floor3_y, 1200,floorWidth)
  rectFloor4 = HC.rectangle(floor4_x,floor4_y, 1200, floorWidth)
  rectFloor5 = HC.rectangle(floor5_x,floor5_y, 1200, floorWidth)
  rectFloor6 = HC.rectangle(floor6_x, floor6_y, 1200, floorWidth)

  rectPortal = HC.rectangle(portal_x,portal_y,64, 64) --214 900
  rectPortal2 = HC.rectangle(portal2_x , portal2_y  ,64, 64) -- 88 636
  rectPortal3 = HC.rectangle(portal3_x ,portal3_y  ,64, 64) -- 564 336
  rectPortal4 = HC.rectangle(portal4_x ,portal4_y  ,64, 64) -- 564 336

  rectPortalExit = HC.rectangle(portalExit_x ,portalExit_y, 64, 64) --1264 36
  rectPortalReplay = HC.rectangle(portalReplay_x,portalReplay_y, 64, 64) -- 164 36
  rectPortalReplay2 = HC.rectangle(portalReplay2_x,portalReplay2_y,64 ,64 ) -- 500 336


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
    if rectPlayer:collidesWith(rectPortal4) then
      Wait()
    end
    if rectPlayer:collidesWith(rectPortalExit) then
      love.event.quit(0)
    end
    if rectPlayer:collidesWith(rectPortalReplay) or rectPlayer:collidesWith(rectPortalReplay2) then
      Replay()
    end
    if rectPlayer:collidesWith(rectBoxRight) then
      player_x = player_x - 1920
    end
    if rectPlayer:collidesWith(rectBoxLeft) then
      player_x = player_x + 1920
    end
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

    if love.keyboard.isDown("right") or love.keyboard.isDown('d') then


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
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      player_y = player_y + mightAsWellJump * dt
      rectPlayer:moveTo(player_x + 32,player_y +32)
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
      player_y = player_y - mightAsWellJump * dt
      rectPlayer:moveTo(player_x + 32,player_y +32)
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

    love.graphics.draw(portal, portal_x,portal_y)
    love.graphics.draw(portal, portal2_x,portal2_y)
    love.graphics.draw(portal, portal3_x,portal3_y)
    love.graphics.draw(portal, portal4_x,portal4_y)

    love.graphics.draw(portalExit, portalExit_x, portalExit_y)
    love.graphics.draw(portalReplay,portalReplay_x, portalReplay_y)
    love.graphics.draw(portalReplay,portalReplay2_x, portalReplay2_y)

    love.graphics.draw(platform, floor_x, floor_y)
    love.graphics.draw(platform, floor2_x, floor2_y)
    love.graphics.draw(platform, floor3_x, floor3_y)
    love.graphics.draw(platform, floor4_x, floor4_y)
    love.graphics.draw(platform, floor5_x, floor5_y)
    love.graphics.draw(platform, floor6_x, floor6_y)




    rectFloor:draw('line')
    rectFloor2:draw('line')
    rectFloor3:draw('line')
    rectFloor4:draw('line')
    rectFloor5:draw('line')
    rectFloor6:draw('line')
    rectPortal:draw('line')
    rectPortal2:draw('line')
    rectPortal3:draw('line')
    rectPortalExit:draw('line')
    rectPortalReplay:draw('line')
    rectPortalReplay2:draw('line')
    rectEnemy:draw('line')
    rectPlayer:draw('line')



end

local Functions do

  function Replay()
    text[#text+1] = string.format("U activated another round boiiii.")
    player_x = 64
    player_y = 900
    enemy_x = 320
    enemy_y = 640
    rectPlayer:moveTo(player_x + 32,player_y +32)
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
    background = love.graphics.newImage("images/background2.png")
    floor_x = 720
    floor_y = 966
    rectFloor:moveTo(floor_x + 600, floor_y + 16 ) -- nie ruszac 600 i 8 bo upierdole łapy przy barach
    floor2_x = 0
    floor2_y = 700
    rectFloor2:moveTo(floor2_x + 600, floor2_y + 16 )
    floor4_x = 960
    floor4_y = 540
    rectFloor4:moveTo(floor4_x + 600, floor4_y + 16)
    floor5_x = 500
    floor5_y = 336
    rectFloor5:moveTo(floor5_x + 600, floor5_y + 16)
    floor6_x = -1000
    floor6_y = 966
    rectFloor6:moveTo(floor6_x + 600, floor6_y + 16)


    portalExit_x = 900
    portalExit_y = 900
    rectPortalExit:moveTo(portalExit_x + 32 , portalExit_y + 32) --tego tez kurwa nie ruszac

    portal_x, portal_y = 9999999
    rectPortal:moveTo(portalExit_x + 32 , portalExit_y + 32)
    portal4_x, portal4_y = 9999999
    rectPortal:moveTo(portalExit_x + 32 , portalExit_y + 32)

    portal2_x, portal2_y = 9999999
    rectPortal2:moveTo(portalExit_x + 32 , portalExit_y + 32)

    portal3_x, portal3_y = 9999999
    rectPortal3:moveTo(portalExit_x + 32 , portalExit_y + 32)

    portalReplay_x, portalReplay_y = 9999999
    rectPortalReplay:moveTo(portalExit_x + 32, portalExit_y + 32)

    portalReplay2_x, portalReplay2_y = 9999999
    rectPortalReplay2:moveTo(portalExit_x + 32 , portalExit_y + 32)
  end
end
