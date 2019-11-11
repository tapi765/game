require 'dxopal'
include DXOpal

Image.register(:Reno, 'files/Reno.png')
Image.register(:RenoL, 'files/RenoL.png')
Image.register(:RenoC, 'files/RenoC.png')
Image.register(:RenoR, 'files/RenoR.png')

Window.load_resources do
  Window.bgcolor = C_BLACK
  rlres = -1038
  x = rlres
  y = rlres
  z = rlres
  seigyo = [0,-48,-102,-152,-204,-258,-308,-358,-412,-464,-516,-568,-622,-672,-724,-774,-822,-876,-930,-984]

  flug1 = 1
  flug2 = 1
  flug3 = 1
  koyaku = 0
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

    Window.draw_font(0, 0, koyaku, Font.default, color: C_WHITE)
    Window.draw_font(100, 0, y, Font.default, color: C_WHITE)
    Window.draw_font(200, 0, z, Font.default, color: C_WHITE)
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
      ans1 = seigyo.min_by{|a| (a-x).abs}
      ansa = seigyo.index(ans1)
      if ans1 <= x
        x = seigyo[ansa-1]
      else
        x = ans1
      end
      flug1 = 1
    end

    if Input.key_down?(K_DOWN) && flug2 == 0
      if
        koyaku == 3
        r3 = [seigyo[15],seigyo[10],seigyo[5],seigyo[0]]
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



    if Input.key_down?(K_RIGHT) && flug3 == 0
      if
        koyaku == 3
        r3 = [seigyo[18],seigyo[13],seigyo[8],seigyo[3]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      else
        z = seigyo.min_by{|a| (a-z).abs}
      end
      flug3 = 1
    end

    if Input.key_down?(K_SPACE) && flug1 == 1 && flug2 == 1 && flug3 == 1
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
      koyaku = 3
    end
  end
end
