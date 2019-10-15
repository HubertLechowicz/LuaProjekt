
walkingFramesRight = {}
walkingFramesLeft = {}
walkingFramesUp = {}
walkingFramesDown = {}
activeFrame = 0
currentFrame = 2
elapsedTime = 0
player_x = 333
player_y = 250
playerSpeed = 200
isWalking = false
directionRight = false -- still figuring out where to use these
directionLeft = false -- still figuring out where to use these
directionUp = false -- still figuring out where to use these
directionDown = false -- still figuring out where to use these



function love.load()
    background = love.graphics.newImage("background.png")
    player = love.graphics.newImage("hummy64x64.png")
    walkingFramesDown[1] = love.graphics.newQuad(0, 0, 29, 57, player:getDimensions())
    walkingFramesDown[2] = love.graphics.newQuad(29, 0, 29, 57, player:getDimensions())
    walkingFramesDown[3] = love.graphics.newQuad(58, 0, 29, 57, player:getDimensions())
    walkingFramesDown[4] = love.graphics.newQuad(87, 0, 29, 57, player:getDimensions())

    walkingFramesUp[1] = love.graphics.newQuad(0, 171, 29, 57, player:getDimensions())
    walkingFramesUp[2] = love.graphics.newQuad(29, 171, 29, 57, player:getDimensions())
    walkingFramesUp[3] = love.graphics.newQuad(58, 171, 29, 57, player:getDimensions())
    walkingFramesUp[4] = love.graphics.newQuad(87, 171, 29, 57, player:getDimensions())

    walkingFramesRight[1] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())
    walkingFramesRight[2] = love.graphics.newQuad(64, 0, 64, 57, player:getDimensions())
    walkingFramesRight[3] = love.graphics.newQuad(128, 0, 64, 64, player:getDimensions())
    walkingFramesRight[4] = love.graphics.newQuad(194, 0, 64, 64, player:getDimensions())

    walkingFramesLeft[1] = love.graphics.newQuad(194, 0, 64, 64, player:getDimensions())
    walkingFramesLeft[2] = love.graphics.newQuad(128, 0, 64, 64, player:getDimensions())
    walkingFramesLeft[3] = love.graphics.newQuad(64, 0, 64, 64, player:getDimensions())
    walkingFramesLeft[4] = love.graphics.newQuad(0, 0, 64, 64, player:getDimensions())

    activeFrame = walkingFramesDown[currentFrame]
end

function love.update(dt)
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
  for i = 0, love.graphics.getWidth() / background:getWidth() do
      for j = 0, love.graphics.getHeight() / background:getHeight() do
          love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
      end
  end
    love.graphics.draw(player,activeFrame, player_x, player_y)
    if directionDown then
        love.graphics.print("down = true", 100, 100)
    end
end
