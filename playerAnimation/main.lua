
walkingFramesRight = {}
walkingFramesLeft = {}
walkingFramesUp = {}
walkingFramesDown = {}
activeFrame = 0
currentFrame = 2
elapsedTime = 0
player_x = 64
player_y = 64
playerSpeed = 200
isWalking = false
directionRight = false -- still figuring out where to use these
directionLeft = false -- still figuring out where to use these
directionUp = false -- still figuring out where to use these
directionDown = false -- still figuring out where to use these



function love.load()
require 'SpriteFunctions'
--loadfile 'SpriteFunctions.lua'()

    r2 = {
        x = 640,
        y = 640,
        width = 64,
        height = 64
    }

    background = love.graphics.newImage("background.png")
    player = love.graphics.newImage("hummy64x64.png")
    walkingFramesDown[1] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesDown[2] = love.graphics.newQuad(29, 0, 64, 64, player:getDimensions())
    walkingFramesDown[3] = love.graphics.newQuad(58, 0, 64, 64, player:getDimensions())
    walkingFramesDown[4] = love.graphics.newQuad(87, 0, 64, 64, player:getDimensions())

    walkingFramesUp[1] = love.graphics.newQuad(0, 171, 64, 64, player:getDimensions())
    walkingFramesUp[2] = love.graphics.newQuad(29, 171, 64, 64, player:getDimensions())
    walkingFramesUp[3] = love.graphics.newQuad(58, 171, 64, 64, player:getDimensions())
    walkingFramesUp[4] = love.graphics.newQuad(87, 171, 64, 64, player:getDimensions())

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
      -- FULL SCREEN, ZAMYKAĆ ALT+F4
      love.window.setFullscreen(true, "desktop")
    elapsedTime = elapsedTime + dt
    if love.keyboard.isDown("down") then
        isWalking = true -- I just have this in case I need to use it later
        player_y = player_y + playerSpeed * dt
        if (elapsedTime > 0.1) then
            if (currentFrame < 4) then
                currentFrame = currentFrame + 1
            else
                currentFrame = 1
            end
            activeFrame = walkingFramesDown[currentFrame]
            elapsedTime = 0
        end

    end

    -- if love.keyreleased("down") then
    --     directionDown = true
    -- end

    if love.keyboard.isDown("up") then
        isWalking = true
        player_y = player_y - playerSpeed * dt
        if (elapsedTime > 0.1) then
            if (currentFrame < 4) then
                currentFrame = currentFrame + 1
            else
                currentFrame = 1
            end
            activeFrame = walkingFramesUp[currentFrame]
            elapsedTime = 0
        end

    end
    if love.keyboard.isDown("right") then
        isWalking = true
        player_x = player_x + playerSpeed * dt
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
        isWalking = true
        player_x = player_x - playerSpeed * dt
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

  if checkCollision(r2) then
    if checkCollisionTop(r2) then
      player_y = player_y - 10
    end
  else
    mode = 'line'
  end



  for i = 0, love.graphics.getWidth() / background:getWidth() do
      for j = 0, love.graphics.getHeight() / background:getHeight() do
          love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
      end
  end
    love.graphics.draw(player,activeFrame, player_x, player_y)
    love.graphics.rectangle('fill',r2.x, r2.y, r2.width, r2.height)
    love.graphics.print(r2.y, 100, 100, 10, 250, 0, 2, 2)
    love.graphics.print("This lame example is twice as big.", 1000, 250, 0, 2, 2)
end
