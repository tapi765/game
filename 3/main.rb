require 'dxopal'
include DXOpal

Image.register(:left, 'notes/arrow_left.png')
Image.register(:up, 'notes/arrow_up.png')
Image.register(:down, 'notes/arrow_down.png')
Image.register(:right, 'notes/arrow_right.png')
Image.register(:onigiri, 'notes/onigiri.png')

Image.register(:pl, 'notes/p_left.png')
Image.register(:pu, 'notes/p_up.png')
Image.register(:pd, 'notes/p_down.png')
Image.register(:pr, 'notes/p_right.png')
Image.register(:po, 'notes/p_onigiri.png')


Image.register(:kita, 'notes/kita.png')
Image.register(:mata, 'notes/matari.png')
Image.register(:uwan, 'notes/uwan.png')

Sound.register(:music, 'EMERALDAS.wav')

url = "fumen.txt"
req = Native(`new XMLHttpRequest()`)
req.overrideMimeType("text/plain")
req.open("GET", url, false)
req.send
s = req.responseText
s = s.split(",")


bpm = s[0].chomp.to_i
speed = 240 / bpm
frame = speed * 60
time = s.length
time2 = time - 1

t = 0
tt = 0
ttt = 0
tttt = 0
ttttt = 0
a = 0
left = []
up = []
down = []
right = []
onigiri = []

time2.times do
  z = 1
  data = s[a+1].chars
  len = data.length - 1
  delay = 640 / len
  len.times do
    if data[z] == "1"
      left[t] = a * 640 + delay * (z-1)
      t += 1
    elsif data[z] == "2"
      down[tt] = a * 640 + delay * (z-1)
      tt += 1
    elsif data[z] == "3"
      up[ttt] = a * 640 + delay * (z-1)
      ttt += 1
    elsif data[z] == "4"
      right[tttt] = a * 640 + delay * (z-1)
      tttt += 1
    elsif data[z] == "5"
      onigiri[ttttt] = a * 640 + delay * (z-1)
      ttttt += 1
    elsif data[z] == "a"
      left[t] = a * 640 + delay * (z-1)
      t += 1
      down[tt] = a * 640 + delay * (z-1)
      tt += 1
    elsif data[z] == "b"
      left[t] = a * 640 + delay * (z-1)
      t += 1
      up[ttt] = a * 640 + delay * (z-1)
      ttt += 1
    elsif data[z] == "c"
      left[t] = a * 640 + delay * (z-1)
      t += 1
      right[tttt] = a * 640 + delay * (z-1)
      tttt += 1
    elsif data[z] == "d"
      down[tt] = a * 640 + delay * (z-1)
      tt += 1
      up[ttt] = a * 640 + delay * (z-1)
      ttt+= 1
    elsif data[z] == "e"
      down[tt] = a * 640 + delay * (z-1)
      tt += 1
      right[tttt] = a * 640 + delay * (z-1)
      tttt += 1      
    elsif data[z] == "f"
      up[ttt] = a * 640 + delay * (z-1)
      ttt += 1
      right[tttt] = a * 640 + delay * (z-1)
      tttt += 1
    elsif data[z] == "w"
      left[t] = a * 640 + delay * (z-1)
      t += 1
      onigiri[ttttt] = a * 640 + delay * (z-1)
      ttttt += 1
    elsif data[z] == "x"
      down[tt] = a * 640 + delay * (z-1)
      tt += 1
      onigiri[ttttt] = a * 640 + delay * (z-1)
      ttttt += 1
    elsif data[z] == "y"
      up[ttt] = a * 640 + delay * (z-1)
      ttt += 1
      onigiri[ttttt] = a * 640 + delay * (z-1)
      ttttt += 1
    elsif data[z] == "z"
      right[tttt] = a * 640 + delay * (z-1)
      tttt += 1
      onigiri[ttttt] = a * 640 + delay * (z-1)
      ttttt += 1
    end       
    z += 1
  end
  a += 1
end

20.times do
  left.push(123456789)
  up.push(123456789)
  down.push(123456789)
  right.push(123456789)
  onigiri.push(123456789)
end

conbo = 0
Window.load_resources do
  Window.bgcolor = C_BLACK
  x = 740
  time = 0
  g = 0
  f = 0
  b = 0
  gg = 0
  ff = 0
  bb = 0
  o = 0
  hspeed= 1.to_i 
  re = "off"
  hantei1 = 0
  score = 0
  flug = 0
  Window.loop do
    if flug == 0 
      Window.draw_font(240, 300, "HYSPEED:#{hspeed.round(1)}", Font.default, color: C_WHITE)
      Window.draw_font(240, 350, "REVERSE:#{re}", Font.default, color: C_WHITE)
      Window.draw_font(200, 200, "START:SPACE_KEY", Font.default, color: C_WHITE)
      if re == "off"
        Window.draw(30, x*hspeed, Image[:left])
        Window.draw(30, 61, Image[:left])
        Window.draw_box_fill(0, 0, Window.width, 40, [0,0,0])     
        Window.draw_box_fill(0, 40, Window.width, 42, [255,255,255])
      else
        Window.draw(30, x*hspeed, Image[:left])
        Window.draw(30, Window.height-100, Image[:left])
        Window.draw_box_fill(0, 442, Window.width, 480, [0,0,0])     
        Window.draw_box_fill(0, 440, Window.width, 442, [255,255,255])
      end
      Window.draw_box_fill(100, 0, 102, Window.height, [255,255,255])
      if Input.key_push?(K_RIGHT)
        if hspeed <= 1.9
          hspeed += 0.1
        end
      end
      #if Input.key_push?(K_UP) || Input.key_push?(K_DOWN)
      #  if re == "on"
      #    re = "off"
      #  elsif re == "off"
      #    re = "on"
      #  end
      #end

      if Input.key_push?(K_LEFT)
        if hspeed >= 0.5
          hspeed -= 0.1
        end
      end

      if re == "off"
        x -= 640 / frame
      else
        x += 640 / frame
      end

      if x <= 0
        x = 479 / hspeed
      end

      if x >= Window.height / hspeed
        x = 0
      end
    end

    if Input.key_push?(K_SPACE)
      if flug == 0
        Sound[:music].play
        flug = 1
        x = 730
        x = x * hspeed
      end
    end

  if flug == 1
    if re == "off"
      x -= (640 / frame)*hspeed
    else
      x += (640 / frame)*hspeed
    end

    t = 0
    tt = 0
    ttt = 0
    tttt = 0
    ttttt = 0

    if Input.key_push?(K_I)
      x += 10
    end

    if Input.key_push?(K_O)
      x -= 10
    end

    8.times do
      Window.draw(151, left[t] * hspeed + x, Image[:left])
      t += 1
      if left[0] * hspeed + x <= -10
        left.delete_at(0)
        t += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(199, down[tt] * hspeed + x, Image[:down])
      tt += 1
      if down[0] * hspeed + x <= -10
        down.delete_at(0)
        tt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(250, up[ttt] * hspeed + x, Image[:up])
      ttt += 1
      if up[0] * hspeed + x <= -10
        up.delete_at(0)
        ttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(300, right[tttt] * hspeed + x, Image[:right])
      tttt += 1
      if right[0] * hspeed + x <= -10
        right.delete_at(0)
        tttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    16.times do
      Window.draw(350, onigiri[ttttt] * hspeed + x, Image[:onigiri])
      ttttt += 1
      if onigiri[0] * hspeed + x <= -10
        onigiri.delete_at(0)
        ttttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end
    
    hantei1 = 20*(hspeed - 1)

    if Input.key_push?(K_LEFT) || Input.key_push?(K_A)
    Window.draw(151, 61, Image[:pl])
    if left[0] * hspeed + x >= 40 - hantei1 && left[0] * hspeed + x <= 80 + hantei1
      left.delete_at(0)
      t += 1
      conbo += 1
      g += 1
      gg += 1
    elsif left[0] * hspeed + x >= -10 - hantei1 && left[0] * hspeed + x <= 130 + hantei1
      left.delete_at(0)
      t += 1
      conbo += 1
      f += 1
      ff += 1
    elsif left[0] * hspeed + x <= 200
      left.delete_at(0)
      t += 1
      conbo = 0
      b += 1
      bb += 1
    end    
    else
     Window.draw(150, 60, Image[:left])
    end
  



    if Input.key_push?(K_DOWN) || Input.key_push?(K_S)
      Window.draw(199, 61, Image[:pd])
      if down[0] * hspeed + x >= 40 - hantei1 && down[0] * hspeed + x <= 80 + hantei1
        down.delete_at(0)
        tt += 1
        conbo += 1
        g += 1
        gg += 1
      elsif down[0] * hspeed + x >= -10 - hantei1 && down[0] * hspeed + x <= 130 + hantei1
        down.delete_at(0)
        tt += 1
        conbo += 1
        f += 1
        ff += 1
      elsif down[0] * hspeed + x <= 200
        down.delete_at(0)
        tt += 1
        conbo = 0
        b += 1
        bb += 1
      end
     else
      Window.draw(199, 60, Image[:down])  
     end




    if Input.key_push?(K_UP) || Input.key_push?(K_D)
     Window.draw(252, 61, Image[:pu])
     if up[0] * hspeed + x >= 40 - hantei1 && up[0] * hspeed + x <= 80 + hantei1
      up.delete_at(0)
      ttt += 1
      conbo += 1
      g += 1
      gg += 1
     elsif up[0] * hspeed + x >= -10 - hantei1 && up[0] * hspeed + x <= 130 + hantei1
      up.delete_at(0)
      ttt += 1
      conbo += 1
      f += 1
      ff += 1
    elsif up[0] * hspeed + x <= 200
      up.delete_at(0)
      ttt += 1
      conbo = 0
      b += 1
      bb += 1
     end
    else
     Window.draw(250, 60, Image[:up])  
    end


    if Input.key_push?(K_RIGHT) || Input.key_push?(K_F)
     Window.draw(301, 59, Image[:pr])
     if right[0] * hspeed + x >= 40 - hantei1 && right[0] * hspeed + x <= 80 + hantei1
      right.delete_at(0)
      tttt += 1
      conbo += 1
      g += 1
      gg += 1
     elsif right[0] * hspeed + x >= -10 - hantei1 && right[0] * hspeed + x <= 130 + hantei1
      right.delete_at(0)
      tttt += 1
      conbo += 1
      f += 1   
      ff += 1 
    elsif  right[0] * hspeed + x <= 200
      right.delete_at(0)
      tttt += 1
      conbo = 0
      b += 1   
      bb += 1 
    end
    else
     Window.draw(300, 60, Image[:right])  
    end



    if Input.key_push?(K_SPACE) || Input.key_push?(K_ENTER)  || Input.key_push?(K_G) || Input.key_push?(K_RSHIFT)
      Window.draw(350, 59, Image[:po])
      if onigiri[0] * hspeed + x >= 40 - hantei1 && onigiri[0] * hspeed + x <= 80 + hantei1
        onigiri.delete_at(0)
        ttttt += 1
        conbo += 1
        g += 1
        gg += 1
       elsif onigiri[0] * hspeed + x >= -10 - hantei1 && onigiri[0] * hspeed + x <= 130 + hantei1
        onigiri.delete_at(0)
        ttttt += 1
        conbo += 1
        f += 1   
        ff += 1 
      elsif  onigiri[0] * hspeed + x <= 200
        onigiri.delete_at(0)
        ttttt += 1
        conbo = 0
        b += 1   
        bb += 1 
      end
     else
      Window.draw(350, 60, Image[:onigiri])  
    end

     Window.draw_box_fill(0, 0, 450, 40, [0,0,0])     
     Window.draw_box_fill(0, 40, 450, 42, [255,255,255])
     
     Window.draw_box_fill(450, 0, 452, Window.height, [255,255,255])
     Window.draw_box_fill(452, 0, Window.width, Window.height, [0,0,0])

     if b >= 1
      if b >= 2
        o = 0
        b = 1
      end
      if o <= 20 && b == 1
        g = 0 
        f = 0
        Window.draw(150, o, Image[:uwan])
        o += 1.5
      elsif o >= 21
        o = 0
        b = 0
      end
    end

    if g >= 1 
      if g >= 2 
        o = 0
        g = 1
      end
      if o <= 20 && g == 1
        f = 0
        b = 0
        Window.draw(150, o, Image[:kita])
        Window.draw_font(250, o, conbo, Font.default, color: C_WHITE)
        o += 1.5
      elsif o >= 21
        o = 0
        g = 0
      end
    end

    if f >= 1
      if f >= 2
        o = 0
        f = 1
      end
      if o <= 20 && f == 1
        g = 0
        b = 0
        Window.draw(150, o, Image[:mata])
        Window.draw_font(250, o, conbo, Font.default, color: C_WHITE)
        o += 1.5
      elsif o >= 21
        o = 0
        f = 0
      end
    end



    Window.draw(500, 10, Image[:kita])
    Window.draw(500, 60, Image[:mata])
    Window.draw(500, 110, Image[:uwan])
    Window.draw_font(520, 35, gg, Font.default, color: C_WHITE)
    Window.draw_font(520, 85, ff, Font.default, color: C_WHITE)
    Window.draw_font(520, 135, bb, Font.default, color: C_WHITE)

    Window.draw_font(500, 220, "CONBO", Font.default, color: C_WHITE)
    Window.draw_font(520, 250, conbo, Font.default, color: C_WHITE)
    score = gg * 100 + ff * 30
    Window.draw_font(500, 320, "SCORE", Font.default, color: C_WHITE)
    Window.draw_font(520, 350, score, Font.default, color: C_WHITE)

    if gg + ff + bb == 865
      Window.draw_font(240, 350, "END", Font.default, color: C_WHITE)
    end
  end
end
end