
walkingFramesRight = {}
walkingFramesLeft = {}
walkingFramesUp = {}
walkingFramesDown = {}
activeFrame = 0
currentFrame = 2
elapsedTime = 0
player_x = 64
player_y = 900
playerSpeed = 200
isWalking = false
directionRight = false -- still figuring out where to use these
directionLeft = false -- still figuring out where to use these
directionUp = false -- still figuring out where to use these
directionDown = false -- still figuring out where to use these
enemy_x = 320 -- 640x640 jest zjebane lokacja poczatkowa
enemy_y = 640
local text = {}
kickback  = 12
function love.load()
HC = require 'HC'
require 'SpriteFunctions'
--loadfile 'SpriteFunctions.lua'()

  rectPlayer = HC.rectangle(player_x,player_y,32,64)
  rectEnemy = HC.rectangle(enemy_x,enemy_y,64,64)
  rectFloor = HC.rectangle(player_x + 100,player_y - 300 + 100,640,64)


    background = love.graphics.newImage("background.png")
    player = love.graphics.newImage("hummy64x64.png")
    enemy = love.graphics.newImage("enemy64x64.png")
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

function love.update(dt)
  --for shape, delta in pairs(HC.collisions(rectEnemy)) do
         --text[#text+1] = string.format("Colliding. Separating vector = (%s,%s)",
                                  --     delta.x, delta.y)

     --end

     while #text > 40 do
          table.remove(text, 1)
      end


      -- FULL SCREEN, ZAMYKAĆ ALT+F4
      love.window.setFullscreen(true, "desktop")
    elapsedTime = elapsedTime + dt
    if love.keyboard.isDown("down") then
      if rectPlayer:collidesWith(rectEnemy) then
          text[#text+1] = string.format(" DOWN collision detected! ")
          player_x = 64
          player_y = 900
      end
      if rectPlayer:collidesWith(rectFloor) then
          text[#text+1] = string.format(" DOWN_Floor collision detected! ")
          player_y = player_y - kickback
      end
        isWalking = true -- I just have this in case I need to use it later
        player_y = player_y + playerSpeed * dt
        rectPlayer:moveTo(player_x + 32,player_y +32)
        --if (elapsedTime > 0.1) then
            --if (currentFrame < 4) then
              --  currentFrame = currentFrame + 1
          --  else
            --    currentFrame = 1
          --  end
          --  activeFrame = walkingFramesDown[currentFrame]
          --  elapsedTime = 0
      --  end

    end

    -- if love.keyreleased("down") then
    --     directionDown = true
    -- end

    if love.keyboard.isDown("up") then
      if rectPlayer:collidesWith(rectEnemy) then
          text[#text+1] = string.format(" UP collision detected!")
          player_x = 64
          player_y = 900
      end
      if rectPlayer:collidesWith(rectFloor) then
          text[#text+1] = string.format(" UP_Floor collision detected! ")
          player_y = player_y + kickback
      end
        isWalking = true
        player_y = player_y - playerSpeed * dt
        rectPlayer:moveTo(player_x + 32,player_y +32)
      --  if (elapsedTime > 0.1) then
        --    if (currentFrame < 4) then
          --      currentFrame = currentFrame + 1
          --  else
          --      currentFrame = 1
          --  end
          --  activeFrame = walkingFramesUp[currentFrame]
          --  elapsedTime = 0
        --end

    end
    if love.keyboard.isDown("right") then
      if rectPlayer:collidesWith(rectEnemy) then
          text[#text+1] = string.format("RIGHT collision detected!")
          player_x = 64
          player_y = 900
      end
      if rectPlayer:collidesWith(rectFloor) then
          text[#text+1] = string.format(" RIGHT_Floor collision detected! ")
          player_x = player_x - kickback
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
    if love.keyboard.isDown("left") then
      if rectPlayer:collidesWith(rectEnemy) then
          text[#text+1] = string.format("LEFT collision detected!")
          player_x = 64
          player_y = 900
      end
      if rectPlayer:collidesWith(rectFloor) then
          text[#text+1] = string.format(" LEFT_Floor collision detected! ")
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
    love.graphics.setColor(255,255,255)
    rectPlayer:draw('line')
    rectEnemy:draw('line')
    rectFloor:draw('fill')
end
