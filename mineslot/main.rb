require 'dxopal'
include DXOpal
#フレーム
Image.register(:Reno, 'files/Reno2.png')
Image.register(:RenoL, 'files/L.png')
Image.register(:RenoC, 'files/C.png')
Image.register(:RenoR, 'files/R.png')
Image.register(:gogof, 'files/gogof.png')
Image.register(:gogot, 'files/gogot.png')
#液晶
Image.register(:title, 'files/title.png')
Image.register(:isi1, 'files/isi1.png')
Image.register(:isi2, 'files/isi2.png')
Image.register(:isi3, 'files/isi3.png')
Image.register(:isi3rep, 'files/isi3rep.png')
Image.register(:isi4bell, 'files/isi4bell.png')
Image.register(:sougen, 'files/sougen.png')
Image.register(:chest1, 'files/Chest1.png')
Image.register(:chest2, 'files/Chest2.png')
#BONUS
Image.register(:chestbonus, 'files/chestbonus.png')
Image.register(:BIGBONUS, 'files/BIGBONUS.png')

Sound.register(:bet, 'sounds/bet.wav')
Sound.register(:start, 'sounds/start.wav')
Sound.register(:stop, 'sounds/stop.wav')
Sound.register(:rep, 'sounds/replay.wav')
Sound.register(:trep, 'sounds/treplay.wav')
Sound.register(:bell, 'sounds/12.wav')
Sound.register(:suica, 'sounds/suica.wav')
Sound.register(:REG, 'sounds/REG.wav')
Sound.register(:BIG1, 'sounds/BIG1cat.wav')
Sound.register(:gako, 'sounds/gako.wav')
Sound.register(:chest2, 'sounds/chest2.wav')


Window.load_resources do
  Window.bgcolor = C_BLACK
  rlres = -1200
  x = rlres
  y = rlres
  z = rlres
  t = 0
  a = 0 #通常時画面移動
  da = -1 #通常時画面移動
  seigyo = [0,-60,-120,-180,-240,-300,-360,-420,-480,-540,-600,-660,-720,-780,-840,-900,-960,-1020,-1080,-1140]
  flug1 = 1 
  flug2 = 1
  flug3 = 1
  koyaku = 0
  game = 0
  samai = 0
  tyusen = 0
  payout = 0
  random = 0
  zyoutai = 0 # 0通常時 1ボーナス成立 2ボーナス中 3ART
  zbonus = 0 #1BIG 2REG
  last = 0 # ボーナス残り枚数
  lgame = 0  #ART残りゲーム
  start = 0 #BGMloop
  saisei = 0 #bgm 0停止 1再生
  gako = 0 #ガコ0 なし 1音待機 2ランプ点灯
  nbox = 0 #REG中宝箱
  rbox = 0 #REG中宝箱レア
  Window.loop do

    #flug = 0 回転中
    #flug = 1 停止中
    #koyaku
    # 1/8192 中リンゴ 0
    # 1/819チャンス目 1
    # 1/512強リンゴ 2
    # 1/256サボテン 3
    # 1/128弱リンゴ 4
    # 1/64特リプ 5
    # 1/16ベル 6
    # 1/16リプレイ 8
    # 1/512REG 9
    # 1/256BIG 10
    #ハズレ 7


    #リール
    Window.draw(142, x+15, Image[:RenoL])
    Window.draw(142, x-rlres+15, Image[:RenoL])
    Window.draw(258, y+15, Image[:RenoC])
    Window.draw(258, y-rlres+15, Image[:RenoC])
    Window.draw(374, z+15, Image[:RenoR])
    Window.draw(374, z-rlres+15, Image[:RenoR])


    #演出
    if koyaku == 8 #リプレイ
      if flug1 + flug2 + flug3 == 0
        Window.draw(142, 19, Image[:isi1])
      elsif flug1 + flug2 + flug3 == 1
        Window.draw(142, 19, Image[:isi2]) 
      else
        Window.draw(142, 19, Image[:isi3rep])
      end
    elsif koyaku == 6 || koyaku == 66 #ベル
      if flug1 + flug2 + flug3 == 0
        Window.draw(142, 19, Image[:isi1])
      elsif flug1 + flug2 + flug3 == 1
        Window.draw(142, 19, Image[:isi2]) 
      elsif flug1 + flug2 + flug3 == 2
        Window.draw(142, 19, Image[:isi3])       
      else
        Window.draw(142, 19, Image[:isi4bell])           
      end
    else
      Window.draw(a+da, 19, Image[:sougen])
      a += da
      if a <= -350 || a >= 142
        da = -da
      end
    end

    #ボーナス中
    if zyoutai == 2 && zbonus == 2  #reg
      Window.draw(142, 19, Image[:chestbonus])
      Window.draw_box_fill(142, 19, 492, 70, [128,128,128])
      Window.draw_font(142, 30, "LAST:#{last}", Font.default)
      Window.draw_font(322, 30, "X #{nbox}", Font.default)
      Window.draw_font(442, 30, "X #{rbox}", Font.default)
      start = 1
      if last <= 0
        Sound[:REG].stop
        start = 0
        saisei = 0
        zyoutai = 0
      end
      Window.draw(260, 20, Image[:chest1])
      Window.draw(382, 20, Image[:chest2])
    elsif  zyoutai == 2 && zbonus == 1  #big
      Window.draw(142, 19, Image[:BIGBONUS])
      Window.draw_box_fill(142, 19, 492, 50, [128,128,128])
      Window.draw_font(142, 19, "LAST:#{last}", Font.default)
      start = 1
      if last <= 0
        Sound[:BIG1].stop
        start = 0
        saisei = 0
        zyoutai = 0
      end
    end



    #BGM 設定 1REG 
    if start == 1 && saisei == 0  && zbonus == 2
      Sound[:REG].play
      saisei = 1
    elsif start == 1 && saisei == 0 && zbonus == 1
      Sound[:BIG1].play
      saisei = 1
    end


   #フレーム
    Window.draw(0, -25, Image[:Reno])
   if  zyoutai != 1 || gako != 2
    Window.draw(77, 390, Image[:gogof])
   elsif gako == 2
    Window.draw(77, 390, Image[:gogot])
   end


  #リール制御
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

    #左リール
    if Input.key_down?(K_LEFT) && flug1 == 0
      Sound[:stop].play
      if  koyaku == 7 || koyaku == 3
        r3 = [seigyo[1],seigyo[6],seigyo[11],seigyo[16]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 6 || koyaku == 11
        r3 = [seigyo[1],seigyo[6],seigyo[11],seigyo[16]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 8 || koyaku == 9 || koyaku == 5
        r3 = [seigyo[2],seigyo[7],seigyo[12],seigyo[17]]
        ans1 = r3.min_by{|a| (a-x).abs}
        ansc = r3.index(ans1)
        if ans1 <= x
          x = r3[ansc-1]
        else
          x = ans1
        end
      elsif  koyaku == 10
        r3 = [seigyo[3],seigyo[8],seigyo[13],seigyo[18]]
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

    #下リール
    if Input.key_down?(K_DOWN) && flug2 == 0
      Sound[:stop].play
        if  koyaku == 7 || koyaku == 3
        r3 = [seigyo[3],seigyo[8],seigyo[13],seigyo[18]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 6 || koyaku == 11
        r3 = [seigyo[4],seigyo[9],seigyo[14],seigyo[19]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 8 || koyaku == 5
        r3 = [seigyo[0],seigyo[5],seigyo[10],seigyo[15]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 9
        r3 = [seigyo[2],seigyo[7],seigyo[12],seigyo[17]]
        ans2 = r3.min_by{|a| (a-y).abs}
        ansc = r3.index(ans2)
        if ans2 <= y
          y = r3[ansc-1]
        else
          y = ans2
        end
      elsif  koyaku == 10
        r3 = [seigyo[2],seigyo[7],seigyo[12],seigyo[17]]
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

    #リプレイ
    if koyaku == 8 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_RIGHT) == false
      t = 1
      Sound[:rep].play 
    end

    #特リプレイ
    if koyaku == 5 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_RIGHT) == false
      t = 1
      Sound[:trep].play 
    end
    #ベル
    if koyaku == 6 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_RIGHT) == false
      Sound[:bell].play
      payout = 12 
      samai += payout
      if last >= 1
        last = last - 12
        if last <= 0 
          last = 0
        end
      end
      koyaku = 66
    end

    #スイカ
    if koyaku == 3 && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0 && Input.key_down?(K_RIGHT) == false
      Sound[:suica].play
      payout = 8
      samai += payout
      koyaku = 88
    end

    #右停止
    if Input.key_down?(K_RIGHT) && flug3 == 0
      Sound[:stop].play
      if  koyaku == 7
        r3 = [seigyo[0],seigyo[5],seigyo[10],seigyo[15]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif  koyaku == 3
        r3 = [seigyo[1],seigyo[6],seigyo[11],seigyo[16]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 6
        r3 = [seigyo[3],seigyo[8],seigyo[13],seigyo[18]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 8
        r3 = [seigyo[1],seigyo[6],seigyo[11],seigyo[16]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 5
        r3 = [seigyo[0],seigyo[5],seigyo[10],seigyo[15]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 9
        r3 = [seigyo[1],seigyo[6],seigyo[11],seigyo[16]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 10
        r3 = [seigyo[16],seigyo[11],seigyo[6],seigyo[1]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 11
        r3 = [seigyo[0],seigyo[5],seigyo[10],seigyo[15]]
        ans3 = r3.min_by{|a| (a-z).abs}
        ansc = r3.index(ans3)
        if ans3 <= z
          z = r3[ansc-1]
        else
          z = ans3
        end
      elsif koyaku == 0
        r3 = [seigyo[0],seigyo[15],seigyo[10],seigyo[5]]
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

    if Input.key_down?(K_UP) && flug1 == 1 && flug2 == 1 && flug3 == 1 && t == 0  && Input.key_down?(K_SPACE) == false
      t = 1
      samai -= 3
      Sound[:bet].play
      if zyoutai != 1
        koyaku = 7
      end
    end

    if zyoutai == 2 && flug1 + flug2 + flug3 == 3
      if koyaku == 66
        nbox += 1
        koyaku = -1
      elsif koyaku == 11
        rbox += 1
        koyaku = -1
        Sound[:chest2].play
      end
    end


    if zyoutai == 1 && flug1 + flug2 + flug3 == 3
      if gako == 1
        Sound[:gako].play
        gako = 2
      end

      if x == -1080 && y == -1020 && z == -960
        zyoutai = 2
        last = 265
        tyusen = 0
        zbonus = 1
        gako = 0
      elsif x == -480 && y == -420 && z == -360
        zyoutai = 2
        last = 265
        tyusen = 0
        zbonus = 1
        gako = 0
      elsif  x == -1020 && y == -1020 && z == -960
        zyoutai = 2
        last = 61
        tyusen = 0
        zbonus = 2
        gako = 0
      end
    end

    #抽選
    if Input.key_down?(K_SPACE) && t == 1  && Input.key_down?(K_UP) == false
      Sound[:start].play
      game += 1
      flug1 = 0
      flug2 = 0
      flug3 = 0
      random = rand(8192)
      if tyusen == 0 && zyoutai == 0
        if random <= 0 # 1/8192 中リンゴ
          koyaku = 0
        elsif random <= 10 # 1/819チャンス目
          koyaku = 1
        elsif random <= 26 # 1/512強リンゴ
          koyaku = 2
        elsif random <= 58 # 1/256サボテン 58
          koyaku = 3
        elsif random <= 122 # 1/128弱リンゴ
          koyaku = 4
        elsif random <= 250 # 1/64特リプ
          koyaku = 5
        elsif random <= 762 # 1/16ベル
          koyaku = 6
        elsif random <= 1274 # 1/16リプ
          koyaku = 8
        elsif random <= 1302 # 1/512 REG 1290
          koyaku = 9
          zyoutai = 1
          gako = 1
        elsif random <= 1334 # 1/256 BIG 1322
          koyaku = 10
          zyoutai = 1
          gako = 1
        else
          koyaku = 7 # ハズレ7
        end
      end

      if zyoutai == 2
        if last >= 1
          random = rand(30)
          if random != 0
            koyaku = 6
          else
            koyaku = 11 # ベルテンハズレ
          end
        else
          zyoutai = 0
          last = 0
        end
      end
      t = 0
    end



    Window.draw_box_fill(0, 0, 130, 180, [0,0,0])
    Window.draw_font(0, 10, "収支", Font.default)
    Window.draw_font(0, 50, samai, Font.default)
    #Window.draw_font(0, 100, zyoutai, Font.default)


    %x{
      document.getElementById('run').addEventListener('click', function(){
        a = true
      });
    }
  end
end
