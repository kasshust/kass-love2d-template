---ゲーム作成 manager経由で取得してね
M_textGame = {
    new = function()
      local obj = instance(M_textGame,GameManager)
      
      return obj
    end;
    update = function(dt)
      
      if love.mouse.wasPressed(1) then
      end
      if love.mouse.wasPressed(2) then
      end
      if love.keyboard.wasPressed("t") then
      end
    end;
    drawGUI = function(self)
      --　マウスの位置を表示
      --g.setColor(1,0.5,0.5,0.5)
      --g.rectangle("fill",math.floor(m_x/16)*16,math.floor(m_y/16)*16,16,16)
      --g.setColor(1,1,1,1)
    end;
  
    --save load
    save = function(self)
      --love.filesystem.write("banka.lua",Tserial.pack(savedata))
    end;

    save_init = function(self)
        --[[
            --savedata = {}
            --savedataの構造
            --savedata[1] = {clear = 1}
            --savedata[2] = {clear = 2}
            --savedata[3] = {clear = 3}
        
            --love.filesystem.write("banka.lua",Tserial.pack(savedata))
            --return savedata
        ]]--
    end;
    
    load = function(self)
      --[[
        savedata = {}
      if not love.filesystem.exists("banka.lua") then
        savedata = Manager.save_init()
      else
        savedata = Tserial.unpack(love.filesystem.read("banka.lua"))
      end
      ]]
    end;
    
};

-- textGameのデバッグルーム
DebugRoom_TextGame = {
    new = function(property)
      local obj = instance(DebugRoom_TextGame,OtherRoom,property)
      obj.frame = 0
      obj.name = "textgame"
      obj.s = Select.new(1,5)
      obj.tw = {num = 1}
      obj.tween = tween.new(0.1,obj.tw, {num = obj.s.now}, tween.easing.outBounce)
    
      return obj
    end;
    u = function(self,dt)
      local bool2 = self.s:check()
      if bool2 then
        self.tween = tween.new(0.1,self.tw, {num = self.s.now}, tween.easing.outBounce)
        g_soundmanager:play("game/materials/sound/se/se_test.wav")
      end
  
      local bool = controller.wasPressed("a")
  
      if bool then
        local switch = {}
        switch[1] = function()
          trans(T_normal,Room_TextGameTitle)
        end
        switch[2] = function()
        end
        switch[3] = function()
        end
        switch[4] = function()
        end
        switch[5] = function()
        end
          switch[self.s.now]()
        end
        self.tween:update(dt)
      end;
      
    d = function(self)
    end;
    dg = function(self)
      ---背景
      g.setColor(32,32,48)
      g.rectangle("fill",0,0,W,H)
      g.setColor(255,255,255)

      ---text
      local text = {"textgame","nil","nil","nil","nil"}
      local explain = {"","","","",""}

      local x,y,dif = 100,120,18
      local wi_x,wi_y = x-30,y-16
      g.setColor(0,0,0)
      g.rectangle("fill",wi_x,wi_y,200,48)
      g.setColor(255,255,255)
      g.rectangle("line",wi_x,wi_y,200,48)
      g.print(explain[self.s.now],wi_x,y-30)
      love.graphics.cut(wi_x,wi_y,200,48,function()
          for i,v in pairs(text) do
            g.print(v,x,y + (-self.tw.num+i) * dif,0,1 - 0.3*math.abs((i-self.tw.num)), 1 - 0.3*math.abs((i-self.tw.num)))
          end
          g.print("→",x-20,y)
        end)
    end;
  }

  -- textGameのタイトル

  Room_TextGameTitle = {
  new = function(property)
    local obj = instance(Room_TextGameTitle,OtherRoom,property)
    obj.frame = 0
    obj.name = "model"
    obj.title = load_image("game/materials/images/test/spr_jld.png")
    obj.time = 0
    obj.line1 = {}
    obj.line2 = {}
    return obj
  end;
  u = function(self,dt)
    if controller.wasPressed("a") then trans(T_normal,DebugRoom_TextGame_GameRoom) end
  end;
  d = function(self)

    Sh_ClampColor:send("mouse",{love.mouse.getX(),love.mouse.getY()})
    --Sh_ClampColor:send("resolution",{320,240})
    Sh_ClampColor:send("Time",self.time/600)

    love.graphics.setShader(Sh_ClampColor)

    self.time = self.time + 1

    love.graphics.setColor(ASE.FRENCHGRAY)
    love.graphics.rectangle("fill",0,0,320,240)
    love.graphics.setColor(ASE.GREEN)
    love.graphics.setLineStyle( "rough")
    love.graphics.setLineWidth(1)
    love.graphics.setColor(ASE.WHITE)
    
    for y = 1,1 do
      for x = 1, 20 do
          love.graphics.setLineWidth(16)
          love.graphics.setColor(1,1,1,0.3)
          self.line1[x*2-1] = (x-1)*16
          self.line1[x*2] = 16*math.sin(x+self.time/10) +16*11
          self.line2[x*2-1] = 320-(x-1)*16
          self.line2[x*2] = 16*math.sin(x-self.time/10) +16*4
          
          love.graphics.line(self.line1[x*2-1],self.line1[x*2],self.line1[x*2-1],self.line1[x*2]+320)
          love.graphics.line(self.line2[x*2-1],self.line2[x*2],self.line2[x*2-1],self.line2[x*2]-320)

          love.graphics.setColor(ASE.GREEN)
          love.graphics.setLineWidth(1)
        
      end
      --love.graphics.line(self.line1)
      --love.graphics.line(self.line2)
    end
    
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.title,160,120+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)
    
    love.graphics.setColor(0.5,0.5,0.5,1)
    love.graphics.draw(self.title,160,122+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)
    love.graphics.setColor(0.5,0.5,0.5,1)
    love.graphics.draw(self.title,160,124+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)

    love.graphics.setShader()

  end;

  dg = function(self)
  end;
}

DebugRoom_TextGame_GameRoom = {
    
  new = function(property)
    local obj = instance(DebugRoom_TextGame_GameRoom,OtherRoom,property)
    obj.frame = 0
    obj.name = "TextGame_Room"
    obj.picture = load_image("game/materials/images/test/spr_post.png")
    obj.title = load_image("game/materials/images/test/spr_jld.png")
    obj.pict = load_image("game/materials/images/test/spr_building_background.png")

    obj.time = 0
    obj.texts = {}

    obj.light = true

    obj.m = love.audio.newSource("game/materials/sound/music/m_drum.wav", "stream")
    g_soundmanager:playMusic(obj.m)
    g_soundmanager:stopMusic()

    --csvの読み込み
    local file = io.open("C:\\Users\\kassh\\Desktop\\CreateGame\\love2d-gameEngine\\game\\text\\text.csv", "r")
    for line in file:lines() do
      table.insert(obj.texts,line)
      --print(line)
    end

    --文頭4byteを除去
    obj.texts[1] = string.sub(obj.texts[1], 4)
    obj.window = TextWindow.new(nil,obj.texts,W/2,H/2,W-30,H-30,0,0)

    return obj
  end;

  u = function(self,dt)
    self.time = self.time+1
    self.window:update(dt)

    if(controller.wasPressed("a"))then
      --g_camStand:shake(-10,10,2)
      --g_camStand:shake(10,10,2)
      --g_camStand:flashLight(2)
      --g_soundmanager:play("game/materials/sound/se/se_explosion2.wav")
    end;
  end;

  d = function(self)
    
    if math.random(100) > 99  then 
      --self.light = not self.light 
      --g_soundmanager:play("game/materials/sound/se/se_walk.wav")
    end 

    if(math.random(1000)>999) then
      g_soundmanager:play("game/materials/sound/music/silen.mp3")
    end
    

    Sh_ClampColor:send("mouse",{love.mouse.getX(),love.mouse.getY()})
    --Sh_ClampColor:send("resolution",{320,240})
    Sh_ClampColor:send("Time",self.time/600)

    if self.light == true then 
      love.graphics.setShader(Sh_ClampColor)
      love.graphics.setColor(1,1,1,1)
      
      love.graphics.draw(self.picture, 0, 0)

      --love.graphics.draw(self.pict,m_x,m_y,self.time/60,0.6,0.6,self.pict:getWidth()/2,self.pict:getHeight()/2)
      
      

      love.graphics.setShader()
    else
      love.graphics.setShader(Sh_ClampColor)
      love.graphics.setColor(1,1,0.4,0.6)
      love.graphics.draw(self.picture, 0, 0)
      love.graphics.setShader()
      love.graphics.setColor(1,1,1,1)
    end
  end;

  dg = function(self)
    self.window:drawGUI()
  end;
}