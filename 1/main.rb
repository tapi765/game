require "dxopal"
include DXOpal
Image.register(:dong, 'images/dong.png')
Image.register(:ka, 'images/ka.png')

Sound.register(:dong, 'sounds/dong.wav')
Sound.register(:ka, 'sounds/ka.wav')
Sound.register(:music, 'music/Angel_Halo.wav')

url = "fumen/Angel_Halo.txt"
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
GROUND_Y = 100
t = 0
tt = 0
a = 0

don = []
ka = []
time2 = time - 1

time2.times do
  z = 2
  data = s[a+1].chars
  len = data.length - 2
  delay = 640 / len
  len.times do
    if data[z] == "3" || data[z] == "1"
      don[t] = a * 640 + delay * (z-2)
      t += 1
    elsif data[z] == "2" || data[z] == "4"
      ka[tt] = a * 640 + delay * (z-2)
      tt += 1
    end
    z += 1
  end
  a += 1
end

conbo = 0
22.times do
  don.push(1000000000000000000000000)
end
22.times do
  ka.push(10000000000000000000000000)
end

good = 0
bad = 0
miss = 0

flug = 0
score = 0
Window.load_resources do
  x = 1080

f = 0
  Window.loop do
    Window.draw_box_fill(0, 0, Window.width, Window.height,[0, 0, 0] )
    Window.draw_font(0, 0, score, Font.default, color: C_WHITE)


    Window.draw_circle(70,90,37, [255,255,255])
    t = 0
    tt = 0
    if flug == 0 
      Window.draw_font(200, 200, "START:key[f] or [j]", Font.default, color: C_WHITE)
    end

    if Input.key_push?(K_F) || Input.key_push?(K_J)
      if flug == 0
        Sound[:music].play
        flug = 1
      end
    end

    if flug == 1
      x -= 640/frame
      Window.draw_font(60, 350, "good:#{good}", Font.default, color: C_WHITE)
      Window.draw_font(60, 380, "bad:#{bad}", Font.default, color: C_WHITE)
      Window.draw_font(60, 410, "miss:#{miss}", Font.default, color: C_WHITE)
      20.times do
          Window.draw(don[t] + x, 126 - Image[:dong].height, Image[:dong])
          t += 1
          if don[t] + x <= 40
            don.delete_at(0)
            t += 1
            conbo = 0
            miss += 1
          end
      end
      f += 1

      20.times do
          Window.draw(ka[tt] + x, 126 - Image[:ka].height, Image[:ka])
        tt += 1
        if ka[tt] + x <= 40
          ka.delete_at(0)
          tt += 1
          conbo = 0
          miss += 1
        end
      end  

      if Input.key_push?(K_F) || Input.key_push?(K_J)
          Sound[:dong].play
          if don[0] + x >= 51+(60/speed) && don[0] + x <= 200-(60/speed)
            conbo = 0
            don.delete_at(0)
            t += 1
            bad += 1
          elsif don[0] + x >= 45-(60/speed) && don[0] + x <= 50+(60/speed)
            score += 10 + conbo
            don.delete_at(0)
            t += 1
            conbo += 1
            good += 1
          end
      end

      if Input.key_push?(K_D) || Input.key_push?(K_K)
          Sound[:ka].play
          if ka[0] + x >= 51+(60/speed) && ka[0] + x <= 200-(60/speed)
            conbo = 0
            don.delete_at(0)
            tt += 1
            bad += 1
          elsif ka[0] + x >= 40-(60/speed) && ka[0] + x <= 60+(60/speed)
            score += 10 + conbo
            ka.delete_at(0)
            tt += 1
            conbo += 1
            good += 1
          end
      end

      if conbo >= 10
        Window.draw_font(60, 80, conbo, Font.default, color: C_WHITE)
      end

    end

  end
end