function love.load()
    --Tworzymy 2 obiekty

    --Przechodzacy
    r1 = {
        x = 10,
        y = 100,
        width = 100,
        height = 100
    }

    --Stojacy
    r2 = {
        x = 250,
        y = 120,
        width = 150,
        height = 120
    }
end

function love.update(dt)
    if love.keyboard.isDown("left") then
        r1.x = r1.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        r1.x = r1.x + 200 * dt
    end

    if love.keyboard.isDown("up") then
        r1.y = r1.y - 200 * dt
    elseif love.keyboard.isDown("down") then
        r1.y = r1.y + 200 * dt
    end
end



function love.draw()


    if checkCollision(r1, r2) then
        --Przy kolizji powrót do punktu poczatkowego
        r1.x=10
        r1.y=100
    else
        --Jak nie ma kolizji same kontury
        mode = "line"
    end

    --Pierwszy argument
    love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
    love.graphics.rectangle(mode, r2.x, r2.y, r2.width, r2.height)
end

--Lewa strona to pozycja x, prawa strona to pozycja x + szerokosc. To samo y i wysokosc


function checkCollision(a, b)
    --Tworzymy 2 prostokaty,kazdy po 4 boki
    local a_left = a.x
    local a_right = a.x + a.width
    local a_top = a.y
    local a_bottom = a.y + a.height

    local b_left = b.x
    local b_right = b.x + b.width
    local b_top = b.y
    local b_bottom = b.y + b.height

    --Jesli prawa strona Czerwonego znajduje sie bardziej na prawo niz lewa strona Niebieskiego :
    if a_right > b_left and
    --a lewa strona Czerwonego znajduje sie bardziej na lewo niz prawa strona Niebieskiego
    a_left < b_right and
    --a dolna strona Czerwonego jest bardziej do dolu niz górna strona Niebieskiego.
    a_bottom > b_top and
    --a górna strona Reda znajduje sie dalej do góry niz dolna strona Blue, a nastepnie ..
    a_top < b_bottom then
        --Jest kolizja
        return true
    else
        --Jesli jedno z tych stwierdzen jest falszywe, zwróc false.

        return false
    end
end
