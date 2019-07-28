-- textGameのデバッグルーム
DebugRoom_FreedomGame = {
    new = function(property)
      local obj = instance(DebugRoom_FreedomGame,OtherRoom,property)
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
        soundmanager:play("game/materials/sound/se/se_test.wav")
      end
  
      local bool = controller.wasPressed("a")
  
      if bool then
        local switch = {}
        switch[1] = function()
          trans(T_normal,Room_FreedomGameTitle)
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

      local x,y,dif = W/2,H/2,18
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

  Room_FreedomGameTitle = {
  new = function(property)
    local obj = instance(Room_FreedomGameTitle,OtherRoom,property)
    obj.frame = 0
    obj.name = "model"
    obj.title = load_image("game/materials/images/test/spr_jld.png")
    obj.time = 0
    obj.line1 = {}
    obj.line2 = {}
    return obj
  end;
  u = function(self,dt)
    if controller.wasPressed("a") then trans(T_normal,DebugRoom_FreedomGame_GameRoom) end
  end;
  d = function(self)

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
    end
    
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(self.title,160,120+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)
    
    love.graphics.setColor(0.5,0.5,0.5,1)
    love.graphics.draw(self.title,160,122+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)
    love.graphics.setColor(0.5,0.5,0.5,1)
    love.graphics.draw(self.title,160,124+1*math.sin(self.time/10),0,1+0.02*math.cos(self.time/10),1+0.02*math.sin(self.time/10),160,120)
  end;

  dg = function(self)
  end;
}

DebugRoom_FreedomGame_GameRoom = {
  new = function(property)
    local obj = instance(DebugRoom_FreedomGame_GameRoom,BasicRoom,property)
    obj.frame = 0
    obj.name = "stage"
    obj.time = 0
    obj.char = O_Circle.new(200,200)
    obj.w = 320*8
    obj.h = 240*8
    obj.size = 16 

    obj.canvas = love.graphics.newCanvas(obj.w, obj.h)
    obj.canvas:setFilter("nearest")
    obj.canvas_shade = love.graphics.newCanvas(obj.w, obj.h)
    obj.canvas_shade:setFilter("nearest")

    soundmanager:stopMusic()

    --　統一影
    drawCanvas(obj.canvas,function()
        for i=0,7 do
            for j=0,7 do
                love.graphics.setColor(HSV(0.5+0.5*((i+j)%2),1,1,1))
                love.graphics.rectangle("fill",320*i,240*j,320,240)
                love.graphics.setColor(ASE.WHITE)
            end
        end
    end)

    O_Collision.new(0,0,obj.w,obj.size)
    O_Collision.new(0,0,obj.size,obj.h)
    O_Collision.new(0,obj.h-obj.size,obj.w-obj.size,obj.size)
    O_Collision.new(obj.w-obj.size,0,16,obj.h-obj.size)

    for i=0,6 do
      O_Shot.new(math.random(320*4),math.random(320*4))
    end
    
    for i=0,32 do
      O_Collision.new(math.random(320*4),math.random(320*4),64,64)
      O_String.new(math.random(320*4),math.random(320*4))
    end

    -- 雲作成
    
    obj.clouds = {}
    --[[
      for i = 0,32 do
        obj.clouds[i] = Vector.new(math.random(0,320*8),math.random(0,320*8))    
      end
    ]]

    -- なにこれ
    obj.sub = Top_Circle.new(300,100,4*16)
    
    maincam:setWorld(-320*8,-240*8,320*16,240*16)    
    
    return obj
  end;

  u = function(self,dt)
    self.frame = self.frame + 1
  end;

  draw = function(self)
    --オブジェクト
    --Sh_ClampColor:send("mouse",{love.mouse.getX(),love.mouse.getY()})
    Sh_ClampColor:send("resolution",{W,H})
    Sh_ClampColor:send("Time",self.frame/600)

    local t = self.frame % 360
    love.graphics.setShader(Sh_ClampColor)
    --地面
    love.graphics.setColor(ASE.WHITE)
    love.graphics.draw(self.canvas,0,0)
    drawCanvas(self.canvas_shade,function()
      love.graphics.clear( )
      self:objectDraw();
    end)

    love.graphics.setColor(ASE.WHITE)
    love.graphics.setColor(0.1, 0.0, 0, 0.7)
    love.graphics.draw(self.canvas_shade,-8,-8)
    love.graphics.setColor(1, 1, 1, 1)

    --オブジェクト描画
    self:objectDraw();

    -- キャンバスを分ける？
    for i,v in pairs(self.clouds) do
      local cloud = v
      love.graphics.setColor(0.0,0.0,0.0,0.1)
      love.graphics.circle("fill",cloud.x,cloud.y,128)
    end

    for i,v in pairs(self.clouds) do
      local cloud = v
      local hx = g_x + W/2 - cloud.x
      local hy = g_y + H/2  - cloud.y
      local gain = -2.6
      love.graphics.setColor(ASE.WHITE)
      love.graphics.circle("fill",cloud.x + hx/gain ,cloud.y + hy/gain,128)
      love.graphics.setShader()
    end
  
  end;
}
