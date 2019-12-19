require 'dxopal'
include DXOpal

Image.register(:Reno, 'files/Reno2.png')
Image.register(:RenoL, 'files/L.png')
Image.register(:RenoC, 'files/RenoC.png')
Image.register(:RenoR, 'files/RenoR.png')
Image.register(:title, 'files/title.png')

Sound.register(:bet, 'sounds/bet.wav')
Sound.register(:start, 'sounds/start.wav')
Sound.register(:stop, 'sounds/stop.wav')
Sound.register(:rep, 'sounds/replay.wav')
Sound.register(:tomato, 'sounds/tomato.wav')
Sound.register(:bonus, 'sounds/bonus.wav')
Sound.register(:manbo, 'sounds/manbo.wav')

Window.load_resources do
  Window.bgcolor = C_BLACK
  rlres = -1038
  x = rlres
  y = rlres
  z = rlres
  a = 0
  t = 0
  seigyo = [0,-60,-120,-180,-240,-300,-360,-420,-480,-540,-600,-660,-720,-780,-840,-900,-960,-1020,-1080,-1140]
  flug = 0
  flugs = 0
  flug1 = 1
  flug2 = 1
  flug3 = 1
  koyaku = 0
  game = 0
  tmgame = 0
  samai = 0
  tmt = 0
  gtmt = 0
  tyusen = 0
  bonus = 0
  add = 0

  Window.loop do

    #flug = 0 回転中
    #flug = 1 停止中
    #koyaku = 3 トマト
    #koyaku = 2 下段リンゴ
    #koyaku = 1 リプ
    #koyaku = 0 ハズレ


    Window.draw(142, x+7, Image[:RenoL])
    Window.draw(142, x-rlres+7, Image[:RenoL])
    Window.draw(258, y+7, Image[:RenoC])
    Window.draw(258, y-rlres+7, Image[:RenoC])
    Window.draw(374, z+7, Image[:RenoR])
    Window.draw(374, z-rlres+7, Image[:RenoR])

    Window.draw(0, -25, Image[:Reno])

    Window.draw(142, 19, Image[:title])

    if flug == 1 &&  flug1 + flug2 + flug3 == 2
      Sound[:bonus].play
      flug = 0
      flugs = 1
    end

    if flugs == 1 && flug1 + flug2 + flug3 == 3
      Sound[:manbo].play
      flugs = 0
    end

    if flug == 2 && t == 1
      samai += 200 - add
      add = 0
      flug = 0
      Sound[:manbo].stop
      bonus = 0
    elsif flug == 3 && t == 1
      samai += 80 - add
      add = 0
      flug = 0
      bonus = 0
      Sound[:manbo].stop
    end


    if flug1 + flug2 + flug3 == 3 && bonus == 1 && t == 0
      samai += 0.20
      add += 0.20
      flug = 2
      if add >= 201
        add = 200
        bonus = 0
        Sound[:manbo].stop
      end
    elsif flug1 + flug2 + flug3 == 3 && bonus == 2 && t == 0
      samai += 0.20
      add += 0.20
      flug = 3
      if add >= 81
        add = 80
        bonus = 0
        Sound[:manbo].stop
      end
    end

  

    if x >= 0
      x = rlres
    end

    if y >= 0
      y = rlres
    end

    if z >= 0 
      z = rlres
    end

    if flug1 == 0
      x += 24
    end
    if flug2 == 0
      y += 24
    end
    if flug3 == 0
      z += 24
    end


    if Input.key_down?(K_LEFT) && flug1 == 0
      Sound[:stop].play
      if bonus != 0
        x = seigyo[17]
      elsif  koyaku == 1
        r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 3
        if tmt == 0
          r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[2]]
        elsif tmt == 1
          r3 = [seigyo[17],seigyo[10],seigyo[7],seigyo[0]]
        elsif tmt == 2
          r3 = [seigyo[15],seigyo[12],seigyo[7],seigyo[5],seigyo[0]]    
        end
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 0
        r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end        
      else
        x = seigyo.min_by{|a| (a-x).abs}
      end
      flug1 = 1
    end

    if koyaku == 3 && flug1 == 1
      if x == seigyo[2] || x == seigyo[7] || x == seigyo[12] || x == seigyo[17]
        gtmt = 1
      end
    end

    if Input.key_down?(K_DOWN) && flug2 == 0
      Sound[:stop].play
      if bonus != 0 
        y = seigyo[16]
      elsif  koyaku == 3
        r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 1
        r3 = [seigyo[19],seigyo[14],seigyo[9],seigyo[4]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 0
        r3 = [seigyo[18],seigyo[13],seigyo[8],seigyo[3]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      else
        y = seigyo.min_by{|a| (a-y).abs}
      end
      flug2 = 1
    end

    if koyaku == 1 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_LEFT) == false
      t = 1
      Sound[:rep].play 
    end

    if gtmt == 1 && Input.key_down?(K_LEFT) == false && flug1 == 1 && flug2 == 1 && flug3 == 1
      t = 1
      Sound[:tomato].play 
      tyusen = 1
      gtmt = 0
      koyaku = 0
      tmgame = 0
    end


    if Input.key_down?(K_RIGHT) && flug3 == 0
      Sound[:stop].play
      if bonus == 1
        z = seigyo[15]
      elsif bonus == 2
        z = seigyo[14]
      elsif  koyaku == 3
        r3 = [seigyo[18],seigyo[13],seigyo[8],seigyo[3]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 1
        r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 0
        r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      else z = seigyo.min_by{|a| (a-z).abs}
      end
      flug3 = 1
    end

    if Input.key_down?(K_UP) && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0
      t = 1
      samai -= 3
      Sound[:bet].play
    end

    if Input.key_down?(K_SPACE) && t == 1
      Sound[:start].play
      game += 1
      tmgame += 1
      flug1 = 0
      flug2 = 0
      flug3 = 0
      if tyusen == 0
        if rand(8192) <= 0
          koyaku = 0
          tmt = rand(3)
        elsif rand(2048) <= 9
          koyaku = 2
        elsif rand(296) <= 99
          koyaku = 1
        else
          koyaku = 0
        end
      end
      t = 0
    end
  


























     if   a == true
      a = false
      if flug1 == 0 && flug2 == 1  && flug3 == 1
        Sound[:stop].play
        if bonus != 0 
          x = seigyo[17]
        elsif koyaku == 1
          r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
          ans1 = r3.min_by{|a| (a-x).abs}
          ansc = r3.index(ans1)
          if ans1 <= x
            x = r3[ansc-1]
          else
            x = ans1
          end
        elsif  koyaku == 3
        if tmt == 0
          r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[2]]
        elsif tmt == 1
          r3 = [seigyo[17],seigyo[10],seigyo[7],seigyo[0]]
        elsif tmt == 2
          r3 = [seigyo[15],seigyo[12],seigyo[7],seigyo[5],seigyo[0]]    
        end
          ans1 = r3.min_by{|a| (a-x).abs}
          ansc = r3.index(ans1)
          if ans1 <= x
            x = r3[ansc-1]
          else
            x = ans1
          end
        elsif  koyaku == 0
          r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
          ans1 = r3.min_by{|a| (a-x).abs}
          ansc = r3.index(ans1)
          if ans1 <= x
            x = r3[ansc-1]
          else
            x = ans1
          end     
        else
          x = seigyo.min_by{|a| (a-x).abs}
        end
        flug1 = 1
        break
      end
  
  
  
      if flug2 == 0 && flug3 == 1
        Sound[:stop].play
        if bonus != 0 
          y = seigyo[16]
        elsif  koyaku == 3
          r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
          ans2 = r3.min_by{|a| (a-y).abs}
          ansc = r3.index(ans2)
          if ans2 <= y
            y = r3[ansc-1]
          else
            y = ans2
          end
        elsif  koyaku == 1
          r3 = [seigyo[19],seigyo[14],seigyo[9],seigyo[4]]
          ans2 = r3.min_by{|a| (a-y).abs}
          ansc = r3.index(ans2)
          if ans2 <= y
            y = r3[ansc-1]
          else
            y = ans2
          end
        else
          y = seigyo.min_by{|a| (a-y).abs}
        end
        flug2 = 1
        break
      end
  
      if koyaku == 1 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 
        t = 1
        Sound[:rep].play 
        break
      end
  
      if gtmt == 1 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0
        t = 1
        Sound[:tomato].play
        tyusen = 1
        gtmt = 0
        koyaku = 0
      end
  
  
      if flug3 == 0
        Sound[:stop].play
        if bonus == 1
          z = seigyo[15]
        elsif bonus == 2
          z = seigyo[14]
        elsif  koyaku == 3
          r3 = [seigyo[18],seigyo[13],seigyo[8],seigyo[3]]
          ans3 = r3.min_by{|a| (a-z).abs}
          ansc = r3.index(ans3)
          if ans3 <= z
            z = r3[ansc-1]
          else
            z = ans3
          end
        elsif koyaku == 1
          r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
          ans3 = r3.min_by{|a| (a-z).abs}
          ansc = r3.index(ans3)
          if ans3 <= z
            z = r3[ansc-1]
          else
            z = ans3
          end
        elsif koyaku == 0
          r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
          ans3 = r3.min_by{|a| (a-z).abs}
          ansc = r3.index(ans3)
          if ans3 <= z
            z = r3[ansc-1]
          else
            z = ans3
          end
        elsif  koyaku == 0
          r3 = [seigyo[18],seigyo[13],seigyo[8],seigyo[3]]
          ans2 = r3.min_by{|a| (a-y).abs}
          ansc = r3.index(ans2)
          if ans2 <= y
            y = r3[ansc-1]
          else
            y = ans2
          end
        else z = seigyo.min_by{|a| (a-z).abs}
        end
        flug3 = 1
      end
  
      if flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0
        t = 1
        Sound[:bet].play
        samai -= 3
        break
      end
  
      if t == 1        
      Sound[:start].play
        game += 1
        tmgame += 1
        flug1 = 0
        flug2 = 0
        flug3 = 0
        if tyusen == 0
          if rand(7774) <= 99
            koyaku = 3
          elsif rand(2048) <= 9
            koyaku = 2
          elsif rand(296) <= 99
            koyaku = 1
          else
            koyaku = 0
          end
        elsif tyusen == 1
          if rand(87) <= 9
            flug = 1
            if rand(5) <= 2
              bonus = 1
            else 
              bonus = 2
            end
          elsif rand(30) == 15 && bonus == 0
            tyusen = 0
          end
  
          koyaku = 0
        end
        t = 0
      end
    end

    %x{
      document.getElementById('run').addEventListener('click', function(){
        a = true
      });
    }
  end
end
