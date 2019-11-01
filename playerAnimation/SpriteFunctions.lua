require  "main"
 function checkCollision(b)
    --Tworzymy 2 prostokaty,kazdy po 4 boki
     a_left = player_x
     a_right = player_x + player:getWidth()
     a_top = player_y
     a_bottom = player_y + player:getHeight()

    b_left = enemy_x
    b_right = enemy_x + enemy:getWidth()
    b_top = enemy_y
    b_bottom = enemy_y + enemy:getHeight()

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

function checkCollisionTop(b)
  if
    a_top < b_bottom then
      return(true)
    else
        return(false)
  end
end
function checkCollisionRight(b)
  if
    a_right < b_left then
      return(true)
    else
        return(false)
  end
end
function checkCollisionLeft(b)
  if
    a_left < b_right then
      return(true)
    else
        return(false)
  end
end

function checkCollisionBottom(b)
  if
    a_bottom < b_top then
        return(true)
      else
          return(false)
    end
end
