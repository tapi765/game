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

Sound.register(:music, 'naito_of_naitu.wav')

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
  z = 2
  data = s[a+1].chars
  len = data.length - 2
  delay = 640 / len
  len2 = len + 1
  len2.times do
    if data[z] == "1"
      left[t] = a * 640 + delay * (z-2)
      t += 1
    elsif data[z] == "2"
      down[tt] = a * 640 + delay * (z-2)
      tt += 1
    elsif data[z] == "3"
      up[ttt] = a * 640 + delay * (z-2)
      ttt += 1
    elsif data[z] == "4"
      right[tttt] = a * 640 + delay * (z-2)
      tttt += 1
    elsif data[z] == "5"
      onigiri[ttttt] = a * 640 + delay * (z-2)
      ttttt += 1
    elsif data[z] == "a"
      left[t] = a * 640 + delay * (z-2)
      t += 1
      up[ttt] = a * 640 + delay * (z-2)
      ttt += 1
    elsif data[z] == "b"
      left[t] = a * 640 + delay * (z-2)
      t += 1
      down[tt] = a * 640 + delay * (z-2)
      tt += 1
    elsif data[z] == "c"
      left[t] = a * 640 + delay * (z-2)
      t += 1
      right[tttt] = a * 640 + delay * (z-2)
      tttt += 1
    elsif data[z] == "d"
      down[tt] = a * 640 + delay * (z-2)
      tt += 1
      up[ttt] = a * 640 + delay * (z-2)
      ttt+= 1
    elsif data[z] == "e"
      down[tt] = a * 640 + delay * (z-2)
      tt += 1
      right[tttt] = a * 640 + delay * (z-2)
      tttt += 1      
    elsif data[z] == "f"
      up[ttt] = a * 640 + delay * (z-2)
      ttt += 1
      right[tttt] = a * 640 + delay * (z-2)
      tttt += 1     
    end       
    z += 1
  end
  a += 1
end

20.times do
  left.push(1000000000000000000000000)
  up.push(1000000000000000000000000)
  down.push(1000000000000000000000000)
  right.push(1000000000000000000000000)
  onigiri.push(10000000000000000000000)
end

conbo = 0
Window.load_resources do
  Window.bgcolor = C_BLACK
  x = 5690
  time = 0
  g = 0
  f = 0
  b = 0
  gg = 0
  ff = 0
  bb = 0
  o = 0
  score = 0
  flug = 0
  Window.loop do
    if flug == 0 
      Window.draw_font(200, 200, "START:SPACE key", Font.default, color: C_WHITE)
    end

    if Input.key_push?(K_SPACE)
      if flug == 0
        Sound[:music].play
        flug = 1
      end
    end

  if flug == 1
    x -= 640 / frame
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
      Window.draw(151, left[t] + x, Image[:left])
      t += 1
      if left[0] + x <= -10
        left.delete_at(0)
        t += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(199, down[tt] + x, Image[:down])
      tt += 1
      if down[0] + x <= -10
        down.delete_at(0)
        tt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(250, up[ttt] + x, Image[:up])
      ttt += 1
      if up[0] + x <= -10
        up.delete_at(0)
        ttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    8.times do
      Window.draw(300, right[tttt] + x, Image[:right])
      tttt += 1
      if right[0] + x <= -10
        right.delete_at(0)
        tttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end

    16.times do
      Window.draw(350, onigiri[ttttt] + x, Image[:onigiri])
      ttttt += 1
      if right[0] + x <= -10
        onigiri.delete_at(0)
        ttttt += 1
        b += 1
        bb += 1
        conbo = 0
      end
    end


    if Input.key_push?(K_LEFT)
    Window.draw(151, 61, Image[:pl])
    if left[0] + x >= 40 && left[0] + x <= 80
      left.delete_at(0)
      t += 1
      conbo += 1
      g += 1
      gg += 1
    elsif left[0] + x >= -10 && left[0] + x <= 130
      left.delete_at(0)
      t += 1
      conbo += 1
      f += 1
      ff += 1
    elsif left[0] + x <= 250
      left.delete_at(0)
      t += 1
      conbo = 0
      b += 1
      bb += 1
    end    
    else
     Window.draw(150, 60, Image[:left])
    end
  



    if Input.key_push?(K_DOWN)
      Window.draw(199, 61, Image[:pd])
      if down[0] + x >= 40 && down[0] + x <= 80
        down.delete_at(0)
        tt += 1
        conbo += 1
        g += 1
        gg += 1
      elsif down[0] + x >= -10 && down[0] + x <= 130
        down.delete_at(0)
        tt += 1
        conbo += 1
        f += 1
        ff += 1
      elsif down[0] + x <= 250
        down.delete_at(0)
        tt += 1
        conbo = 0
        b += 1
        bb += 1
      end
     else
      Window.draw(199, 60, Image[:down])  
     end




    if Input.key_push?(K_UP)
     Window.draw(252, 61, Image[:pu])
     if up[0] + x >= 40 && up[0] + x <= 80
      up.delete_at(0)
      ttt += 1
      conbo += 1
      g += 1
      gg += 1
     elsif up[0] + x >= -10 && up[0] + x <= 130
      up.delete_at(0)
      ttt += 1
      conbo += 1
      f += 1
      ff += 1
    elsif up[0] + x <= 250
      up.delete_at(0)
      ttt += 1
      conbo = 0
      b += 1
      bb += 1
     end
    else
     Window.draw(250, 60, Image[:up])  
    end


    if Input.key_push?(K_RIGHT)
     Window.draw(301, 59, Image[:pr])
     if right[0] + x >= 40 && right[0] + x <= 80
      right.delete_at(0)
      tttt += 1
      conbo += 1
      g += 1
      gg += 1
     elsif right[0] + x >= -10 && right[0] + x <= 130
      right.delete_at(0)
      tttt += 1
      conbo += 1
      f += 1   
      ff += 1 
    elsif  right[0] + x <= 250
      right.delete_at(0)
      tttt += 1
      conbo = 0
      b += 1   
      bb += 1 
    end
    else
     Window.draw(300, 60, Image[:right])  
    end



    if Input.key_push?(K_SPACE) || Input.key_push?(K_ENTER) 
      Window.draw(350, 59, Image[:po])
      if onigiri[0] + x >= 40 && onigiri[0] + x <= 80
        onigiri.delete_at(0)
        ttttt += 1
        conbo += 1
        g += 1
        gg += 1
       elsif onigiri[0] + x >= -10 && onigiri[0] + x <= 130
        onigiri.delete_at(0)
        ttttt += 1
        conbo += 1
        f += 1   
        ff += 1 
      elsif  onigiri[0] + x <= 250
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
  end
end
end