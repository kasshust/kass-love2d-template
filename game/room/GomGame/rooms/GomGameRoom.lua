-- GomGameのデバッグルーム
DebugRoom_GomGame = {
    new = function(property)
      local obj = instance(DebugRoom_GomGame,OtherRoom,property)
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
          trans(T_normal,Room_GomGameTitle)
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


  -- タイトル
Room_GomGameTitle = {
  new = function(property)
  local obj = instance(Room_GomGameTitle,OtherRoom,property)
  obj.frame = 0
  obj.name = "model"
  --obj.title = load_image("game/materials/images/test/spr_jld.png")
  
  local music = love.audio.newSource("game/materials/sound/music/Music_Sea.mp3","stream")
  soundmanager:playMusic({music})
  
  obj.time = 0
  obj.line1 = {}
  obj.line2 = {}
  return obj
  end;
  u = function(self,dt)
    if controller.wasPressed("a") then 
      trans(T_normal,DebugRoom_GomGame_GameRoom) 
      --　ボリューム下げて止めたり
    end
  end;
  d = function(self)
  end;
  dg = function(self)
    self.time = self.time + 1

    love.graphics.setColor(ASE.BLACK)
    love.graphics.rectangle("fill",0,0,W,H)
    love.graphics.setColor(ASE.GREEN)
    love.graphics.setLineStyle( "rough")
    love.graphics.setLineWidth(1)
    love.graphics.setColor(ASE.WHITE)
    love.graphics.print("Title Press A",W/2,H/2)


  end;
}

-- オープニング
Room_GomGameOpening = {
  new = function(property)
    local obj = instance(Room_GomGameOpening,OtherRoom,property)
    obj.frame = 0
    obj.name = "model"
    obj.time = 0
    return obj
    end;
    u = function(self,dt)
      if controller.wasPressed("a") then 
        trans(Transition,Room_GomGameTitle) 
        --　ボリューム下げて止めたり
      end
    end;
    d = function(self)
    end;
    dg = function(self)
      love.graphics.setColor(ASE.BLACK)
      love.graphics.rectangle("fill",0,0,W,H)
      love.graphics.setColor(ASE.GREEN)
      love.graphics.setLineStyle( "rough")
      love.graphics.setLineWidth(1)
      love.graphics.setColor(ASE.WHITE)
      love.graphics.print("Opennig",W/2,H/2)
    end;
}

-- エンディング
Room_GomGameEnding = {
    new = function(property)
    local obj = instance(Room_GomGameEnding,OtherRoom,property)
    obj.frame = 0
    obj.name = ""
    obj.time = 0
    return obj
  end;
  u = function(self,dt)
  end;
  d = function(self)
  end;
  dg = function(self)
  end;
}


--デバッグ　ゲームルーム
DebugRoom_GomGame_GameRoom = {
  new = function(property)
    local obj = instance(DebugRoom_GomGame_GameRoom,BasicRoom,property)
    obj.name = "stage"
    obj.time = 0

    -- ルームサイズ設定
    obj.w = W*12
    obj.h = H*12
    obj.size = 16

    g_maincam:setWorld(0,0,obj.w,obj.h)    

    -- プレイヤー生成
    obj.player = O_Player.new(obj.w/2,obj.h/2)
    g_manager.game.playerManager:setPlayer(obj.player)

    --背景作成
    local image  = load_image("game/materials/images/test/grass.png")
    obj.backCanvas = {}
    obj.backCanvas[0] = love.graphics.newCanvas(obj.w, obj.h)
    obj.backCanvas[1] = love.graphics.newCanvas(obj.w, obj.h)
    obj.backCanvas[2] = love.graphics.newCanvas(obj.w, obj.h)

    obj.col  = {}
    obj.col[0] = ASE.GREEN
    obj.col[1] = ASE.BLUE
    obj.col[2] = ASE.RED
    for k = 0,2 do
    g.setCanvas(obj.backCanvas[k])
      --love.graphics.draw(image,0,0)
    --love.graphics.clear(ASE.Black)
      for i=0,10*8 do
        for j =0,10*8 do
          local size = 2
          local width = 2
          local height = 2
          love.graphics.draw(image,Image:getWidth()*i*size,Image:getHeight()*j*size,0,width,height)
          --love.graphics.setColor(obj.col[k])  
          --love.graphics.circle("fill", Image:getWidth()*i*size,Image:getHeight()*j*size, width, height)
        end
      end
     --love.graphics.rectangle("fill", 0, 0, 640*4, 640*4)
    g.setCanvas()
    obj.backCanvas[k]:setWrap("repeat","repeat")
    end
    
    -- 四方壁
    O_RectCollision.new(0,0,obj.w,obj.size)
    O_RectCollision.new(0,0,obj.size,obj.h)
    O_RectCollision.new(0,obj.h-obj.size,obj.w-obj.size,obj.size)
    O_RectCollision.new(obj.w-obj.size,0,16,obj.h-obj.size)

    --　敵生成
    for i=0,6 do
      O_Em0001.new(math.random(obj.w),math.random(obj.h))
    end

    -- 弾生成
    for i=0,64 do
      O_PlayerShot.new(math.random(obj.w),math.random(obj.h))
    end

    -- ルームフラグ
    obj.roomFlag = {
      clear = false,
    }
    
    return obj
  end;

  u = function(self,dt)
    -- クリア
    if true then
      self.roomFlag.clear = true
    end

    --クリア時処理
    if  self.roomFlag.clear == true then
      if controller.wasPressed("a") then
        trans(T_normal,DebugRoom_GomGame_GameRoom)
      end
    end

  end;

  draw = function(self)
    --オブジェクト
    self.frame = self.frame + 1
    local t = self.frame
    
    --地面
    love.graphics.setColor(ASE.WHITE)

    love.graphics.setColor(ASE.PINK)
    drawCanvas(self.backCanvas, function()
      local vec = perlinNoise(t/30)*200
    end)
    love.graphics.setColor(ASE.WHITE)

    --love.graphics.setScissor( g_x, g_y, W, H)
    Sh_Noise:send("CameraPos",{0,0})
    Sh_Noise:send("Time",t/60)
    love.graphics.setShader(Sh_Noise)
    
    for i = 0,1 do
      love.graphics.draw(self.backCanvas[i],0, 0)
    end
    g.setShader()
    --love.graphics.setScissor()

    Sh_Noise:send("Time",t)
    Sh_Noise:send("CameraPos",{(g_x + W/2),(g_y + H/2)})
   
    --オブジェクト描画
    self:objectDraw();

  end;

  drawGUI = function(self)
    if self.roomFlag.clear == true then
      --love.graphics.setColor(ASE.GREEN)
      --love.graphics.rectangle_c("fill",g_x+W/2,g_y+H/2,300,200)
      --love.graphics.setColor(ASE.WHITE)
      --love.graphics.rectangle_c("line",g_x+W/2,g_y+H/2,300,200)
      --love.graphics.print_c("Complete extinction",g_x+W/2,g_y+H/2)
    end

    BasicRoom.drawGUI(self)


  end;

  destroy = function(self)
    g_manager.game.playerManager:resetPlayer()
    if self.roomFlag.clear == true then
      --次ステージへ
    end
  end;
}

-- ゲームルーム
