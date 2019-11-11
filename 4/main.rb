require 'dxopal'
include DXOpal

Image.register(:Reno, 'files/Reno.png')
Image.register(:RenoL, 'files/RenoL.png')
Image.register(:RenoC, 'files/RenoC.png')
Image.register(:RenoR, 'files/RenoR.png')

Sound.register(:bet, 'sounds/bet.wav')
Sound.register(:start, 'sounds/start.wav')
Sound.register(:stop, 'sounds/teisi.wav')
Sound.register(:rep, 'sounds/replay.wav')
Sound.register(:tomato, 'sounds/tomato.wav')

Window.load_resources do
  Window.bgcolor = C_BLACK
  rlres = -1038
  x = rlres
  y = rlres
  z = rlres
  a = 0
  t = 0
  seigyo = [0,-48,-102,-152,-204,-258,-308,-358,-412,-464,-516,-568,-622,-672,-724,-774,-822,-876,-930,-984]

  flug1 = 1
  flug2 = 1
  flug3 = 1
  koyaku = 0
  game = 0
  samai = 0
  Window.loop do

    #flug = 0 回転中
    #flug = 1 停止中
    #koyaku = 3 トマト
    #koyaku = 2 下段リンゴ
    #koyaku = 1 リプ
    #koyaku = 0 ハズレ

    Window.draw(142, x, Image[:RenoL])
    Window.draw(142, x-rlres, Image[:RenoL])
    Window.draw(262, y, Image[:RenoC])
    Window.draw(262, y-rlres, Image[:RenoC])
    Window.draw(382, z, Image[:RenoR])
    Window.draw(382, z-rlres, Image[:RenoR])
    Window.draw(0, 0, Image[:Reno])

    Window.draw_box_fill(0, 0, Window.width, 50, [0,0,0])

    if koyaku == 1
      Window.draw_font(0, 15, "リプレイ", Font.default, color: C_WHITE)
    elsif koyaku == 3
      Window.draw_font(0, 15, "トマト", Font.default, color: C_WHITE)      
    else
      Window.draw_font(0, 15, "ハズレ", Font.default, color: C_WHITE)
    end

    Window.draw_font(200, 15, "ゲーム数:", Font.default, color: C_WHITE)
    Window.draw_font(310, 15, game, Font.default, color: C_WHITE)

    Window.draw_font(400, 15, "差枚:", Font.default, color: C_WHITE)
    Window.draw_font(470, 15, samai, Font.default, color: C_WHITE)

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
      if  koyaku == 1
        r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 3
        r3 = [seigyo[17],seigyo[12],seigyo[7],seigyo[2]]
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



    if Input.key_down?(K_DOWN) && flug2 == 0
      Sound[:stop].play
      if  koyaku == 3
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
    end

    if koyaku == 1 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_LEFT) == false
      t = 1
      Sound[:rep].play 
    end

    if koyaku == 3 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_LEFT) == false
      t = 1
      Sound[:tomato].play 
      samai += 250
    end


    if Input.key_down?(K_RIGHT) && flug3 == 0
      Sound[:stop].play
      if  koyaku == 3
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
      flug1 = 0
      flug2 = 0
      flug3 = 0
      if rand(7774) <= 99
        koyaku = 3
      elsif rand(2048) <= 9
        koyaku = 2
      elsif rand(296) <= 99
        koyaku = 1
      else
        koyaku = 0
      end
      t = 0
    end
  













     if   a == true
      a = false
      if flug1 == 0 && flug2 == 1  && flug3 == 1
        Sound[:stop].play
        if  koyaku == 1
          r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
          ans1 = r3.min_by{|a| (a-x).abs}
          ansc = r3.index(ans1)
          if ans1 <= x
            x = r3[ansc-1]
          else
            x = ans1
          end
        elsif  koyaku == 3
          r3 = [seigyo[17],seigyo[12],seigyo[7],seigyo[2]]
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
        if  koyaku == 3
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
  
      if koyaku == 3 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0
        t = 1
        Sound[:tomato].play
        samai += 250
        break
      end
  
  
      if flug3 == 0
        Sound[:stop].play
        if  koyaku == 3
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
        game += 1
        Sound[:start].play
        flug1 = 0
        flug2 = 0
        flug3 = 0
        if rand(7774) <= 99
          koyaku = 3
        elsif rand(2048) <= 9
          koyaku = 2
        elsif rand(296) <= 99
          koyaku = 1
        else
          koyaku = 0
        end
        t = 0
        break
      end
    end



    %x{
      document.getElementById('run').addEventListener('click', function(){
        a = true
      });
    }
  end
end
